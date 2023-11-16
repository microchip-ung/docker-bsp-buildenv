alias h='history'
alias ll='ls -lah'
alias pse='ps -e'

# Use htmlproofer to validate links in a site (folder)
function linkcheck() {
    htmlproofer --enforce-https=false --disable-external=false --ignore-urls "../..","../../.." --ignore-status-codes 403 /bsp/docs/build/site/bsp
}
