# Setup fzf
# ---------
if [[ ! "$PATH" == */home/vaibhav18/AppImages/fzf-0.65.1/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/vaibhav18/AppImages/fzf-0.65.1/bin"
fi

eval "$(fzf --bash)"
