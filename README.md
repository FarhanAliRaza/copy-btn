# Copy-btn

A silent, minimal Zsh plugin that allows you to copy the output of your last terminal command with a simple keyboard shortcut.

## Use Case
When coding with a llm you run a command and then copy paste the ouput to paste in the context of the llm. In this way you just have to use Alt [Option] + c to copy the output of your last command. Untill we don't need to do that  Adios 💀

## Features

- Silently captures the output of commands
- Copy with a simple `Alt+c` shortcut (configurable)
- Cross-platform support (macOS, Linux X11/Wayland, Windows WSL)
- Zero visual noise - no notifications or messages in your terminal
- Toggle the capture functionality on/off as needed

## Requirements

- Zsh shell
- One of these clipboard utilities:
  - macOS: `pbcopy` (built-in)
  - Linux X11: `xclip`
  - Linux Wayland: `wl-copy`
  - Windows WSL: `win32yank.exe`

## Installation

### Using the installer

```bash
# Clone the repository
git clone https://github.com/FarhanAliRaza/copy-btn.git
cd copy-btn

# Run the installer
./install.sh
```

### Manual installation

#### Oh My Zsh

```bash
# Clone the repository to Oh My Zsh custom plugins directory
git clone https://github.com/FarhanAliRaza/copy-btn.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/copy-btn

# Add copy-btn to your plugins in ~/.zshrc
# plugins=(... copy-btn)
```

#### Without a framework

```bash
# Clone the repository
git clone https://github.com/FarhanAliRaza/copy-btn.git ~/.zsh/plugins/copy-btn

# Add to your ~/.zshrc
echo "source ~/.zsh/plugins/copy-btn/copy-btn.plugin.zsh" >> ~/.zshrc
```

## Usage

1. Run any command in your terminal
2. Press `Alt+c` to copy the output to your clipboard (on macOS, use `Option+c` as Option is the equivalent of Alt)
3. Paste anywhere with `Ctrl+v` or `Cmd+v`

### Toggle capture on/off

If you want to temporarily disable/enable the output capture:

```bash
copy-btn-toggle
```

## Configuration

By default, `copy-btn` binds to `Alt+c` (on macOS, this is `Option+c`). To change this, add to your `~/.zshrc` after loading the plugin:

```bash
# Rebind to a different key (example: Ctrl+g)
bindkey "^g" copy-last-output
```

## How it works

1. The plugin silently captures the output of your commands
2. When you press the shortcut, it copies the last captured output to your clipboard
3. The plugin ignores certain commands (cd, clear, exit, etc.) to avoid undesired behavior

## License

This project is licensed under the [MIT License](LICENSE).
