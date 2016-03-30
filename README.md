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
cf logs es-index-deleter --recent
```

And you should see some output similar to:

```
2016-03-30T19:08:51.49+0100 [APP/0]      OUT green open .kibana             1 1      2 0  59.4kb  29.7kb
2016-03-30T19:08:51.49+0100 [APP/0]      OUT green open logs-platform-2016.03.30 5 1 648320 0 653.4mb 326.7mb
2016-03-30T19:08:51.49+0100 [APP/0]      OUT green open logs-unparsed-2016.03.25 5 1 847152 0 846.7mb 423.4mb
2016-03-30T19:08:51.49+0100 [APP/0]      OUT green open logs-app-2016.03.24 5 1 118262 0 236.3mb 118.3mb
2016-03-30T19:08:51.49+0100 [APP/0]      OUT ==>Deleting index
2016-03-30T19:08:51.49+0100 [APP/0]      OUT curl -XDELETE http://10.0.16.59:9200/logs-unparsed-*
2016-03-30T19:08:51.49+0100 [APP/0]      ERR   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
2016-03-30T19:08:51.49+0100 [APP/0]      ERR                                  Dload  Upload   Total   Spent    Left  Speed
2016-03-30T19:08:51.49+0100 [APP/0]      ERR   0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
2016-03-30T19:08:51.49+0100 [APP/0]      ERR 100    21  100    21    0     0  16079      0 --:--:-- --:--:-- --:--:-- 21000
2016-03-30T19:08:51.49+0100 [APP/0]      OUT {"acknowledged":true}
```

