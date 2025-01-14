FROM cis-hub-huadong-7.cmecloud.cn/nuclearwu/node:16-alpine as builder
WORKDIR /app/demo
ADD . .
RUN yarn install && yarn build

FROM cis-hub-huadong-7.cmecloud.cn/nuclearwu/nginx:1.21
ARG GITVERSION
COPY --from=builder /app/demo/dist /usr/share/nginx/html
COPY default.conf /etc/nginx/nginx.conf
RUN echo "${GITVERSION}" > /tmp/version
CMD ["nginx", "-g", "daemon off;"]
