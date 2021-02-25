
FROM node as build-deps
WORKDIR /usr/src/app
COPY . ./
RUN yarn
RUN yarn build

FROM nginx:alpine
COPY --from=build-deps /usr/src/app/build /usr/share/nginx/html
COPY --from=build-deps /usr/src/app/node_modules /usr/share/nginx/html/node_modules
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
