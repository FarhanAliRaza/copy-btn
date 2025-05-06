#!/usr/bin/env zsh

# This ensures the script can be sourced in both Bash and Zsh
# Detect if script is being sourced in Bash
if [[ -n "${BASH_SOURCE[0]}" && "${BASH_SOURCE[0]}" != "${0}" ]]; then
  # We're in Bash and being sourced
  _SCRIPT_PATH="${BASH_SOURCE[0]}"
else
  # We're in Zsh
  _SCRIPT_PATH="${(%):-%N}"
fi

# Define colors and symbols
copy_success="%F{green}%B✓ Copied!%b%f"

# Dependency checking
if ! command -v xclip &> /dev/null && ! command -v pbcopy &> /dev/null && ! command -v wl-copy &> /dev/null && ! command -v win32yank.exe &> /dev/null; then
  # Silent failure - don't show any messages
  return 1
fi

# Copy to clipboard function
copy_to_clipboard() {
  local content=$1
  if command -v pbcopy &> /dev/null; then
    # macOS
    echo -n "$content" | pbcopy
  elif command -v xclip &> /dev/null; then
    # Linux with X11
    echo -n "$content" | xclip -selection clipboard
  elif command -v wl-copy &> /dev/null; then
    # Linux with Wayland
    echo -n "$content" | wl-copy
  elif command -v win32yank.exe &> /dev/null; then
    # Windows WSL
    echo -n "$content" | win32yank.exe -i --crlf
  fi
}

# Global variables
typeset -g COPY_BTN_OUTPUT=""
typeset -g COPY_BTN_CURRENT_CMD=""
typeset -g COPY_BTN_ENABLED=1
typeset -g COPY_BTN_CMDS_TO_IGNORE=(clear cd pushd popd exit fg bg jobs zle bindkey history fc script source)

# Function to toggle output capture
copy-btn-toggle() {
  if [[ $COPY_BTN_ENABLED -eq 1 ]]; then
    COPY_BTN_ENABLED=0
    # Removed debug output
  else
    COPY_BTN_ENABLED=1
    # Removed debug output
  fi
}

# Function to be executed before a command is executed
copy_btn_preexec() {
  # Skip if feature is disabled
  if [[ $COPY_BTN_ENABLED -eq 0 ]]; then
    return
  fi

  # Save the command being executed
  COPY_BTN_CURRENT_CMD="$1"
  
  # Skip certain commands we don't want to capture
  for cmd in "${COPY_BTN_CMDS_TO_IGNORE[@]}"; do
    if [[ "$COPY_BTN_CURRENT_CMD" == "$cmd"* ]]; then
      # Command is in ignore list, skip it
      COPY_BTN_CURRENT_CMD=""
      return
    fi
  done
}

# Function to be executed after a command is executed
copy_btn_precmd() {
  # Skip if feature is disabled
  if [[ $COPY_BTN_ENABLED -eq 0 ]]; then
    return
  fi
  
  # Skip if no command was saved
  if [[ -z "$COPY_BTN_CURRENT_CMD" ]]; then
    return
  fi
  
  # Get current date for a unique identifier
  local timestamp=$(date +%s)
  
  # Create a temporary file
  local tmp_file="/tmp/copy_btn_output_$timestamp.txt"
  
  # Re-run the command to capture output, but silently
  eval "$COPY_BTN_CURRENT_CMD" >| "$tmp_file" 2>&1
  
  # Read captured output
  COPY_BTN_OUTPUT=$(cat "$tmp_file")
  rm -f "$tmp_file"
  
  # Reset current command
  COPY_BTN_CURRENT_CMD=""
}

# Function to copy output of the last command
copy-last-output() {
  if [[ -n "$COPY_BTN_OUTPUT" ]]; then
    copy_to_clipboard "$COPY_BTN_OUTPUT"
    # No output/messages - completely silent operation
  fi
}

# Add the preexec and precmd hooks
autoload -Uz add-zsh-hook
add-zsh-hook preexec copy_btn_preexec
add-zsh-hook precmd copy_btn_precmd

# Register the function as a Zsh widget for key binding
zle -N copy-last-output
# Bind to Alt+c by default
bindkey "^[c" copy-last-output

# Removed all plugin loaded messages 