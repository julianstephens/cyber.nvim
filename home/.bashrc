# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# SSH Config
if [ -z "$SSH_AUTH_SOCK"  ] ; then
      eval `ssh-agent -s`
        ssh-add
fi

# Go Config
export GOROOT=/usr/local/go
export GOPATH=~/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# fzf
export FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --preview 'bat --color=always --style=header,grid --line-range :300 {}'"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export TMPDIR="/tmp"

# Created by `pipx` on 2021-11-29 14:21:40
export PATH="$PATH:/home/julian/.local/bin"
export PATH="$PATH:/home/julian/.cargo/bin"

source ~/.ydl.sh

alias luamake=/home/julian/.config/nvim/lua-language-server/3rd/luamake/luamake

# Load Angular CLI autocompletion.
source <(ng completion script)
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval # bash completion V2 for gh                                   -*- shell-script -*-

__gh_debug()
{
    if [[ -n ${BASH_COMP_DEBUG_FILE:-} ]]; then
        echo "$*" >> "${BASH_COMP_DEBUG_FILE}"
    fi
}

# Macs have bash3 for which the bash-completion package doesn't include
# _init_completion. This is a minimal version of that function.
__gh_init_completion()
{
    COMPREPLY=()
    _get_comp_words_by_ref "$@" cur prev words cword
}

