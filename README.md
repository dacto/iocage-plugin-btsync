## HOW-TO Install this fork

```shell
BRANCH=master
JSON=/tmp/rslsync.json

fetch -o "$JSON" "https://raw.githubusercontent.com/dacto/iocage-plugin-btsync/${BRANCH}/rslsync.json"
iocage fetch -P "$JSON" --branch "$BRANCH" -n rslsync
```

# iocage-plugin-btsync
Artifact file(s) for Resilio iocage plugin
