set fish_greeting ""

eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
eval (direnv hook fish)

thefuck --alias | source
starship init fish | source
 
# opam configuration
source /home/fteychene/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

# Rust tool replacement
alias cat bat
alias grep rg
alias ls exa
alias du dust
alias tree br
alias find fd

# Brew completion
if test -d (brew --prefix)"/share/fish/completions"
    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/completions
end
if test -d (brew --prefix)"/share/fish/vendor_completions.d"
    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
end