import socket

def main():
    host = '127.0.0.1'  # Localhost IP (replace with the Minikube IP later)
    port = 7778          # Port to connect to

    # Create a socket object using UDP (SOCK_DGRAM)
    client_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

    # Send data to the server
    data = "Hello, Server!"
    client_socket.sendto(data.encode(), (host, port))

    # Close the socket
    client_socket.close()

if __name__ == "__main__":
    main()
