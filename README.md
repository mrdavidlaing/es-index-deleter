# es-index-deleter
Deletes all Elasticsearch indexes matching the pattern `logs-unparsed-*` every 10 minutes

# Pre-steps
  
    bundle package --all

# Push

```
cf target -o system -s elk-for-pcf
cf push --no-start
cf set-env es-index-deleter ES_MASTER_URL http://<elasticsearch_master_ip>:9200
cf set-health-check es-index-deleter none #If deploying to Diego
cf start es-index-deleter 
```
