FROM node:slim as build

WORKDIR /app
COPY ./package.json .
RUN npm install
ADD . .
RUN npm run build

FROM node:slim

WORKDIR /app
COPY --from=build /app/node_modules /app/node_modules
COPY --from=build /app/dist /app/dist
RUN npm install -g serve pm2
EXPOSE 3000
