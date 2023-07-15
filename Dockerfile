# Fetching the latest node image on alpine linux
FROM node:alpine

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

# Build the React app for production
# RUN npm run build

# Documents that the container will listen on port 8080 for network connections. 
# It does not publish the port to the host machine. (Expose is optional)
EXPOSE 3000

# Set the command to run the development server when the container starts
CMD ["npm", "start"]