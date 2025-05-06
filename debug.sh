#!/bin/bash

# This script helps to debug the copy-btn plugin

echo "Copy-btn Debug Helper"
echo "===================="
echo ""

# Check if the plugin is loaded in the current Zsh session
if zsh -c "type copy-last-output >/dev/null 2>&1"; then
  echo "✅ Plugin appears to be loaded properly"
else
  echo "❌ Plugin is NOT loaded in your current Zsh session"
  echo "Try: source ~/path/to/copy-btn.plugin.zsh"
  echo ""
fi

# Check for clipboard utilities
echo "Checking clipboard utilities:"
if command -v pbcopy >/dev/null 2>&1; then
  echo "✅ pbcopy found (macOS)"
elif command -v xclip >/dev/null 2>&1; then
  echo "✅ xclip found (Linux X11)"
elif command -v wl-copy >/dev/null 2>&1; then
  echo "✅ wl-copy found (Linux Wayland)"
elif command -v win32yank.exe >/dev/null 2>&1; then
  echo "✅ win32yank.exe found (Windows WSL)"
else
  echo "❌ No clipboard utility found. Install one of the following:"
  echo "  - macOS: pbcopy (built-in)"
  echo "  - Linux X11: xclip (sudo apt-get install xclip)"
  echo "  - Linux Wayland: wl-clipboard (sudo apt-get install wl-clipboard)"
  echo "  - Windows WSL: win32yank.exe"
fi

echo ""
echo "Manual Testing Instructions:"
echo "1. In your Zsh terminal, run: source $(pwd)/copy-btn.plugin.zsh"
echo "2. Run a command like 'ls -la'"
echo "3. You should see [Copy] button at the end of output"
echo "4. If not, run 'force-copy-btn' to manually trigger the button"
echo "5. You can also try 'debug-copy-btn' to see if output is being captured"
echo ""
echo "Common issues:"
echo "- The Zsh version might be too old (need 5.0+)"
echo "- Terminal might not support required features"
echo "- Plugin might conflict with other Zsh plugins"
echo ""
echo "Testing direct copy functionality:"
echo "Sample text to copy" 
echo "Press Alt+c now to copy this text using the plugin's shortcut" 