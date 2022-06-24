# Coalesce on null+empty
${FOO:-${BAR:-default}}

# Coalesce on null (unset)
${FOO-${BAR-default}}
