
June 19, 2022
•
3 min read
Dockerizing a React app
So you have a React app. And you want to serve it through Docker.

Let's do that!

At the end of this tutorial, you'll have a Docker container running your app that you can deploy as you see fit 👌

We're going to start from an existing app - a barebones app, using just Webpack and React. Find the starter code on Github or follow a step by step tutorial to setup the app.

Step 1: Building a Docker image
To build a Docker image, we want to copy all the source files inside the container, build the project (also inside the container) and then serve the build folder.

Let's start by ignoring the files that we never want to copy to the docker image. For this, we'll create a .dockerignore file in the root of the project:

// .dockerignore
node_modules
build

Next, let's define our Docker container by creating a Dockerfile in the root of the project:

// Dockerfile

# ==== CONFIGURE =====
# Use a Node 16 base image
FROM node:20-alpine 
# Set the working directory to /app inside the container
WORKDIR /front
# Copy app files
COPY . .
# ==== BUILD =====
# Install dependencies (npm ci makes sure the exact versions in the lockfile gets installed)
RUN npm ci 
# Build the app
RUN npm run build
# ==== RUN =======
# Set the env to "production"
ENV NODE_ENV production
# Expose the port on which the app will be running (3000 is the default that `serve` uses)
EXPOSE 3000
# Start the app
CMD [ "npx", "serve", "build" ]