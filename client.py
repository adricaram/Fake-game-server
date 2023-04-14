import socket

def main():
    host = '127.0.0.1'  
    port = 12345        

    client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    client_socket.connect((host, port))
    data = "test test!"
    client_socket.sendall(data.encode())
    client_socket.close()

if __name__ == "__main__":
    main()