# Use the official nginx image as the base image
FROM nginx

# Copy the nginx configuration file to the container
COPY nginx.conf /etc/nginx/nginx.conf

# Copy the application files to the container
COPY app/ /usr/share/nginx/html/

# Expose port 80 for incoming traffic
EXPOSE 80