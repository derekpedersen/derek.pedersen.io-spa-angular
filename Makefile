export GIT_COMMIT_SHA = $(shell git rev-parse HEAD)

run:
	ng serve --host 0.0.0.0 --disable-host-check

build:
	npm install
	npm rebuild node-sass
	ng build --prod --build-optimizer

docker: build
	docker build ./ -t derekpedersen-spa-angular

publish: docker
	docker tag derekpedersen-spa-angular us.gcr.io/${GCLOUD_PROJECT_ID}/derekpedersen-spa-angular:${GIT_COMMIT_SHA}
	gcloud docker -- push us.gcr.io/${GCLOUD_PROJECT_ID}/derekpedersen-spa-angular:${GIT_COMMIT_SHA}

deploy: publish
	sed -e 's/%GCLOUD_PROJECT_ID%/${GCLOUD_PROJECT_ID}/g' -e 's/%GIT_COMMIT_SHA%/${GIT_COMMIT_SHA}/g' ./kubernetes-deployment.yaml > deployment.sed.yaml
	kubectl apply -f ./deployment.sed.yaml
	kubectl apply -f ./kubernetes-service.yaml

kubernetes: docker publish deploy