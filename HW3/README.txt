Task 1:
	1. What is the output of “nodes” and “net”
	R/=
	nodes output:
	
	c0 h1 h2 h3 h4 h5 h6 h7 h8 s1 s2 s3 s4 s5 s6 s7
	
	net output:
	
	h1 h1-eth0:s3-eth2
	h2 h2-eth0:s3-eth3
	h3 h3-eth0:s4-eth2
	h4 h4-eth0:s4-eth3
	h5 h5-eth0:s6-eth2
	h6 h6-eth0:s6-eth3
	h7 h7-eth0:s7-eth2
	h8 h8-eth0:s7-eth3
	s1 lo:  s1-eth1:s2-eth1 s1-eth2:s5-eth1
	s2 lo:  s2-eth1:s1-eth1 s2-eth2:s3-eth1 s2-eth3:s4-eth1
	s3 lo:  s3-eth1:s2-eth2 s3-eth2:h1-eth0 s3-eth3:h2-eth0
	s4 lo:  s4-eth1:s2-eth3 s4-eth2:h3-eth0 s4-eth3:h4-eth0
	s5 lo:  s5-eth1:s1-eth2 s5-eth2:s6-eth1 s5-eth3:s7-eth1
	s6 lo:  s6-eth1:s5-eth2 s6-eth2:h5-eth0 s6-eth3:h6-eth0
	s7 lo:  s7-eth1:s5-eth3 s7-eth2:h7-eth0 s7-eth3:h8-eth0
	c0
	
	2. What is the output of “h7 ifconfig”
	
	h7-eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.0.0.7  netmask 255.0.0.0  broadcast 10.255.255.255
        inet6 fe80::70ba:d6ff:fe3a:c526  prefixlen 64  scopeid 0x20<link>
        ether 72:ba:d6:3a:c5:26  txqueuelen 1000  (Ethernet)
        RX packets 131164  bytes 11132200 (11.1 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 8  bytes 656 (656.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
        
        
Task 2:

	1. Draw the function call graph of this controller. For example, once a packet comes to the
	controller, which function is the first to be called, which one is the second, and so forth?
	
	R/=
	It would follow a sequence similar to the one that follows:
	
	Launch() --------> Handle_PacketIn() ---------> Act_like_hub() --------> Resend_packet()
	
	2.  Have h1 ping h2, and h1 ping h8 for 100 times (e.g., h1 ping -c100 p2).
	
	a. How long does it take (on average) to ping for each case?
	
	The ping from h1 to h2, takes on average 3.224 ms
	The ping from h1 to h8, takes on average 14.634 ms
	
	b.  What is the minimum and maximum ping you have observed?
	The minimun was 2.8564 ms and the maximun was 16.123 ms
	
	3. Run “iperf h1 h2” and “iperf h1 h8”
	
	a. What is “iperf” used for?
	
	iperf is a commonly used network testing tool that can create TCP and UDP data streams and measure the throughput of a network that is carrying them
	
	b. What is the throughput for each case?
	
	In the case of the iperf h1 h2, the minimun throughput is 4.594 Mbps and the maximum is 6.01 Mbps
	In the case of the iperf h1 h8, the minimun throughput is 2.997 Mbps and the maximum is 3.443 Mbps
	
	c. What is the difference, and explain the reasons for the difference.
	
	The differeance in the case of the maximum throughput is 2.567 and in the case of the minimum 1.597. This differeances might be due
	to the the topology we created in this case, as we can see in the representation of our topology there are more links and ways to go 		from h1 to h8, therefore this decreases the throughput considerably.
	
	4. Which of the switches observe traffic? Please describe your way for observing such
	traffic on switches (e.g., adding some functions in the “of_tutorial” controller).
	
	R/= The switches that observe traffict are definetly S2,S3,S1,S5,S7, due to the number of links they have. The way this can be achieved is by adding some prints in the "of_tutorial" controller file, this print statements can help us fetch the traffic these switches are receiving. 
	
	
Task 3:

	1. Describe how the above code works, such as how the "MAC to Port" map is established. You could use a ‘ping’ example to describe the establishment process (e.g., h1 ping h2). 
	
The first important aspect to mention is that the code above takes an interesting approach by utilizing the data structure dictionaries. In the first case, it sends a broadcast message to all the possible destination in the network when the destination address is not found the dictionary structure, after the destination is found it addes the key value pair to the registers in the dictionary. In contrast, it sends the message only to the destination address when the address is found correctly in the structure. 
	
	2. (Comment out all prints before doing this experiment) Have h1 ping h2, and h1 ping 
h8 for 100 times (e.g., h1 ping -c100 p2). 

	a. How long did it take (on average) to ping for each case? 
	
I	In order to ping from h1 to h2, it only takes 2.01 ms
	In order to ping from h1 to h8, it takes 11.92 ms
	
	b. What is the minimum and maximum ping you have observed? 
	
	Minimum was 1.28 ms and maximum was 51.42
	
	c. Any difference from Task 2 and why do you think there is a change if there is? 
	
	The differeance here is that thanks to the dictionary data structure that we are implementing here, we can use the strategy of sending a broadcast message when the destination address is not found and also, in the case in which is found we send it to the exact destination. Having both alternative make this approach more flexible and faster.
	
	3. Run “iperf h1 h2” and “iperf h1 h8”. 
	
	a. What is the throughput for each case? 
	
	the throughput from h1 to h2 is 5.97 Mbps and from h1 to h8 is 3.11
	
	b. What is the difference from Task 2 and why do you think there is a change if there is? 
	
	R/= We can clearly see that in this case the approach presented in task 3 performs better as well. This might be due to how precise and direct is this approach, since we go directly to our destination address withouth going through the whole network like we do in task 2.
	
	

