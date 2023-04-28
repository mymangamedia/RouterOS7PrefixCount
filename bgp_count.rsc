/system script
add dont-require-permissions=no name=bgp_count policy=read \
    source="/routing/bgp/session {\r\
    \n   :global prefixes ({});\r\
    \n   :local maxlen 0;\r\
    \n   :foreach ses in=[find] do={\r\
    \n      :set \$remote [get \$ses \"remote.address\"]\r\
    \n      :set \$name [get \$ses name]\r\
    \n      :if ([:len \$name] > \$maxlen) do={\r\
    \n         :set \$maxlen [:len \$name]\r\
    \n      }\r\
    \n      :set (\$prefixes->\$name) [/routing/route/print count-only  where \
    belongs-to=\"bgp-IP-\$remote\"]\r\
    \n   }\r\
    \n   :set \$name \"Session                         \"\r\
    \n   :set \$name [:pick \$name 0 \$maxlen]\r\
    \n   :put \"\"\r\
    \n   :put \"\$name : Prefixes\"\r\
    \n   :put \"---------------------------\"\r\
    \n   :foreach name,prefix in=\$prefixes do={\r\
    \n      :set \$name (\$name.\"                              \")\r\
    \n      :set \$name [:pick \$name 0 \$maxlen]\r\
    \n      :put \"\$name : \$prefix\"\r\
    \n   }\r\
    \n}\r\
    \n"
