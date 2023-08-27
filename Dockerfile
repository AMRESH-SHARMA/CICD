# Use a Distroless Node.js image as the base for the Node.js block
FROM gcr.io/distroless/nodejs:14 AS nodework

# Setting up the work directory
WORKDIR /react-app

# Copy package.json and package-lock.json files to the container
COPY ./package.json ./package-lock.json ./

# Install the project dependencies
RUN npm install --only=production

# Copy the app source code to the container
COPY . .

# Build the React app for production
RUN npm run build

# Use the official Nginx image for the nginx block
FROM nginx:1.25.1-alpine

# Set the working directory for Nginx
WORKDIR /usr/share/nginx/html

# Remove existing files in the Nginx HTML directory
RUN rm -rf ./*

# Copy the optimized React app from the previous stage (nodework)
COPY --from=nodework /react-app/build .

# Set the entry point to start Nginx
ENTRYPOINT ["nginx", "-g", "daemon off;"]
