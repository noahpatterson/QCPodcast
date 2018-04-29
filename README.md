<!-- Modified 4-29-2018 by QC-Podcast -->
# QC Podcast Website

This repo contains all the code and contents behind [qc-podcast.com](https://www.qc-podcast.com).

# Contents of the repository

You will find three directories in the repository, `dev`. `go`, and `site`.

- dev:
- go: an App Engine module written in Go used to
- site: the [hugo](https://gohugo.io) structure that generates the static website

## dev: website development

This directory contains all the tooling we use to build/deploy the podcast.
In particular it has a `Dockerfile` that defines an environment with all the tools we
use to generate the website and tag `mp3` files.

You can build this image using the `Makefile` on the root of this repository.
You will be able to push it or pull it from
[Google Container Registry](https://cloud.google.com/container-registry/) too,
but you might need to modify the `TAG` variable to match a project you have
access to.

Finally, once you've built the image, you should be able to create a new interactive
shell by running `make shell` or `make attach` if you want to attach to an existing one.

### tagging a episode

- Place .mp3 files in `dev` directory
- Use the following format `QC.Podcast.Episode.2.mp3`
- Inside Docker, in the `dev`, run the following command to tag: `./tag.sh 'QC.Podcast.Episode.1a' 1 'Questionable Pilot - Part 1' '1a'` Where args are: 1-file name, 2-episode real number (this is the actual file number), 3-episode title, 4-episode number.
- Upload this file to Google Cloud Storage and make the link public.

### getting to root

1. `su root`
2. password = `pw`

### Album.png

Is used by the tagging script to put the image on the .mp3 file.

## site: the [hugo](https://gohugo.io) structure that generates the static website

This directory contains all the resources that we use to generate the podcast website.

You can use the `Makefile` provided in the directory to:

- Run Interactive Hugo Server (port 1313): `make server`
- Sassify->CCS Assets: `make assets-update` - does production css generation, compressed and everything.
- Deploy the Project to App Engine:
  - `make deploy` - This will not make the version default. Useful if you just want to test/share a version live.
  - `make deploy-default` - This will replace the default version (but the old version is kept, in case

### Adding new episodes

1. under `site/content/post` create a new episode with following naming `episode-3-episode-name.md`
2. Modify the meta information and post body.
3. Add any necessary pictures to `site/static/images`


### Changing Podcast images

In order to change images of the Podcast on feeds etc. you need to modify the following files
- `dev/Album.png` - used on actual tagged mp3s
- `logo_large.png` - 3000x3000
- `logo_transparent.png` - 256x256
- `logo.png` - 256x256
- `site_logo_large.png` - 1000x1000
- `site_logo.png` - 250x250
- `favicon.ico` - icon used form the web favicon - 16x16
- `favicon.png` - png version of favicon - 32x32

### To Change

Need to change:
- all the social urls
- itunes, google and other urls

### Removed

I removed:
- reddit and google+ links

### About page

Lives under `site/content`

## go: adding Google Analytics to Google Cloud Storage

This directory contains an [App Engine](https://cloud.google.com/appengine) service
that provides a way to access the `mp3` files stored in [Google Cloud Storage](https://cloud.google.com/storage)
while logging those accesses with [Google Analytics](https://analytics.google.com).

Make targets that can be run within the `go` directory
which is for dynamic modules, such as the module that tracks
episode downloads.

- Run full code lint, vet and goimports over everything: `make code-check`
- Start Local Episode Redirect Module: `make serve-eps`
- Deploy Episode Redirect Module: `make deploy-eps`

### clarify what this is and does

What's not clear is that this adds a service to your existing app-engine where the site is hosted.

### What I had to modify to make it work.

- For some reason the the code in the Makefile didn't work, so we use gcloud instead. There's a chance that you'll need to add `goapp` as a script.
- Might need to also reinstall VIM and re-save the container to have these settings.

## Disclaimer

*This app uses the following open-source libraries:*

[The Google Cloud Platform Podcast Site and Template](https://github.com/GoogleCloudPlatform/podcast)
GoogleCloudPlatform/podcast is licensed under the
Apache License 2.0
A permissive license whose main conditions require preservation of copyright and license notices. Contributors provide an express grant of patent rights. Licensed works, modifications, and larger works may be distributed under different terms and without source code.
[License](https://www.gcppodcast.com/license/) [License Text](https://raw.githubusercontent.com/GoogleCloudPlatform/podcast/master/LICENSE)