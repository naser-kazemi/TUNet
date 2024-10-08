from server import TunServer
from client import TunClient
from utils import get_args, SECRET





def main():

    args = get_args()
    
    mode = args.mode

    tun_name = args.tun_name
    server_ip = args.server_ip
    port = args.port
    
    if mode == "server":
        server = TunServer(tun_name, port, SECRET)
    elif mode == "client":
        server = TunClient(tun_name, server_ip, port, SECRET)
    else:
        raise ValueError("Invalid mode")

    

    server.start()


if __name__ == "__main__":
    main()
