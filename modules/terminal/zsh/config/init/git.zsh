#!/bin/zsh

git_delete_local_stale_branches() {
  read "y?This will delete all local branches that don't exist remotely. Are you sure? [y/N] "
  case $y in
    [Yy]* ) git fetch --all -p; git branch -vv | grep ": gone]" | awk '{ print $1 }' | xargs -n 1 git branch -D; return;;
    * ) return;;
  esac
}

# Show files ranked by highest churn over the last year
git_rank_churn_by_file() {
  git log --format=format: --name-only --since="1 year ago" \
    | sort \
    | uniq -c \
    | sort -nr \
    | head -20
}

# Show authors ranked by highest commit churn over the last year
git_rank_churn_by_author() {
  git shortlog \
    -sn \
    --no-merges \
    --since="1 year ago"
}

# Show files ranked by amount of bug fix commits over the last year
git_rank_bugs_by_file() {
  git log -i -E \
    --grep="fix|bug|broken|hotfix" \
    --name-only --format='' \
    --since="1 year ago" \
    | sort \
    | uniq -c \
    | sort -nr \
    | head -20
}

# Show commit amounts by month over the last year
git_rank_commits_by_month(){
  git log \
    --format='%ad' \
    --date=format:'%Y-%m' \
    --since="1 year ago" \
    | sort \
    | uniq -c
}

git_delete_branch() {
  current_branch=$(git branch --show-current)
  git checkout $@ --quiet
  remote=$(git status -sb --porcelain | sed -n "s/^.*\.\.\.\(\S*\)\/.*$/\1/p")

  git checkout $current_branch --quiet
  git branch -d $@ -D

  if [[ ! -z "${remote// }" ]]
    then
      read "yn?Delete on $remote as well? [y/N] "
      case $yn in
        [Yy]* ) git push $remote :$@; return;;
        [Nn]* ) return;;
        * ) return;;
      esac
  fi
}

git_tree() {
  git log --graph --decorate --oneline --color | less -R
}

git_commit_and_push() {
  git add --all
  git commit -m "$@"
  git push
}

git_commit_all() {
  git add --all
  git commit -m $@
}

git_create_branch() {
  git branch $@
  git checkout $@

  remote=$(git remote | head -1)

  read "yn?Push to $remote as well? [y/N] "
  case $yn in
    [Yy]* ) git push -u $remote $@; return;;
    [Nn]* ) return;;
    * ) return;;
  esac
}

git_merge_branch_interactive() {
  has_diff=$(git diff --no-color)

  if [[ ${has_diff} ]]
  then
    >&2 echo "Please commit or stage changes before merging branches."
    return
  fi

  remote=$(git remote | head -1)
  current_branch=$(git rev-parse --abbrev-ref HEAD)
  local_branches=$(git branch -l --no-color --no-column | grep -iv "*" | tr -d '[:blank:]')
  remote_branches=$(git for-each-ref --format='%(refname:strip=2)' refs/remotes/${remote} | grep -iv "${remote}/HEAD")

  all_branches=("${local_branches[@]}" "${remote_branches[@]}")
  selected_branch=$(echo "${all_branches}" | sed 's/ /\n/' | fzf --layout reverse-list)

  if [[ ! ${selected_branch} ]]
  then
    >&2 echo "No selected branch, abandoning."
    return
  fi

  # if remote branch was selected
  if [[ ${selected_branch} == "${remote}/"* ]]
  then
    # String the remote from the name
    selected_branch=$(echo ${selected_branch} | sed "s/${remote}\///")
  fi

  git merge --ff-only ${selected_branch}
}

git_switch_branch_interactive() {
  has_diff=$(git diff --no-color)
  if [[ ${has_diff} ]]
  then
    >&2 echo "Please commit or stage changes before changing branch."
    return
  fi

  remote=$(git remote | head -1)
  current_branch=$(git rev-parse --abbrev-ref HEAD)
  local_branches=$(git branch -l --no-color --no-column | grep -iv "*" | tr -d '[:blank:]')
  remote_branches=$(git for-each-ref --format='%(refname:strip=2)' refs/remotes/${remote} | grep -iv "${remote}/HEAD")

  all_branches=("${local_branches[@]}" "${remote_branches[@]}")
  selected_branch=$(echo "${all_branches}" | sed 's/ /\n/' | fzf --layout reverse-list)

  if [[ ! ${selected_branch} ]]
  then
    >&2 echo "No selected branch, abandoning."
    return
  fi

  # if remote branch was selected
  if [[ ${selected_branch} == "${remote}/"* ]]
  then
    # String the remote from the name
    selected_branch=$(echo ${selected_branch} | sed "s/${remote}\///")
  fi

  git switch ${selected_branch}
}

# Squash any number of commits backwards from current HEAD
git_squash_commits() {
  if [[ ! "$@" ]]
  then
    >&2 echo "ERR: amount of commits to squash required"
    return
  fi

  # Reset the current branch to the commit just before the last N:
  git reset --hard HEAD~$@

  # HEAD@{1} is where the branch was just before the previous command.
  # This command sets the state of the index to be as it would just
  # after a merge from that commit:
  git merge --squash HEAD@{1}

  # Commit those squashed changes. The commit message wil be helpfully
  # prepopulated with the commit messages of all the squashed commits:
  git commit
}

# Squash commits from specific hash to HEAD
git_squash_commits_to_head_from() {
  if [[ ! "$@" ]]
  then
    >&2 echo "ERR: git hash is required"
    return
  fi

  distance_to_commit=$(git rev-list "$@..HEAD" | wc -l)
  git_squash_commits $distance_to_commit
}

git_commits_of_current_branch() {
  current_branch=$(git rev-parse --abbrev-ref HEAD)
  first_commit_hash=$(git_first_commit_of_branch ${current_branch})

  git log "${first_commit_hash}..${current_branch}" --pretty=format:'%H'
}

git_first_commit_of_branch() {
  git log "$@" --pretty=format:'%H' | tail -1
}

git_squash_current_branch() {
  first_commit_of_current_branch=$(git_commits_of_current_branch | tail -1)
  git_squash_commits_to_head_from ${first_commit_of_current_branch}
}

alias c='git commit -m'
alias st='git status'
alias ca='git_commit_all'
alias cap='git_commit_and_push'
alias p='git push'
alias pt='git push --tags'
alias pf='git push --force-with-lease'
alias pl='git pull --rebase'
alias cb='git_create_branch'
alias rb='git rebase'
alias b='git checkout'
alias db='git_delete_branch'
alias gt='git_tree'
alias m='git merge --ff-only'
alias cr='git_delete_local_stale_branches'
alias g='gitui'
alias squash='git_squash_commits'
alias squash_from='git_squash_commits_to_head_from'
alias squash_branch='git_squash_current_branch'

# Keybinds
bindkey -s "^g" "gitui\n"
bindkey -s "^b" "git_switch_branch_interactive\n"
