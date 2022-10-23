FROM alpine:3.14

LABEL maintainer="Martin Jean-Christio <jmartin@student.42lausanne.ch>"

# Install nodejs and npm
RUN apk update && apk upgrade \
	&& apk add --no-cache --quiet --update \
	nodejs npm

# Set the working directory \
WORKDIR /usr/src/app

# Install dependencies
COPY /app/package*.json ./
RUN npm install

# Copy the app
COPY /app .

# Compile the css
RUN npm run style

# Run the app
CMD [ "npm", "start" ]