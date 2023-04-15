import socket
import time

SERVER_IP = "0.0.0.0"
SERVER_PORT = 7778

server = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
server.bind((SERVER_IP, SERVER_PORT))

start_time = time.time()
max_duration = 600  # 10 minutes in seconds

while time.time() - start_time < max_duration:
    data, addr = server.recvfrom(4096)
    print("Client message:", data.decode())

    # Calculate and print time left
    time_left = max_duration - (time.time() - start_time)
    print(f"Time left: {time_left:.2f} seconds")

    # Ping back the client for testing the connection
    response = "hello from the server!"
    server.sendto(response.encode(), addr)

server.close()