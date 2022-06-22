# Seedtag Codetest: MLOps

**Contents**,

Solution for codetest
Makefile: build docker image using buildpack and run tests
k8s: terraform for deploy k8s and helm to deploy application with 2 environments yaml config files.



**Resume**

Originally I created 3 routes and 3 methods to respond to those routes. But seeing that the code was very similar, after testing individually per route, I made a single function for all resquests.

At first I also thought of doing a redirect with astromech but that would return a 301 to the client so I joined the 3 routes in one function. 

The steps in the apps are: 
- we validate that the request is a json
- we validate the data we get.
- Depending on the route, we execute one prediction or another. 
- Validate response
- I build the response json


Developing the data validation I checked that there were 3 very related functions on the same topic so  I created a class to validate data. The only function in the code app is to build the response json. 

I have added logging to the app for debugging. That's what I used to program this solution. 


**Makefile**

I have added a makefile which in this example is not very useful but I usually use it in all my projects to simplify the the tasks.

Build image 
```sh
make build
```
Run image
```sh 
make run
```
Run image LOGLEVEL DEBUG

```sh 
make run LOGLEVEL="DEBUG" 
```
Run Tests
```sh 
make test
```


** Building the docker image  and buildpack **

To create the docker imagen I used buildpack. [Buildpack](https://buildpacks.io)

**Buildpack**

Install and documentation for [Buildpack](https://buildpacks.io/docs/)

List builders 
```sh
pack builder suggest
```

Select default-builder(example: Google for builder)
```sh
pack config default-builder gcr.io/buildpacks/builder:v1 
```

Create image
```sh
pack build droids:001
```

**k8s folder**

Here I create 2 folders for k8s deployment. Terraform folder for infrastructure and helm folder for the application.

**Terraform**

I didn't know whether to add it or not, but as our goal is to be able to deploy infrastructure sometimes on demand and to be able to test how our deployment and infrastructure behaves in peak demand. 


**Helm**

I add a helm chart to deploy the solution in k8s. A good idea is to use hpa to horizontal scale the pods. Or use prometheus to scale using custom metrics. 






