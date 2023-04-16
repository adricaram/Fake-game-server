import socket

def main():
    host = '10.105.59.70'  # Localhost IP to test in local : External IP to test the server in the cluster
    port = 7778          # Port 

    # Create a socket object using UDP (SOCK_DGRAM)
    client_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

    # Send data to the server
    data = "Hello, Server!"
    client_socket.sendto(data.encode(), (host, port))

    # Set a 3-second timeout for receiving the server's response
    client_socket.settimeout(3)

    try:
        # Wait for the server's response
        response, server_addr = client_socket.recvfrom(4096)
        print("Server response:", response.decode())
    except socket.timeout:
        print("No response from server after 3 seconds. Closing the socket.")

    # Close the socket
    client_socket.close()

if __name__ == "__main__":
    main()
