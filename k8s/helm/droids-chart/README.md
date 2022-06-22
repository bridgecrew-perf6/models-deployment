# Helm Chart for droids app

[droids](https://nodomian.com/droids) is a flask application to deploy models.

## Introduction

This chart will  install [droids](https://nodomian.com/droids)  on a [Kubernetes](http://kubernetes.io)
cluster using the [Helm](https://helm.sh) package manager.


## Prerequisites

- Kubernetes 1.12+ cluster
- Helm 2.11+ or Helm 3.0+



## Installing the Chart


# Using values from DEV/TEST/PRE/PROD environment
```bash
helm install droids . --namespace droids -f values-ENVIROMENT.yaml 
```


The command deploys Testino on the Kubernetes cluster in the custom configuration. The [Parameters](#parameters)
section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Upgrading the Chart

To upgrade the chart with the release name `droids`:

```bash
helm upgrade testino . --namespace testino -f values-dev.yaml
```

## Uninstalling the Chart

To uninstall/delete the `droids` deployment:

```bash
helm delete droids --namespace droids
```

The command removes all the Kubernetes components associated with the chart and deletes the release.



## Parameters

The following tables lists the configurable parameters of the testino chart and their default values.

| Parameter                                             | Description                                                                                                  | Default                                           |
| ----------------------------------------------------- | ------------------------------------------------------------------------------------------------------------ | ------------------------------------------------- |
| `app`                                                 | Name of the app                                                                                              | `testino`                                         |
| `image`                                               | url of docker image                                                                                | `registry.gitlab.com/ismaello/testino`                                           |
| `tag`                                                 | Docker image tag                                                                               | `822342`                                              |
| `port`                                                | Port for testino deployment                                                                           | `8080`                                              |
| `imagePullSecret`                                     | For private registry                                                                        | `gitlab`                                              |
| `replicas`                                              | Number of replicas for deployment                                                    | `1`                                              |
| `limits.cpu`                             | CPU limit                                                    | `500m`                                           |
| `limits.memory`                          | Memory limit                                                              | `500Mi`                                               |
| `request.cpu`                                     | CPU request                                                                            | `100m`                                           |
| `request.memory`                                       | Memory request                                                                   | `100Mi`                     |
| `serviceType`                                    | Type of k8s service                                                                | `nodeport`                     |
| `ingress.enabled`                             | Install chart ingress                                                                 | `false`                                            |
| `ingress.domain`                                         | Domain for ingress                                                                           | `test.testino.com`                                    |
| `ingress.path`                                         | url path                                                                     | `/`                                            |
| `params.host_file`                                    | Name of the file to load config hosts                                           | `hosts_prod.yaml`                              |
| `hosts`                                               | services and ports section                                             | `yaml`                                            |


Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,