# This function calls the gh program to obtain the completion
# results and the directive.  It fills the 'out' and 'directive' vars.
__gh_get_completion_results() {
    local requestComp lastParam lastChar args

    # Prepare the command to request completions for the program.
    # Calling ${words[0]} instead of directly gh allows to handle aliases
    args=("${words[@]:1}")
    requestComp="${words[0]} __complete ${args[*]}"

    lastParam=${words[$((${#words[@]}-1))]}
    lastChar=${lastParam:$((${#lastParam}-1)):1}
    __gh_debug "lastParam ${lastParam}, lastChar ${lastChar}"

    if [ -z "${cur}" ] && [ "${lastChar}" != "=" ]; then
        # If the last parameter is complete (there is a space following it)
        # We add an extra empty parameter so we can indicate this to the go method.
        __gh_debug "Adding extra empty parameter"
        requestComp="${requestComp} ''"
    fi

    # When completing a flag with an = (e.g., gh -n=<TAB>)
    # bash focuses on the part after the =, so we need to remove
    # the flag part from $cur
    if [[ "${cur}" == -*=* ]]; then
        cur="${cur#*=}"
    fi

    __gh_debug "Calling ${requestComp}"
    # Use eval to handle any environment variables and such
    out=$(eval "${requestComp}" 2>/dev/null)

    # Extract the directive integer at the very end of the output following a colon (:)
    directive=${out##*:}
    # Remove the directive
    out=${out%:*}
    if [ "${directive}" = "${out}" ]; then
        # There is not directive specified
        directive=0
    fi
    __gh_debug "The completion directive is: ${directive}"
    __gh_debug "The completions are: ${out[*]}"
}

__gh_process_completion_results() {
    local shellCompDirectiveError=1
    local shellCompDirectiveNoSpace=2
    local shellCompDirectiveNoFileComp=4
    local shellCompDirectiveFilterFileExt=8
    local shellCompDirectiveFilterDirs=16

    if [ $((directive & shellCompDirectiveError)) -ne 0 ]; then
        # Error code.  No completion.
        __gh_debug "Received error from custom completion go code"
        return
    else
        if [ $((directive & shellCompDirectiveNoSpace)) -ne 0 ]; then
            if [[ $(type -t compopt) = "builtin" ]]; then
                __gh_debug "Activating no space"
                compopt -o nospace
            else
                __gh_debug "No space directive not supported in this version of bash"
            fi
        fi
        if [ $((directive & shellCompDirectiveNoFileComp)) -ne 0 ]; then
            if [[ $(type -t compopt) = "builtin" ]]; then
                __gh_debug "Activating no file completion"
                compopt +o default
            else
                __gh_debug "No file completion directive not supported in this version of bash"
            fi
        fi
    fi

    if [ $((directive & shellCompDirectiveFilterFileExt)) -ne 0 ]; then
        # File extension filtering
        local fullFilter filter filteringCmd

        # Do not use quotes around the $out variable or else newline
        # characters will be kept.
        for filter in ${out[*]}; do
            fullFilter+="$filter|"
        done

        filteringCmd="_filedir $fullFilter"
        __gh_debug "File filtering command: $filteringCmd"
        $filteringCmd
    elif [ $((directive & shellCompDirectiveFilterDirs)) -ne 0 ]; then
        # File completion for directories only

        # Use printf to strip any trailing newline
        local subdir
        subdir=$(printf "%s" "${out[0]}")
        if [ -n "$subdir" ]; then
            __gh_debug "Listing directories in $subdir"
            pushd "$subdir" >/dev/null 2>&1 && _filedir -d && popd >/dev/null 2>&1 || return
        else
            __gh_debug "Listing directories in ."
            _filedir -d
        fi
    else
        __gh_handle_completion_types
    fi

    __gh_handle_special_char "$cur" :
    __gh_handle_special_char "$cur" =
}

__gh_handle_completion_types() {
    __gh_debug "__gh_handle_completion_types: COMP_TYPE is $COMP_TYPE"

    case $COMP_TYPE in
    37|42)
        # Type: menu-complete/menu-complete-backward and insert-completions
        # If the user requested inserting one completion at a time, or all
        # completions at once on the command-line we must remove the descriptions.
        # https://github.com/spf13/cobra/issues/1508
        local tab comp
        tab=$(printf '\t')
        while IFS='' read -r comp; do
            # Strip any description
            comp=${comp%%$tab*}
            # Only consider the completions that match
            comp=$(compgen -W "$comp" -- "$cur")
            if [ -n "$comp" ]; then
                COMPREPLY+=("$comp")
            fi
        done < <(printf "%s\n" "${out[@]}")
        ;;

    *)
        # Type: complete (normal completion)
        __gh_handle_standard_completion_case
        ;;
    esac
}

__gh_handle_standard_completion_case() {
    local tab comp
    tab=$(printf '\t')

    local longest=0
    # Look for the longest completion so that we can format things nicely
    while IFS='' read -r comp; do
        # Strip any description before checking the length
        comp=${comp%%$tab*}
        # Only consider the completions that match
        comp=$(compgen -W "$comp" -- "$cur")
        if ((${#comp}>longest)); then
            longest=${#comp}
        fi
    done < <(printf "%s\n" "${out[@]}")

    local completions=()
    while IFS='' read -r comp; do
        if [ -z "$comp" ]; then
            continue
        fi

        __gh_debug "Original comp: $comp"
        comp="$(__gh_format_comp_descriptions "$comp" "$longest")"
        __gh_debug "Final comp: $comp"
        completions+=("$comp")
    done < <(printf "%s\n" "${out[@]}")

    while IFS='' read -r comp; do
        COMPREPLY+=("$comp")
    done < <(compgen -W "${completions[*]}" -- "$cur")

    # If there is a single completion left, remove the description text
    if [ ${#COMPREPLY[*]} -eq 1 ]; then
        __gh_debug "COMPREPLY[0]: ${COMPREPLY[0]}"
        comp="${COMPREPLY[0]%% *}"
        __gh_debug "Removed description from single completion, which is now: ${comp}"
        COMPREPLY=()
        COMPREPLY+=("$comp")
    fi
}

__gh_handle_special_char()
{
    local comp="$1"
    local char=$2
    if [[ "$comp" == *${char}* && "$COMP_WORDBREAKS" == *${char}* ]]; then
        local word=${comp%"${comp##*${char}}"}
        local idx=${#COMPREPLY[*]}
        while [[ $((--idx)) -ge 0 ]]; do
            COMPREPLY[$idx]=${COMPREPLY[$idx]#"$word"}
        done
    fi
}

__gh_format_comp_descriptions()
{
    local tab
    tab=$(printf '\t')
    local comp="$1"
    local longest=$2

    # Properly format the description string which follows a tab character if there is one
    if [[ "$comp" == *$tab* ]]; then
        desc=${comp#*$tab}
        comp=${comp%%$tab*}

        # $COLUMNS stores the current shell width.
        # Remove an extra 4 because we add 2 spaces and 2 parentheses.
        maxdesclength=$(( COLUMNS - longest - 4 ))

        # Make sure we can fit a description of at least 8 characters
        # if we are to align the descriptions.
        if [[ $maxdesclength -gt 8 ]]; then
            # Add the proper number of spaces to align the descriptions
            for ((i = ${#comp} ; i < longest ; i++)); do
                comp+=" "
            done
        else
            # Don't pad the descriptions so we can fit more text after the completion
            maxdesclength=$(( COLUMNS - ${#comp} - 4 ))
        fi

        # If there is enough space for any description text,
        # truncate the descriptions that are too long for the shell width
        if [ $maxdesclength -gt 0 ]; then
            if [ ${#desc} -gt $maxdesclength ]; then
                desc=${desc:0:$(( maxdesclength - 1 ))}
                desc+="…"
            fi
            comp+="  ($desc)"
        fi
    fi

    # Must use printf to escape all special characters
    printf "%q" "${comp}"
}

__start_gh()
{
    local cur prev words cword split

    COMPREPLY=()

    # Call _init_completion from the bash-completion package
    # to prepare the arguments properly
    if declare -F _init_completion >/dev/null 2>&1; then
        _init_completion -n "=:" || return
    else
        __gh_init_completion -n "=:" || return
    fi

    __gh_debug
    __gh_debug "========= starting completion logic =========="
    __gh_debug "cur is ${cur}, words[*] is ${words[*]}, #words[@] is ${#words[@]}, cword is $cword"

    # The user could have moved the cursor backwards on the command-line.
    # We need to trigger completion from the $cword location, so we need
    # to truncate the command-line ($words) up to the $cword location.
    words=("${words[@]:0:$cword+1}")
    __gh_debug "Truncated words[*]: ${words[*]},"

    local out directive
    __gh_get_completion_results
    __gh_process_completion_results
}

if [[ $(type -t compopt) = "builtin" ]]; then
    complete -o default -F __start_gh gh
else
    complete -o default -o nospace -F __start_gh gh
fi

for file in $(fd . '/home/julian/dotfiles/project-templates/' -t 'f' -e 'sh'); do 
    source $file 
done

source /etc/bash_completion.d/git-prompt
