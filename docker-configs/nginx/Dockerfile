# build SSL certificate
FROM alpine:latest as builder

ARG NGINX_SERVER_NAME=localhost

RUN apk update && apk add --no-cache openssl

# create directory for SSL certificate
RUN mkdir -p /etc/nginx/certs/

# generate SSL certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/certs/nginx.key -out /etc/nginx/certs/nginx.crt \
    -subj "/CN=${NGINX_SERVER_NAME}"

# final Nginx image
FROM nginx:1.25.4

# copy SSL certificate
COPY --from=builder /etc/nginx/certs/ /etc/nginx/certs/
COPY nginx.conf /etc/nginx/nginx.conf
COPY conf.d/ /etc/nginx/conf.d/

EXPOSE 80
EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]