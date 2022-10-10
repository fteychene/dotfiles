set fish_greeting ""

bass source ~/.profile
eval (direnv hook fish)

thefuck --alias | source
starship init fish | source

# OCAML
# # opam configuration
# source /home/fteychene/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

# Rust tool replacement
alias cat bat
alias grep rg
alias ls exa
alias du dust
alias find fd

# Haskell
if test -d "~/.ghcup"
    fish_add_path "~/.ghcup/bin"
end

# Brew completion
if test -d (brew --prefix)"/share/fish/completions"
    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/completions
end
if test -d (brew --prefix)"/share/fish/vendor_completions.d"
    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
end

# Kubernetes tooling
if test -d "~/.krew"
    fish_add_path "~/.krew/bin"
end

# GCloud sdk
if test -f "~/.google-cloud-sdk/"
    fish_add_path "~/.gcloud-sdk/bin"
    if test -f "~/.google-cloud-sdk/path.bash.inc"
        bass source "~/.google-cloud-sdk/path.bash.inc"
    end
    if test -f "~/.google-cloud-sdk/path.bash.inc"
        bass source "~/.google-cloud-sdk/completion.bash.inc"
    end
end

