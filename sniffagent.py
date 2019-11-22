from scapy.all import *

sessions = set([])

def pkt_callback(pkt):
    if IP in pkt:
      if TCP in pkt:
        print("--src IP--")
        reqsrcip = pkt[IP].src
        print(reqsrcip)
        print("--src port--")
        reqsrcport = pkt[TCP].sport
        print(reqsrcport)
        print("--dst IP--")
        reqdstip = pkt[IP].dst
        print(reqdstip)
        print("--dst port--")
        reqdstport = pkt[TCP].dport
        print(reqdstport)
        pkt[IP].src = ""
        pkt[IP].dst = ""
        pkt[TCP].sport = 0
        pkt[TCP].dport = 0
        session = reqsrcip + reqdstip + str(reqsrcport) + str(reqdstport)
        if session in sessions:
           wrpcap(session + ".pcap", pkt)
           pkt[IP].src = reqdstip
           pkt[IP].dst = reqsrcip
           pkt[TCP].sport = reqdstport
           pkt[TCP].dport = reqsrcport
           send(pkt)
        else:
           sessions.add(session)
      if UDP in pkt:
        print("--src IP--")
        print(pkt[IP].src)
        print("--src port--")
        print(pkt[UDP].sport)
        print("--dst IP--")
        print(pkt[IP].dst)
        print("--dst port--")
        print(pkt[UDP].dport)
    pkt.show()

sniff(iface="eth0", prn=pkt_callback, store=0)
