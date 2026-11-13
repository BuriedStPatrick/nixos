# Fuzzy navigate
navigate()
{
    navigating=true
    while $navigating
    do
        dest=$(ls -a | grep -vwFx '.' | fzf --reverse --cycle --height=25%)

        if [[ -d $dest ]]
        then
            cd $dest
        elif [[ -f $dest ]]
        then
            $EDITOR $dest
            navigating=false
        else
            navigating=false
        fi
    done
}

# Key binds
bindkey -s "^f" "navigate\n"
