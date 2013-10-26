PROMPT='%{$fg[blue]%}%n %{$fg[white]%}→%{$reset_color%} '
RPS1='%{$fg[white]%}%c $(git_custom_status)%{$reset_color%}'

PREFIX="["
SUFFIX="]"
GIT_DIRTY="%{$fg[red]%}"
GIT_CLEAN="%{$fg[green]%}"
GIT_UNTRACKED="%{$fg[yellow]%}"

git_custom_status() {
  local git_where="$(parse_git_branch)"
  [ -n "$git_where" ] && echo "$(custom_parse_git_dirty)$PREFIX${git_where#(refs/heads/|tags/)}$SUFFIX%{$reset_color%}"
}

parse_git_branch() {
  (git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD) 2>/dev/null
}

custom_parse_git_dirty() {
  gitstat=$(git status 2>/dev/null | grep '\(# Untracked\|# Changes\|# Changed but not updated:\)')

  if [[ $(echo ${gitstat} | grep -c "^# Changes to be committed:$") > 0 ]]; then
	echo -n "$GIT_DIRTY"
  fi

  if [[ $(echo ${gitstat} | grep -c "^\(# Untracked files:\|# Changed but not updated:\|# Changes not staged for commit:\)$") > 0 ]]; then
	echo -n "$GIT_UNTRACKED"
  fi 

  if [[ $(echo ${gitstat} | grep -v '^$' | wc -l | tr -d ' ') == 0 ]]; then
	echo -n "$GIT_CLEAN"
  fi
}