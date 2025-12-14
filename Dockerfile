FROM node:20 AS builder
WORKDIR /app

COPY package.json package-lock.json ./ 

RUN npm install --omit=dev

COPY . .

FROM node:20-slim
WORKDIR /app

COPY --from=builder /app/node_modules ./node_modules

COPY --from=builder /app/package.json ./package.json 
COPY --from=builder /app/server.mjs ./server.mjs 
COPY --from=builder /app/*.mjs ./

ENV NODE_ENV production
EXPOSE 4000

CMD ["npm", "start"]