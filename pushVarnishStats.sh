#!/bin/bash
set -e

# Set up Graphite
GRAPHITE_PREFIX=""
GRAPHITE_HOST=localhost
GRAPHITE_PORT=2003

# The Metrics to query
VARNISH_METRICS_ACCUMULATED="MAIN.cache_hit MAIN.cache_miss MAIN.cache_hitpass MAIN.n_lru_nuked MAIN.n_object"

# function to calculate hitratio using "cache_hit/(cache_hit+cache_miss)"
function calculateCacheHits()
{
    local result=$1
	local calculation="scale=3;`varnishstat -1 -f MAIN.cache_hit | awk '{print $2}'`/(`varnishstat -1 -f MAIN.cache_hit | awk '{print $2}'`+`varnishstat -1 -f MAIN.cache_miss | awk '{print $2}'`)"
    local myresult=`echo ${calculation}|bc`
    eval $result="'$myresult'"
}

HOSTNAME=`hostname --fqdn | tr '.' '_'`
 
DATE=`date +%s`

for METRIC in $VARNISH_METRICS_ACCUMULATED
do
	# Send data to Graphite
	VALUE=`varnishstat -1 -f $METRIC | awk '{print $2}'`

	echo "${GRAPHITE_PREFIX}${HOSTNAME}.varnish.${METRIC} ${VALUE} ${DATE}" | nc ${GRAPHITE_HOST} ${GRAPHITE_PORT} || echo "e!"
done
calculateCacheHits HIT_RATIO
echo "${GRAPHITE_PREFIX}${HOSTNAME}.varnish.MAIN.hitratio ${HIT_RATIO} ${DATE}" | nc ${GRAPHITE_HOST} ${GRAPHITE_PORT} || echo "e!"
