# Create image based on the official Node 6 image from dockerhub
FROM node:alpine

# install angular cli
RUN npm install -g @angular/cli

# Create a directory where our app will be placed
COPY . /derekpedersen.com-spa

# Change directory so that our commands run inside this new directory
WORKDIR /derekpedersen.com-spa

# Install packages
RUN npm install

# Build app
RUN ng build

# Expose the port the app runs in
EXPOSE 4200

# Serve the app
ENTRYPOINT ng serve --host 0.0.0.0 --disable-host-check