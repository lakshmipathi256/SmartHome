
#if !defined(MQTTETHERNET_H)
#define MQTTETHERNET_H

#include "MQTTmbed.h"
#include "EthernetInterface.h"
#include "MQTTSocket.h"



class MQTTEthernet : public MQTTSocket
{
public:    
    MQTTEthernet()
    {
        wait(1);
        this->createSocket();
        //eth.init(mac_addr,ip_addr,snmask,gw_addr);                          // Do not use DHCP! If you use DHCP use "eth.init(mac_addr);".
        uint8_t mac_addr[6] = {0x00, 0x08, 0xDC, 0x32, 0x23, 0x42}; 

  eth.init(mac_addr);
  
  printf("Check Ethernet Link\r\n");
    while(1) { //Wait link up
        if(eth.link() == true)
            break;
    }
    printf("Link up\r\n");

    int ethErr = eth.connect();
    
  
  if(ethErr < 0)
  {
    printf("Error %d in setup.\n", ethErr);
  }
  printf("Server IP Address is %s\r\n", eth.getIPAddress());
  
    }
    
    EthernetInterface& getEth()
    {
        return eth;
    }
    
    void reconnect()
    {
        eth.connect();  // nothing I've tried actually works to reconnect 
    }
    
private:

    EthernetInterface eth;
    
};


#endif
