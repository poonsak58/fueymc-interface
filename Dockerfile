FROM node:slim as build

WORKDIR /app
COPY ./package.json .
RUN npm install
ADD . .
RUN npm run build

FROM node:slim

WORKDIR /app
COPY --from=build /app/node_modules /app/node_modules
COPY --from=build /app/build /app/build
RUN npm install -g serve pm2
EXPOSE 3000
CMD ["pm2", "serve", "build", "3000", "--spa"]
