Firstly to build my image I have created the dockerfile Dockerfile is used to build a Docker image for an application that runs on Nginx web server.

Dockerfile
---------------------------
# Use the official nginx image as the base image
FROM nginx

# Copy the nginx configuration file to the container
COPY nginx.conf /etc/nginx/nginx.conf

# Copy the application files to the container
COPY app/ /usr/share/nginx/html/

# Expose port 80 for incoming traffic
EXPOSE 80
---------------------------


FROM

This specifies that the official Nginx image should be used as the base image for the Docker image being built.
COPY nginx.conf

This copies the nginx.conf file from the local file system to the container at the path /etc/nginx/nginx.conf.
COPY app/

This copies the contents of the app/ directory from the local file system to the container at the path /usr/share/nginx/html/.
EXPOSE

This exposes port 80 to allow incoming traffic to the container.

Regarding the template/ files
------------------------
Service

The Service is defined with the name "myapp-service". It exposes port 80 as a TCP port with the name "http".The Service is of type ClusterIP.
Deployment Resources


Image:
The image is defined with the repository "sindisadocker/assessment" and tag "latest".The pullSecrets field references a Kubernetes secret with the name "myregistrykey" for pulling the image.

Secret.yaml

The Secret is defined with the username "sindisa97" and password "mypassword".


Deployment.yaml

The Deployment object is defined with the name "myapp".
It specifies 3 replicas of the pod.
The pod template has one container named "nginx".
The container runs the image "sindisadocker/assessment:latest" and exposes port 80.
The imagePullSecrets field references a Kubernetes secret with the name "myregistrykey".
------------------------



Action Workflow explaination:
-----------------------------
The workflow is triggered on push and pull request events on the main branch.

The workflow has one job named "build" that runs on the latest version of Ubuntu. The job includes four steps:

Checkout code

This step uses the "actions/checkout@v2" action to check out the code from the repository.
Build nginx application

This step builds the nginx application using the "docker build" command and tags the resulting image with the name "nginx-webapp".


Test application

This step runs the "nginx -t" command inside a Docker container created from the "nginx-webapp" image to test the application.


Deploy application

This step deploys the application to Kubernetes using the "steebchen/kubectl@v1" action, which provides the kubectl command-line tool for interacting with the Kubernetes cluster.
The action is configured to run the "apply" command to apply the configuration in the manifest files located in the "templates" directory. The manifest files include Kubernetes resources such as secrets, deployment, service, and configmap

The values of the deployment are set using the helm chart
