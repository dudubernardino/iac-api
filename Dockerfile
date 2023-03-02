FROM node:18-alpine as build

WORKDIR /app

COPY package*.json ./

RUN yarn --production

COPY . .

RUN yarn build

FROM node:14-alpine

WORKDIR /app

COPY package*.json ./

RUN yarn --production

COPY --from=build /app/dist ./dist

ENV NODE_ENV=production

EXPOSE 3000

CMD ["yarn", "start:prod"]