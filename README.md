# Game server

The goal of this project is to set up a server game into a local minikube and see how we can interact with the server inside or outside the cluster.

The game server will be represented as a server.py script that listens on UDP port 7778.

It prints everything it receives to standard output, and runs for 10 minutes exactly.

The server.py script is containerized and deployed to a local minikube using Terraform.

## Prerequisites

Before you begin, make sure you have the following software installed on your local machine:

1. **Python 3.9** or later: [https://www.python.org/downloads/](https://www.python.org/downloads/)
2. **Docker**: [https://docs.docker.com/get-docker/](https://docs.docker.com/get-docker/)
3. **Minikube**: [https://minikube.sigs.k8s.io/docs/start/](https://minikube.sigs.k8s.io/docs/start/)
4. **kubectl**: [https://kubernetes.io/docs/tasks/tools/install-kubectl/](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
5. **Terraform**: [https://learn.hashicorp.com/tutorials/terraform/install-cli](https://learn.hashicorp.com/tutorials/terraform/install-cli)
6. **Helm** (Optional, for installing the Nginx Ingress controller): [https://helm.sh/docs/intro/install/](https://helm.sh/docs/intro/install/)


## Installation

### Step 1 : Clone the project
```sh
git clone blabablable
```

### Step 2 : Containerize the server

1. Build the Docker image:
    ```sh
    docker build -t your_username/server:latest .
    ```
2. Push the Docker image to a container registry, such as Docker Hub:
    ```sh
    docker login
    docker push your_username/server:latest
    ```

### Step 3: Deploy the server to Minikube

1. Start Minikube:
    You can start minikube with different drivers, choose the most suitable with your environment
    ```sh
    minikube start --driver=hyperv
    ```
2. Initialize and apply Terraform configuration
   go to the terraform folder then :
    ```sh
    terraform init
    terraform apply
    ```
3. Create a network route
   in a separate terminal run : 
    ```sh
    minikube tunnel
    ```
    It will creates a network route between your host system and the Kubernetes cluster
    Once the tunnel is running, you will be able to access the services exposed by the LoadBalancer from your host machine using the IP addresses assigned to them within the Minikube cluster.

4. Check the cluster
   run :
    ```sh
    kubectl get all
    ```
    you should see your runing pods, services and deployment
    check that everything is running without error.
    Verify that you server service have an External IP and take note of this ip we will need it to test our server.


## Testing
As mentionned before, we have client in python who send message by UDP to the server when we execute it.

You can test the server in 3 differents way :
1. Local testing (running both server and client on the host machine outside the cluster)
2. Testing from outside to inside the cluster (client outside the cluster, server inside the cluster)
3. Testing inside the server pod (running both server and client inside the cluster)


# 1. Local Testing

To test the server and client on your local machine, you'll need to run them in two separate terminal windows.

1. Run the server:
    ```sh
    python server.py
    ```
2. Update the host variable in the client.py script to use localhost
    ```python
    import socket

    def main():
        host = '127.0.0.1'  # Localhost
        port = 7778          # Port
    ```
3. Run the client:
    ```sh
    python client.py
    ```
    you should see output from both

   
# 2. Testing from Outside to Inside the Cluster


### Server Terminal

1. Get the pod name:
    ```sh
    kubectl get pods
    ```
2. Stream the logs from the server pod (replace <server_pod_name> with the actual pod name from the previous command):
    ```sh
    kubectl logs -f <server_pod_name>
    ```
### Client Terminal

1. Get the external IP address of the server service:
    ```sh
    kubectl get svc server -o jsonpath='{.status.loadBalancer.ingress[0].ip}'
    ```
2. Update the host variable in the client.py script to use the external IP address:
    ```sh
    host = '<external_ip>'
    ```
3. Run the client:
    ```sh
    python client.py
    ```

# 3. Testing Inside the Server Pod

1. Get the pod name:
    ```sh
    kubectl get pods
    ```
2. Copy the udp_client.py script into the server pod (replace <server_pod_name> with the actual pod name from the previous command):
    ```sh
    kubectl cp client.py <server_pod_name>:/app/client.py
    ```
3. Run the client inside the server pod (replace <server_pod_name> with the actual pod name):
    ```sh
    kubectl exec -it <server_pod_name> -- python client.py
    ```
4. Make sure to update the host variable in the client.py script to use the server pod's IP address. You can get the server pod's IP address using the following command:
    ```sh
    kubectl get pods <server_pod_name> -o jsonpath='{.status.podIP}'
    ```

This readme has been created to guide you through the installation and testing of the game server.


You can find a complete documentation (inside the documentation folder) containing the code details, the choice of architecture, the impact of these choices in production, the issues i faced,  what could be added ...etc
