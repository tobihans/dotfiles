# Terminal

alias cat = bat
# alias core-ls = ls
alias ll = eza --icons --oneline --hyperlink
alias dir = eza --icons -long --hyperlink --group --smart-group --header

alias kcat = kitten icat
alias kdiff = kitten diff
alias kgrep = kitten hyperlinked_grep
alias kclip = kitten clipboard
alias ksh = kitten ssh
alias kctl = kubectl

# Dotfiles management

alias cz = chezmoi
alias cza = chezmoi add
alias czcd = chezmoi cd
alias cze = chezmoi edit
alias czs = chezmoi status
alias czaa = chezmoi apply
alias czea = chezmoi edit --apply
alias czra = chezmoi re-add
alias cgit = chezmoi git -- 
alias cgis = chezmoi git -- status 
alias cgid = chezmoi git -- diff 
alias cgtc = chezmoi git -- commit 

# Git

alias gis = git status
alias gid = git diff
alias ga. = git add .
alias gpsh = git push
alias gpll = git pull
alias gtc = git commit
alias gie = nano .git/info/exclude

# Docker

alias di = docker images
# alias dangling = docker images -f "dangling=true" -q | split row "\n" | each { |e| if $e != "" { docker rmi -f $e } }

# Coding helpers

alias art = php artisan
alias mng = python manage.py
alias style = ruff format
alias mkube = minikube
alias supabase = npx supabase
alias http = python3 -m http.server
alias gpd = gitpod
alias j = just
alias pnx = pnpm dlx
alias smee = npx smee-client
alias act = gh act
alias gl = glab

# Command line tools

alias lzd = lazydocker
alias lzg = lazygit
alias tv = tidy-viewer
alias prism = npx @stoplight/prism-cli@latest # api mocking
alias cookiecutter = pipx run cookiecutter
alias hackrnews = clx -n

# alias load.env = 'while read -r line; do export $line; done < .env;'

alias pj = /usr/bin/env python3 -m json.tool
alias jitsi-link = python -c 'import uuid; print(f"https://meet.jit.si/{uuid.uuid4()}")'
