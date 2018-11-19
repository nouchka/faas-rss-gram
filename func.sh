#!/bin/bash

set -- "${1:-$(</dev/stdin)}" "${@:2}"

main() {
  check_args "$@"
  local feed_url=$1
  HTTP_CODE=$(curl -s -o /tmp/feed -w "%{http_code}" $feed_url)
  if [ "$HTTP_CODE" == "200" ]; then
    cat /tmp/feed
  else
    echo '<rss xmlns:admin="http://webns.net/mvcb/" xmlns:atom="http://www.w3.org/2005/Atom" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:media="http://search.yahoo.com/mrss/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:sy="http://purl.org/rss/1.0/modules/syndication/" version="2.0"></rss>'
  fi
}

check_args() {
  if (($# != 1)); then
    echo "Error:
    1 arguments must be provided - $# provided.
  
    Usage:
      rss-gram <url>
      
Aborting."
    exit 1
  fi
}

main $1

