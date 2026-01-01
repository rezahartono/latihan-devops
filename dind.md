docker run --privileged --name dind -d \
	--network dind --network-alias docker \
	-p 32375:2375 \
	-p 32376:2376 \
	-e DOCKER_TLS_CERTDIR="" \
	docker:24-dind


docker run --privileged --name dind -d \
	--network dind --network-alias docker \
	-p 32375:2375 \
	-p 32376:2376 \
	-e DOCKER_TLS_CERTDIR=/certs \
	-v dind-certs-ca:/certs/ca \
	-v dind-certs-client:/certs/client \
	docker:dind
	dockerd -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock
