#!/bin/bash
echo "Generating txt"
/usr/local/bin/xml2rfc --text draft-mcconachie-dnsop-search-lists.xml

echo "Generating html"
/usr/local/bin/xml2rfc --html draft-mcconachie-dnsop-search-lists.xml

echo "Generating markdown"
/usr/bin/pandoc -f html -t gfm draft-mcconachie-dnsop-search-lists.html > README.md

/usr/bin/git status
