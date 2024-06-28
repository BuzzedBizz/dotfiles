# Prompt
setopt prompt_subst

function myPromptWidth() {
    PROMPT_PERCENT_OF_LINE=25
    echo $(( ${COLUMNS:-80} * PROMPT_PERCENT_OF_LINE / 100 ))
}
width_part='$(myPromptWidth)'

PROMPT='%F{236}%K{81} %n@%m %f%k' # username and machine
PROMPT+='%F{231}%K{236} %${width_part}<..<%3~ %f%k' # cwd
PROMPT+=' %# '
RPROMPT='%K{131}%F{232} %D{%H:%M:%S} %f%k' # time
unset width_part

