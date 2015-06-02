Nginx docker container that acts as a frontend for other defence-request-service docker containers

# Security upgrades

To apply the latest security upgrades to the container:

* Update Dockerfile to the latest tag from https://registry.hub.docker.com/_/nginx/tags/manage/
* date +%s > .latest-security-upgrades
* git commit -m "Applied security upgrades"
* git push

Then, apply the CI-generated build to the running instances. See the deploy
repo for more information.
