FROM node:lts-alpine as build

RUN apk add --update git
RUN git clone https://github.com/t7tran/directus.git
RUN cd /directus && \
    git checkout block-hidden-modules && \
    npm i && \
    npm run build

FROM directus/directus:v9.0.0-rc.24

COPY --from=build /directus/node_modules/@directus/app/dist /directus/node_modules/@directus/app/dist/
