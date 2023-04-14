import socket

def main():
    host = '0.0.0.0'
    port = 12345        

    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.bind((host, port))
    server_socket.listen(1)
    print(f"Server is listening on {host}:{port}")
    connection, address = server_socket.accept()
    print(f"Connected to {address}")
    data = connection.recv(1024).decode()
    print(f"Received data: {data}")
    connection.close()

if __name__ == "__main__":
    main()