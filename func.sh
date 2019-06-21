#!/bin/bash

set -- "${1:-$(</dev/stdin)}" "${@:2}"

main() {
  check_args "$@"
  local feed_url=$(echo $1| sed "s/https\:\/\/web\.stagram.com\/rss\/n\///")
  HTTP_CODE=$(curl -s -o /tmp/feed -w "%{http_code}" https://queryfeed.net/instagram?q=$feed_url)
  if [ "$HTTP_CODE" == "200" ]; then
    cat /tmp/feed
  else
    echo '<rss xmlns:admin="http://webns.net/mvcb/" xmlns:atom="http://www.w3.org/2005/Atom" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:media="http://search.yahoo.com/mrss/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:sy="http://purl.org/rss/1.0/modules/syndication/" version="2.0"><channel><title>not-loading</title><link>'$feed_url'</link><description>RSS Feed - GGT '$feed_url'</description><dc:language>en</dc:language><dc:creator>GGT</dc:creator><pubDate>'$(date -R)'</pubDate><atom:link href="'$feed_url'" rel="self" type="application/rss+xml"></atom:link><channel></channel></rss>'
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

if [ "$Http_Path" != "" ]; then
	main "https:/"$Http_Path
else
	main $1
fi

