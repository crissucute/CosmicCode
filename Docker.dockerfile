# Check Nginx base image
FROM nginx:latest

# Set the working directory in the container
WORKDIR /usr/share/nginx/html

# Copy the contents of the Git repository into the container
COPY . /usr/share/nginx/html

# Change the default port to 8080
EXPOSE 8080

# Start Nginx when the container is run
CMD ["nginx", "-g", "daemon off;"]
