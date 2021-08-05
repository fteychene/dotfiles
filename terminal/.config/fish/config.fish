set fish_greeting ""

eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
eval (direnv hook fish)

thefuck --alias | source
starship init fish | source
 
# opam configuration
source /home/fteychene/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
source /home/fteychene/.config/completions/fish-kubectl-completions/completions/kubectl.fish

# Rust tool replacement
alias cat bat
alias grep rg
alias ls exa
alias du dust
alias tree br
alias find fd
