# varnishstats-graphite
Bash Script to fetch variable stats data from Varnish and push it to graphite

## Requirements

The following requires to be present on the target system: 

* bc
* netcat

## Use

Configure GRAPHITE_PREFIX, GRAPHITE_HOST, GRAPHITE_PORT or use the defaults provided.

The script will fetch selected varnishstats data (configured in VARNISH_METRICS_ACCUMULATED), 
including the cache hitratio and push it graphite.




