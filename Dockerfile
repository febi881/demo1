FROM httpd:2.4
COPY ./index.html /usr/local/apache2/htdocs/
RUN curl -fsSL --create-dirs --output /usr/local/bin/docker \
        "https://get.docker.com/builds/$(uname -s)/$(uname -m)/docker-${DOCKER_VERSION}" \
 && chmod +x /usr/local/bin/docker
