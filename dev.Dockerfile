FROM node:18
# RUN npm install -g pnpm
RUN curl -f https://get.pnpm.io/v6.16.js | node - add --global pnpm
WORKDIR /app
# Files required by pnpm install
COPY package.json pnpm-lock.yaml ./
COPY . ./
RUN pnpm install
EXPOSE 3000
CMD [ "npm", "run", "dev" ]