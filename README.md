# Coalesce on null+empty
${FOO:-${BAR:-default}}

# Coalesce on null (unset)
${FOO-${BAR-default}}

# The Makefile list of targets
https://stackoverflow.com/questions/4219255/how-do-you-get-the-list-of-targets-in-a-makefile