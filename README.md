# Test Traefik Request Headers

This repo is used to test what request headers (if any) are set by Traefik v2 vs Traefik v1. It assumes that Traefik v2 is already installed and working on your cluster, and that a fallback IngressRoute is setup to route un-matched traffic to Traefik v1.

## Configuration

Use the env.sample file to create a file called .env with your load balancers DNS domain. It is assumed that the
DNS domain will allow wildcards. For example if you have the example.com domain, the load balancer will respond to
*.example.com.

## Usage

This script will:

**Caution:** This is still Work In Progress. At the moment scenario 01 and 02 are 100% identical (apart from the path).

- Create a new namespace.
- Install two deployments with one pod and one service each. I am using this pod <https://github.com/mendhak/docker-http-https-echo>
- Test that the two applications are deployed sucessfully.
- Testing the first application on path /web01 should go directly through Traefik v2 to the k8s service.
- Testing the second application on path /web02 should to to Traefik v2, then being sent over to Traefik v1 and finally reach the k8s service.

```bash
./apply.sh
```
