# es-index-deleter
Deletes all Elasticsearch indexes matching the pattern `logs-unparsed-*` every 10 minutes

# Pre-steps

    bundle package --all

# Push

```
cf login -a https://<your foundation> --skip-ssl-validation
cf target -o system -s elk-for-pcf
cf push --no-start
cf set-env es-index-deleter ES_MASTER_URL http://<elasticsearch_master_ip>:9200
cf set-health-check es-index-deleter none #If deploying to Diego
cf start es-index-deleter
```

# Check

Every 30 min the app will send a DELETE request to Elasticsearch for the indexes that match `logs-unparsed-*`

Grab the logs to check if it is working

```
cf logs es-index-deleter
```

And you should see some output similar to:

```
2016-03-30T18:57:02.96+0100 [CELL/0]     OUT Successfully created container
2016-03-30T18:57:05.21+0100 [APP/0]      OUT Deleting index
2016-03-30T18:57:05.21+0100 [APP/0]      OUT curl -XDELETE http://10.0.16.59:9200/logs-unparsed-*
2016-03-30T18:57:05.21+0100 [APP/0]      ERR   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
2016-03-30T18:57:05.21+0100 [APP/0]      ERR                                  Dload  Upload   Total   Spent    Left  Speed
2016-03-30T18:57:05.22+0100 [APP/0]      ERR   0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
2016-03-30T18:57:05.22+0100 [APP/0]      ERR 100    21  100    21    0     0   6289      0 --:--:-- --:--:-- --:--:--  7000
2016-03-30T18:57:05.22+0100 [APP/0]      OUT {"acknowledged":true}
```

