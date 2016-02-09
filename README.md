# varnishstats-graphite
Poor mans way of pushing varnish stats data to graphite with nothing but Bash.
Script fetch variable metrics from Varnish and pushes them to graphite

## Requirements
The following requires to be present on the target system: 

* bc
* netcat

## Use
Configure GRAPHITE_PREFIX, GRAPHITE_HOST, GRAPHITE_PORT or use the defaults provided.

The script will fetch selected varnishstats data (configured in VARNISH_METRICS_ACCUMULATED), 
including the cache hitratio and push it graphite.




