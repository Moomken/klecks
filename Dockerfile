FROM node

COPY . /var/www
WORKDIR /var/www

RUN npm install serve -g
RUN npm ci
RUN npm run lang:build
RUN npm run build
RUN npm run build:help

ENTRYPOINT ["/bin/sh", "-c", "find dist -type f -name '*.js' -exec sed -i \"s/__IMPORT_PASSWORD_PLACEHOLDER__/${IMPORT_PASSWORD:-password}/g\" {} \\+ && npx serve dist"]
EXPOSE 3000
