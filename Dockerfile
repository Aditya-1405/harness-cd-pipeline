# Use official Node image
FROM node:18-alpine

# Set working directory
WORKDIR /usr/src/app

# Copy package files and install dependencies
COPY app/package*.json ./
RUN npm install --production

# Copy app source
COPY app/ .

# Expose port and run app
EXPOSE 8080
CMD ["npm", "start"]
