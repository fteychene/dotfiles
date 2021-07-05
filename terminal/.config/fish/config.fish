set fish_greeting ""

export TERM=xterm
export JAVA_HOME=/usr/lib/jvm/default
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.ghcup/bin:$PATH"
export PATH="$HOME/.idea/bin:$PATH"
export PATH="$HOME/.concourse/bin:$PATH"

eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
eval (direnv hook fish)

thefuck --alias | source
starship init fish | source
 
# opam configuration
source /home/fteychene/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

alias cat bat
alias grep rg
alias ls exa
alias du dust
alias tree br
alias find fd