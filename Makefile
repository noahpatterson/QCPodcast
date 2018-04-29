#
# Makefile for building and running the GCP Podcast
#

#--- Host Targets ---

TAG=gcr.io/gcppodcast/dev
NAME=qc-podcast-dev

# build the docker image
build:
	docker build --tag=$(TAG) dev

clean:
	docker rmi $(TAG)

push:
	gcloud docker -- push $(TAG)

pull:
	gcloud docker -- pull $(TAG)

shell:
	mkdir -p ~/.config/gcloud
	docker run --rm \
		--name=$(NAME) \
		-p=1313:1313 \
		-p=22 \
		-p=8080 \
		-e TERM \
		-e HOST_GID=`id -g` \
		-e HOST_UID=`id -u` \
		-e HOST_USER=$(USER) \
		-v ~/.config/gcloud:/home/$(USER)/.config/gcloud \
		-v ~/.appcfg_oauth2_tokens:/home/$(USER)/.appcfg_oauth2_tokens \
		-v `pwd`/dev/zshrc:/home/$(USER)/.zshrc \
		-v `pwd`:/project \
		-it $(TAG) /root/startup.sh

attach:
	docker exec -it --user=$(USER) $(NAME) zsh

attach-root:
	docker exec -t $(NAME) bash
