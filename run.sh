sudo docker run --net=asnet --ip=192.168.1.10 -v /Users/jbao/Honeypotlogs:/Honeyd/logs/ -p "445:445" -p "16992:16992" -p "16993:16993" honeypot
