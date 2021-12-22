# build environment
FROM node:14.16.1-alpine as build 
WORKDIR /app  
ENV PATH /app/node_modules/.bin:$PATH 
COPY ./web/package.json /app/package.json 
RUN npm install
COPY ./web /app 
RUN npm run build  

# production environment 
FROM nginx:1.16.0-alpine 
COPY --from=build /app/build /usr/share/nginx/html 
EXPOSE 80 
CMD ["nginx", "-g", "daemon off;"]
