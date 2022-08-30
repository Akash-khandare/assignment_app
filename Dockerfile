FROM node:12-alpine
WORKDIR /app
COPY package.json .
RUN yarn install --production 
COPY . .
EXPOSE 3000
ENTRYPOINT ["node", "src/index.js"]
