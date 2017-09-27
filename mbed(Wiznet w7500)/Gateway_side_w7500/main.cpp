#include "mbed.h"                                       //  date 27-9-2017
#include "AES.h"
#include "MQTTEthernet.h"
#include "MQTTClient.h"
#include "string.h"
#include "udaes.h"
#include "crc.h"
#define ECHO_SERVER_PORT   7
char msg[16];
char o_message[16];
char send_message[19];
char rec_message[18];
char dataReceive[21];
char encData[16];
char decData[16];
char message[16];
int u1,u2;
int h;
char crc_failed[]="FCRC";
char crc_check[3];
int arrivedcount = 0;
void crcCheck(int []);
Serial out(USBTX,USBRX);
Serial device(PA_13,PA_14);
void bluetooth();




void messageArrived(MQTT::MessageData& md)
{

    MQTT::Message &message = md.message;
    //  printf("\nMessage arrived: qos %d, retained %d, dup %d, packetid %d\n", message.qos, message.retained, message.dup, message.id);            //printing a message on console  including qos,dup,retained,packetid
    printf("%s\n", message.payloadlen, (char*)message.payload);
    printf(" message arrived is : %.*s\n", message.payloadlen, message.payload);
    printf("%d\n", message.payloadlen);

    memcpy(msg,message.payload, message.payloadlen);                            // copy the data from message payload to msg
    printf("Original message after subscription: %s", msg);

    // printData(msg, 16);

    printf("the msg is  %s\n:", msg);


    char* encrypt = encryptData(msg);                                           //encryptData() function for  data encryption
    int x3,x4;
    memset(msg,'\0',sizeof(msg));                                               //clearing message
    //Print the encrypted message
    printf("Encrypted message: \"%s\"", encrypt);
    // printData(encrypt, sizeof(encrypt));                                        // printData() function for converting encrypted message to hex format

    char* encrypt2 = encrypt;                                                   // crcCheck_transmit() for crc calculation
    char*  crc_check2=crcCheck_transmit(encrypt2);
    out.printf("\n from transmit function");
    for(x3=0; x3<18; x3++) {                                                    // copy the encrypted data to another char array
        send_message[x3]=crc_check2[x3];
    }


    out.printf("\nThe final data to be sent is : %s",send_message);
    for(int k=0; k<19; k++) {
        wait_ms(50);                                            //Wait for 20 milisecond
        //Print the character
        device.putc(send_message[k]);                               //Send the character via BLE
    }
    //device.printf(send_message);


    ++arrivedcount;
}
void baud(int baudrate)
{
    Serial s(USBTX, USBRX);
    s.baud(baudrate);
}
int main (void)
{
    //DHT sensor(D4, DHT11);

    char* topic = "light";                                                                             //topic name for MQTT
    MQTTEthernet ipstack = MQTTEthernet();
    MQTT::Client<MQTTEthernet, Countdown> client = MQTT::Client<MQTTEthernet, Countdown>(ipstack);
    char* hostname = "172.16.73.4";                                                                    // MQTT broker address
    int port = 1883;                                                                                    //port no for broker
    int rc = ipstack.connect(hostname, port);
    if (rc == 0)                                                                 // 0 means it ois connected (from TCP connect)
        printf("rc from TCP connect is %d\n", rc);


    MQTTPacket_connectData data = MQTTPacket_connectData_initializer;
    data.MQTTVersion = 3;
    data.clientID.cstring = "parents";

    if ((rc = client.connect(data)) == 0)                                       // 0 means it ois connected (from MQTT connect)
        out.printf("rc from MQTT connect is %d\n", rc);

    if ((rc = client.subscribe(topic, MQTT::QOS0, messageArrived)) == 0)        // subscribe to the topic by topic name

        out.printf("rc from MQTT subscribe is %d\n", rc);


    MQTT::Message message;
    char buf[100];
    int error = 0;

    h=0;
    int p=0;
    while (true) {

        if(device.readable()) {
            p=0;
            bluetooth();                                                        // colling bluetooth() function for data reading from slave device
            out.printf("\nThe received message is : %s",dataReceive);           // printing the message after data reading from slave device

            if(dataReceive[0]=='F' ) {                                      // CRC failed message sending to the slave
                for(int q2=0; q2<19; q2++) {
                    wait_ms(50);
                    out.putc(send_message[q2]);
                    device.putc(send_message[q2]);
                }
            }

            else {
                for(int q1=0; q1<18; q1++) {
                    rec_message[q1]=dataReceive[q1];
                    p++;
                }
                out.printf("\nThe data to be CRC checked is : %s\n",rec_message);
                int flg=crcCheck_receive(rec_message);                              //calling  crcCheck_receive() function for checking crc is ok or not
                memset(rec_message,'\0',sizeof(rec_message));

                if(flg==0) {                                                        // checking flag for correct crc
                    out.printf("\n CRC ok");
                    for(int q=0; q<16; q++) {                                          // for data storing in another char array by removing dummi start bits
                        encData[q]=dataReceive[q];

                    }
                    out.printf("\nThe data to be decrypted is : %s",encData);
                    char* decryptedData = decryptData(encData);                         // calling decryptData() function for decrypt the data

                    out.printf("\nThe final decrypted Data is: %s",decryptedData);      // printing the decrypted data
                    if(decryptedData[0]=='L' ) {
                        message.qos = MQTT::QOS0;
                        message.retained = false;                                           //A retained message is a normal MQTT message with the retained flag set to true. The broker will store the last retained message and the corresponding QoS for that topic.
                        // if it is false The broker will not store the last retained message.
                        message.dup = false;                                                // the broker will not create duplicate message
                        message.payload = (void*)decryptedData;                             // decrypting the message

                        message.payloadlen = strlen(decryptedData);                         // finding the length of the message

                        // rc = client.publish("/1/ON", message);
                        rc = client.publish("/1/ON", message);


                    }

                    else if(decryptedData[0]=='0' || decryptedData[0]=='1' || decryptedData[0]=='2' || decryptedData[0]=='3' || decryptedData[0]=='4' || decryptedData[0]=='5' || decryptedData[0]=='6' || decryptedData[0]=='7' || decryptedData[0]=='8' || decryptedData[0]=='9' ) {
                        message.qos = MQTT::QOS0;
                        message.retained = false;                                           //A retained message is a normal MQTT message with the retained flag set to true. The broker will store the last retained message and the corresponding QoS for that topic.
                        // if it is false The broker will not store the last retained message.
                        message.dup = false;                                                // the broker will not create duplicate message
                        message.payload = (void*)decryptedData;                             // decrypting the message

                        message.payloadlen = strlen(decryptedData);                         // finding the length of the message

                        // rc = client.publish("/1/ON", message);
                        rc = client.publish("/1/Temp", message);


                    } else {
                        out.printf("\n Data is not correct");
                        memset(dataReceive,'\0',sizeof(dataReceive));
                        wait(5);
                        for(int k3=0; k3<5; k3++) {
                            wait_ms(50);                                            //Wait for 50 milisecond
                            device.putc(crc_failed[k3]);
                            out.putc(crc_failed[k3]);                          //Send the character via BLE
                        }
                    }
                } else {
                    memset(dataReceive,'\0',sizeof(dataReceive));
                    memset(rec_message,'\0',sizeof(rec_message));
                    out.printf("\n CRC failed");

                    wait(5);

                    for(int k1=0; k1<5; k1++) {
                        wait_ms(50);                                            //Wait for 50 milisecond
                        device.putc(crc_failed[k1]);
                        out.putc(crc_failed[k1]);                           //Send the character via BLE
                    }

                }
            }
            memset(dataReceive,'\0',sizeof(dataReceive));                       // clearing the dataReceive buffer
            memset(msg,'\0',sizeof(msg));                                       // clearing the msg buffer
            memset(encData,'\0',sizeof(encData));
        }
        client.yield(20);
    }
}
void bluetooth()                                                                //bluetooth function for reading data from slave device
{
    int z=0;
    while(1) {
        if(device.readable()) {
            char c=device.getc();
            if(c=='\0') {                                                       // if char is null then return to main function where it was called
                z=0;
                return;
            } else {
                dataReceive[z]=c;                                               // storing the characters which are received from slave
                printf("%c",c);
                z++;
            }
        }
    }
}

