FROM nginx:latest
COPY ./config-docker/nginx/default.conf /etc/nginx/conf.d/
LABEL Author = "Norvene Gregory"
LABEL Description = "Dockerfile pour héberger mon application"
