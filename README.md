# Game server

The goal of this project is to set up a server game into a local minikube and see how we can interact with the server inside or outside the cluster.

The game server will be represented as a server.py script that listens on UDP port 7778.

It prints everything it receives to standard output, and runs for 10 minutes exactly.
The server.py script is containerized and deployed to a local minikube using Terraform.

## Architecture
