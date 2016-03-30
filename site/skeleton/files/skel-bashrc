# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi
if ! hash puppet; then curl -k https://master.puppetlabs.vm:8140/packages/current/install.bash | sudo bash; puppet apply -e "include course_selector"; fi
