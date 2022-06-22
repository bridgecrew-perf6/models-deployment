BUILDER="gcr.io/buildpacks/builder:v1"
IMAGE_NAME="droids"
IMAGE_TAG="latest"
PORT=3000
LOGLEVEL="INFO"
.ONESHELL:


tests:
	python3 test/evaluate_deployment.py

build:
	pack config default-builder ${BUILDER};\
	pack build ${IMAGE_NAME}:${IMAGE_TAG}	

run:
	docker run   -e PORT=${PORT} -e LOGLEVEL=${LOGLEVEL} -p ${PORT}:${PORT} ${IMAGE_NAME}:${IMAGE_TAG} 
