alias ee='exit'
alias nv='nvim'
#Admin VPS connection
alias yago='ssh macintoshi@84.201.184.79'

# print all current valid aliases
set toPrintAliases 'ran | tr0 | openprev | lsC | tl | tadd | td | gcm | gb | gc | gs | gsl | gyy | yy | yi | ys | tmuxa | tmuxl | gsendmr | gacp'
alias allaliases='echo (set_color yellow)List of all current aliases:; echo $toPrintAliases (set_color normal)'

# system & navigation
alias lrp='sudo lsof -P -i TCP -s TCP:LISTEN'
alias cl='clear'
alias ran='ranger'
alias …='tree . -L 1 -C'
alias …1='tree . -L 2 -C'
alias openprev='open -a preview'
alias lsC='ls -Fla --color'

# task
alias tl='task list'
alias tadd='task add'
alias td='task delete'

# git
alias gcm='git checkout master'
alias gb='git branch'
alias gc='git checkout'
alias gs='git stash'
alias gsl='git stash list'
alias gt='git status'
alias gcom='git commit'
alias gps='git push'
alias gpl='git pull'
alias ga='git add'
alias gcb='git checkout -b'
alias gdoall='git add . && git status && git commit --amend --no-edit --no-verify && git push -f'
alias gd='git diff'
alias grm='git rebase master'
alias grb='cit stash push -m "rebasing" && git checkout master %% git pull'

# NodeJS
alias gyy='git pull && yarn install && yarn start'
alias yy='yarn install && yarn start'
alias yi='yarn install'
alias ys='yarn start'

#tmux
alias tma='tmux attach -t'
alias tml='tmux ls'

function tsh-connect
  fish -c "tsh login --proxy=tsh.digital.r-one.io:443 --auth=local --user=gadzhiev.ig tsh.digital.r-one.io"
end

function gll
    set line1 $argv[1]
    set line2 $argv[2]
    set file $argv[3]

    fish -c "git log -L $line1,$line2:$file"
end

# Gitlab send merge request
# @param title
# @param description
# @param assignee
# @param branch
#
function gsendmr
    set title $argv[1]
    set description $argv[2]
    set assignee $argv[3]
    set branch $argv[4]

    echo (set_color green) "Creating merge request with" (set_color normal)
    echo (set_color green) "title ="(set_color yellow) $title (set_color normal)"" (set_color normal)
    echo (set_color green) "description ="(set_color yellow) $description (set_color normal)"" (set_color normal)
    echo (set_color green) "assignee ="(set_color yellow) $assignee (set_color normal)"" (set_color normal)
    echo (set_color green) "branch ="(set_color yellow) $branch (set_color normal)"" (set_color normal)

    fish -c "git push origin $branch -o merge_request.create \
        -o merge_request.title=$title \
        -o merge_request.description=$description \
        -o merge_request.assign=$assignee \
        -o merge_request.target=master
        "
end


function git-curl-mr
set $project = $argv[1]
set $branch = $argv[2]
set $sourceProjectId = $argv[3]
set $title = $argv[4]
set $description = $argv[5]
set $assigneeId = $argv[6]
  fish -c "
  curl 'https://gitlab.ertelecom.ru/web/$project/-/merge_requests' -X POST -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8' -H 'Accept-Language: en-US,en;q=0.5' -H 'Accept-Encoding: gzip, deflate, br' -H 'Referer: https://gitlab.ertelecom.ru/web/$project/-/merge_requests/new?merge_request%5Bsource_branch%5D=$branch&merge_request%5Bsource_project_id%5D=$sourceProjectId&merge_request%5Btarget_branch%5D=master&merge_request%5Btarget_project_id%5D=$sourceProjectId' -H 'Content-Type: application/x-www-form-urlencoded' -H 'Origin: https://gitlab.ertelecom.ru' -H 'DNT: 1' -H 'Connection: keep-alive' -H 'Cookie: diff_view=inline; sidebar_collapsed=false; frequently_used_emojis=white_check_mark%2Cok_hand; event_filter=all; collapsed_gutter=false; _gitlab_session=d6a8409996aa2fc0e9401544a8e948b9; hide_broadcast_message_18=true' -H 'Upgrade-Insecure-Requests: 1' -H 'Sec-Fetch-Dest: document' -H 'Sec-Fetch-Mode: navigate' -H 'Sec-Fetch-Site: same-origin' -H 'Sec-Fetch-User: ?1' -H 'Sec-GPC: 1' -H 'Pragma: no-cache' -H 'Cache-Control: no-cache' -H 'TE: trailers' --data-raw 'utf8=%E2%9C%93&authenticity_token=8eWQuOfN%2FRfuqANOol1h5cC1Pla1cUCTVkJtC4UsQATjteypQW0dithICXc2ZeP%2FLQ4qzxSdi8D6prkjpmSiEg%3D%3D&merge_request%5Btitle%5D=$title&merge_request%5Bdescription%5D=$description%5Bassignee_ids%5D%5B%5D=$assigneeId&merge_request%5Blabel_ids%5D%5B%5D=&merge_request%5Bforce_remove_source_branch%5D=0&merge_request%5Bforce_remove_source_branch%5D=1&merge_request%5Bsquash%5D=0&merge_request%5Block_version%5D=0&merge_request%5Bsource_project_id%5D=$sourceProjectId&merge_request%5Bsource_branch%5D=$branch&merge_request%5Btarget_project_id%5D=$sourceProjectId&merge_request%5Btarget_branch%5D=master'
  "
end

function gpr
    set branch $argv[1]
    fish -c "git push --set-upstream origin $branch"
end

# tig TUI
function tig-commits-by-author
    set author $argv[1]
    fish -c "git rev-list --author=$author HEAD | tig show --stdin"
end

# Make GIt browse straight to original repo and get the link of file/lines
function gbr
    set filePath $argv[1]
    set gitOriginURI (git config --get remote.origin.url | sed 's/.\{4\}$//')
    set projectName (git config --local remote.origin.url | sed -n 's#.*/\([^.]*\)\.git#\1#p')
    set remoteURI "$gitOriginURI/-/tree/master/$filePath"
    fish -c "echo $remoteURI | pbcopy"
    fish -c "open $remoteURI"
end

# Some custom usefull scripts
function tk
  # function to cut token from http:perm.dom.ru?token=…
  set uri $argv[1]
  set regexp '(?<=token=)[^&]*'
  fish -c "string match -r '$regexp' '$uri' | pbcopy"
end
