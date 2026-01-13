FROM node:20-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY app.js .

EXPOSE 8080

# Use --require flag for auto-instrumentation
CMD ["node", "--require", "@opentelemetry/auto-instrumentations-node/register", "app.js"]
