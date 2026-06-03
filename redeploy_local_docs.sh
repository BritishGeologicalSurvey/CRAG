docker stop siqma-q-docs
docker rm siqma-q-docs
docker build -t siqma-q-build -f Dockerfile_docs .
docker run -d --name siqma-q-docs -p 8080:80 siqma-q-build
