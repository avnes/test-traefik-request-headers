# Test Traefik Request Headers

This repo is used to test what request headers (if any) are set by Traefik v2 vs Traefik v1. It assumes that Traefik v2 is already installed and working on your cluster, and that a fallback IngressRoute is setup to route un-matched traffic to Traefik v1.

## Configuration

Use the env.sample file to create a file called .env with your load balancers DNS domain. It is assumed that the
DNS domain will allow wildcards. For example if you have the example.com domain, the load balancer will respond to
*.example.com.

## Requirements

- Traefik v2 Helm chart is installed with the additional argument: --providers.kubernetescrd.allowCrossNamespace=true
- Traefik v1.7 installed in different namespace.
- Load balancer traffic should reach the Traefik v2 instance.
- A fallback IngressRoute for Traefik v2 to Traefik v1 is setup to catch un-matched traffic, like scenario-01

Please note that --providers.kubernetescrd.allowCrossNamespace=true should be removed, and Traefik v2 reinstalled after testing.

### Fallback IngressRoute example

```yaml
apiVersion: traefik.containo.us/v1alpha1
kind: IngressRoute
metadata:
  name: fallback-to-v1-ingress
spec:
  entryPoints:
  - web
  routes:
  - kind: Rule
    match: HostRegexp(`{domain:.+}`)
    priority: 2
    services:
    - kind: Service
      name: traefik
      namespace: <where you installed Traefik v1>
      port: 80
```

## Usage

This script will:

- Create a new namespace.
- Install two deployments with one pod and one service each. I am using this pod <https://github.com/mendhak/docker-http-https-echo>
- Test that the two applications are deployed sucessfully.
- Testing the first application on path /web01 should go to Traefik v2, and since no IngressRoute was created for this service, it will be un-matched and picked up by the fallback IngressRoute and then being sent over to Traefik v1 and finally reach the k8s service.
- Testing the second application on path /web02 should go directly through Traefik v2 to the k8s service.

```bash
./apply.sh
```
