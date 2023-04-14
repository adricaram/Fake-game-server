import socket

def main():
    host = '0.0.0.0'  # Listen on all available network interfaces
    port = 7778        # Listen on port 7778

    # Create a socket object using UDP (SOCK_DGRAM)
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

    # Bind the socket to the host and port
    server_socket.bind((host, port))
    print(f"Server is listening on {host}:{port}")

    # Receive data from the client
    data, address = server_socket.recvfrom(1024)
    print(f"Received data: {data.decode()} from {address}")

if __name__ == "__main__":
    main()