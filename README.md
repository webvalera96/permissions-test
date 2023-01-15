### docker-registry-key.yaml

```json
{
  "auths": {
    "registry.cluster.local": {
      "auth": "username:password"
    }
  }
}
```


```yaml
apiVersion: v1
kind: Secret
metadata:
  name: docker-registry-key
  namespace: perm-test
type: kubernetes.io/dockerconfigjson
data:
  .dockerconfigjson: >-
    "base64 encoded"

```