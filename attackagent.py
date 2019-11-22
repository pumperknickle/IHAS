from scapy.all import *
import sys

p=sr1(IP(dst=sys.argv[1])/TCP(dport=int(sys.argv[2]))/"hello")
if p:
    p.show()
