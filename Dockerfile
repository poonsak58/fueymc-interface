FROM node:slim as build

WORKDIR /app
COPY ./package.json .
RUN npm install
ADD . .
RUN npm run build

FROM nginx:alpine

WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=build /app/build .
ENTRYPOINT ["nginx", "-g", "daemon off;"]
