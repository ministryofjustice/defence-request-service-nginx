Nginx docker container that acts as a frontend for other defence-request-service docker containers

# Execution

Please Replace FIXME-defence-request-service with defence-request-service, defence-request-service-rota, defence-request-service-auth as required.

On staging:

	docker run --link FIXME-defence-request-service:upstream -e ASSET_URL_PREFIX=https://s3-eu-west-1.amazonaws.com -e ASSET_BUCKET_NAME=drs-staging-service-assets defence-request-service-nginx:localbuild

In development on your machine:

	docker run --link FIXME-defence-request-service:upstream -e ASSET_URL_PREFIX=http://upstream:3000 -e ASSET_BUCKET_NAME="" defence-request-service-nginx:localbuild

* You will need to link a related server with the name 'upsteam', which this nginx then proxies to.
* ASSET_URL_PREFIX - the host that serves assets.
* ASSET_BUCKET_NAME - S3 bucket name where the associated assets are stored, if appropriate.

# Security upgrades

To apply the latest security upgrades to the container:

* Update the 'FROM' clause in the Dockerfile to the latest tag from https://registry.hub.docker.com/_/nginx/tags/manage/
* date +%s > .latest-security-upgrades
* git commit -m "Applied security upgrades"
* git push

Then, apply the CI-generated build to the running instances. See the deploy
repo for more information.
