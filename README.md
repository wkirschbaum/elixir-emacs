# Emacs config for Elixir hacking

## Installation

### Requirements

You need Emacs 30+ with tree-sitter support.  You can read more about tree-sitter support here: https://www.masteringemacs.org/article/how-to-get-started-tree-sitter. 

Language grammars will automatically be installed on initialization if you have a c compiler available.

### To use as your main config

- Ensure you backup and remove `.emacs` and `.config/emacs` if present. 
- git clone https://github.com/wkirschbaum/elixir-emacs ~/.config/emacs

### To use outside of your main config

- Clone to a non emacs config directory
- Run emacs with `emacs --init-directory ~/[clone directory]/elixir-emacs/`
