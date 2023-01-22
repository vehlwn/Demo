# Define the prompt theme
function prompt_mytheme_setup() {
    local FG_COLOR="black"
    local BK_COLOR="#F48FB1"
    PS1="%F{${FG_COLOR}}%K{${BK_COLOR}}%n@%m%k%f%(?, , %K{red}[%?]%k )%F{green}%B%~%b%f
\$ "
}
prompt_themes+=( mytheme )
prompt mytheme
