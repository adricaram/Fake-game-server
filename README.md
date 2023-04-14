# Fake-game-server
Fake game server
Test : connexion between client and server : done
terraform config file : done
Dockerfile : done
server test in minikube :  kubectl port-forward server-65b668959d-79f92 12345:12345 : client using same port receive data
edit server.py to use port 7778 UDP
use socat to expose 7778 UDP port => socat -v UDP4-LISTEN:7778,fork UDP4:10.244.0.3:7778
Todo : set up the server to run for 10 min only