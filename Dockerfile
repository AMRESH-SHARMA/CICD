#node block

# Use an Ubuntu-based Node.js image
FROM node:14 AS nodework

# Fetching the latest node image on alpine linux
# FROM node:alpine as nodework

# Setting up the work directory
WORKDIR /react-app

# Copy Specifies the path to the file or directory on the host machine that you want to copy into the container. 
# It can be a specific file, a relative or absolute directory path, or a wildcard pattern.
# It copies the package.json and package-lock.json files to the container
COPY ./package.json /react-app

# Install the project dependencies
RUN npm install

# Copy the app source code to the container
COPY . .

#Build the React app for production
RUN npm run build


#nginx block
FROM nginx:1.25.1-alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=nodework /react-app/build .
ENTRYPOINT [ "nginx", "-g", "daemon off;"]
