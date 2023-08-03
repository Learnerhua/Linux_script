# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=
# User specific aliases and functions
alias work='cd /RAID5_32T/oyjh'
alias la='ls -a'
alias prottest='java -jar /RAID5_32T/oyjh/Download/prottest-3.4.2/prottest-3.4.2.jar'
export PS1='[\[\e[35;1m\]\u\[\e[31;1m\]@\[\e[34;1m\]\h\[\e[33;1m\]\w]\[\e[36;1m\]$ \[\e[0m\]'
export PATH="/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin"
export PERL5LIB="/RAID5_32T/oyjh/miniconda3/lib/perl5"



# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/RAID5_32T/oyjh/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/RAID5_32T/oyjh/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/RAID5_32T/oyjh/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/RAID5_32T/oyjh/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

