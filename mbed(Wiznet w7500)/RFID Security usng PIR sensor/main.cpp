#include "mbed.h"
#include "DHT.h"
#include "MQTTEthernet.h"
#include "MQTTClient.h"
#define   ECHO_SERVER_PORT   7
#include "MFRC522.h"
#include <sstream>
#include <string>

#define RST_PIN       9           // Configurable, see typical pin layout above
#define SPI_MOSI    D11
#define SPI_MISO    D12
#define SPI_SCLK    D13
#define SPI_CS      D10
#define MF_RESET    D9

DigitalOut pirLED(D3);
DigitalOut securityAlert(D4);
DigitalOut authenticatedLED(D5);
DigitalIn PIRsensor(D7);
int pirSensorValue;
Serial pc(USBTX, USBRX);
char* store_buf;
uint8_t buffer[128];
int k=0;
char save[512];
char save1[512];

MFRC522    RfChip (SPI_MOSI, SPI_MISO, SPI_SCLK, SPI_CS, MF_RESET);        // Init MFRC522 card
/* Local functions */
void DumpToSerial(MFRC522::Uid *uid);
void DumpMifareUltralightToSerial   (void);
/**
 * Dumps debug info about the selected PICC to Serial.
 * On success the PICC is halted after dumping the data.
 * For MIFARE Classic the factory default key of 0xFFFFFFFFFFFF is tried.
 */
char* securityStatus;
int arrivedcount = 0;
void messageArrived(MQTT::MessageData& md)
{

    MQTT::Message &message = md.message;
    printf("Message arrived: qos %d, retained %d, dup %d, packetid %d\n", message.qos, message.retained, message.dup, message.id);
    printf("Payload %.*s\n", message.payloadlen, (char*)message.payload);
    printf("message is; %s",(char*)message.payload);
    securityStatus=(char*)message.payload;
    printf("securityStatus is; %c",securityStatus);
    printf("payloadlen is %d\n", message.payloadlen);
    ++arrivedcount;
}
void baud(int baudrate)
{
    Serial s(USBTX, USBRX);
    s.baud(baudrate);
}
void DumpToSerial(MFRC522::Uid *uid)
{
    MFRC522::MIFARE_Key key;

    // Print Card UID
    printf("Card UID: ");
    for (uint8_t i = 0; i < RfChip.uid.size; i++) {
        printf(" %X", RfChip.uid.uidByte[i]);
    }
    printf("\n\r");

    // Print Card type
    uint8_t piccType = RfChip.PICC_GetType(RfChip.uid.sak);
    printf("PICC Type: %s \n\r", RfChip.PICC_GetTypeName(piccType));
    wait_ms(50);

    // Dump contents
    switch (piccType) {
        case MFRC522::PICC_TYPE_MIFARE_MINI:
        case MFRC522::PICC_TYPE_MIFARE_1K:
        case MFRC522::PICC_TYPE_MIFARE_4K:
            // All keys are set to FFFFFFFFFFFFh at chip delivery from the factory.
            for (uint8_t i = 0; i < 6; i++) {
                key.keyByte[i] = 0xFF;
            }

        case MFRC522::PICC_TYPE_MIFARE_UL:
            DumpMifareUltralightToSerial();

            break;
        case MFRC522::PICC_TYPE_TNP3XXX:
            printf("Dumping memory contents not implemented for that PICC type. \n\r");
            break;
        case MFRC522::PICC_TYPE_ISO_14443_4:
        case MFRC522::PICC_TYPE_ISO_18092:
        case MFRC522::PICC_TYPE_MIFARE_PLUS:
            printf("Dumping memory contents not implemented for that PICC type. \n\r");
            break;

        case MFRC522::PICC_TYPE_UNKNOWN:
        case MFRC522::PICC_TYPE_NOT_COMPLETE:
        default:
            break; // No memory dump here
    }

    printf("\n\r");

    RfChip.PICC_HaltA(); // Already done if it was a MIFARE Classic PICC.
} // End PICC_DumpToSerial()


/**
 * Dumps memory contents of a MIFARE Classic PICC.
 * On success the PICC is halted after dumping the data.
 */

void DumpMifareUltralightToSerial(void)
{
    uint8_t status;
    uint8_t byteCount;
    //uint8_t buffer[512];
    uint8_t i;
    printf("Page   0   1   2   3 \n");

    // Try the mpages of the original Ultralight. Ultralight C has more pages.
    for (uint8_t page = 0; page < 48; page +=4) {
        // Read pages
        byteCount = sizeof(buffer);
        status = RfChip.MIFARE_Read(page, buffer, &byteCount);
        if (status != MFRC522::STATUS_OK) {
            printf("MIFARE_Read() failed: %s \n\r", RfChip.GetStatusCodeName(status));
            break;
        }

        // Dump data
        for (uint8_t offset = 0; offset < 4; offset++) {

            i = page + offset;

            printf(" %2d  ", i); // Pad with spaces

            for (uint8_t index = 0; index < 4; index++,k++) {
                i = 4 * offset + index;
                save[k]=buffer[i];
                printf("%c ", buffer[i]);
            }
            printf("\n\r");
        }

    }

    printf("message is : %s",save);

} // End PICC_DumpMifareUltralightToSerial()
int main (void)
{

    char RFIDTagMessage[7];
    pc.printf("starting...\n");
    pc.baud(9600);
    // Init. RC522 Chip
    RfChip.PCD_Init();
    char* securityTopic = "/cdilab/security";
    MQTTEthernet ipstack = MQTTEthernet();

    MQTT::Client<MQTTEthernet, Countdown> client = MQTT::Client<MQTTEthernet, Countdown>(ipstack);

    char* hostname = "172.16.73.4";
    /* char* hostname = "iot.eclipse.org";*/
    int port = 1883;
    int rc = ipstack.connect(hostname, port);
    if (rc != 0)
        printf("rc from TCP connect is %d\n", rc);
    printf("securityTopic: %s\r\n",securityTopic);
    MQTTPacket_connectData data = MQTTPacket_connectData_initializer;
    data.MQTTVersion = 3;
    data.clientID.cstring = "parents";
    if ((rc = client.connect(data)) != 0)
        printf("rc from MQTT connect is %d\n", rc);
    if ((rc = client.subscribe(securityTopic, MQTT::QOS0, messageArrived)) != 0) {

        printf("rc from MQTT subscribe is %d\n", rc);
    }

    MQTT::Message message;



    while(true) {

        client.yield(6000);

        while(securityStatus) {
            pirSensorValue=PIRsensor.read();
            pc.printf("PIR sensor %d \n",pirSensorValue);
            int swipeCount=0;
            if(pirSensorValue==1) {
                pirLED = 1;
                wait(2);
                while(true) {
                    if ( ! RfChip.PICC_IsNewCardPresent()) {
                        wait_ms(1000);
                        swipeCount++;
                        pc.printf("Waiting for swipe RFID max 8 sec  : %d ",swipeCount);
                        if(swipeCount==8) {
                            securityAlert=1;
                            char securityMessage[20]= "Wrong person";
                            message.qos = MQTT::QOS0;
                            message.retained = false;
                            message.dup = false;
                            message.payload = (void*)securityMessage;
                            message.payloadlen = strlen(securityMessage);
                            rc = client.publish("/cdilab/rfid/rfiddata", message);
                            securityStatus=0;
                            break;
                        }

                    }
                    // Select one of the cards
                    if ( ! RfChip.PICC_ReadCardSerial()) {
                        wait_ms(50);
                        continue;
                    }
                    // Dump debug info about the card. PICC_HaltA() is automatically called.
                    DumpToSerial(&(RfChip.uid));
                    wait_ms(50);
                    // Print Card UID
                    pc.printf("Card UID: ");
                    for (uint8_t i = 0;  i < RfChip.uid.size; i++) {
                        pc.printf("%X",RfChip.uid.uidByte[i]);
                        store_buf+= sprintf(store_buf,"%X",RfChip.uid.uidByte[i]);
                    }
                    pc.printf("\n");
                    store_buf=RFIDTagMessage;
                    message.qos = MQTT::QOS0;
                    message.retained = false;
                    message.dup = false;
                    message.payload = (void*)RFIDTagMessage;
                    message.payloadlen = strlen(RFIDTagMessage);
                    rc = client.publish("rfidData", message);
                    pc.printf("\n\r");
                    pc.printf("%d", message.payloadlen);
                    authenticatedLED=1;
                    pirSensorValue=0;
                    securityStatus=0;
                    break;
                }
                break;
            } else {
                securityAlert=0;
                authenticatedLED=0;
                pirLED = 0;
                swipeCount=0;
                wait(2);
                securityStatus=0;
                break;
            }

        }
        wait(5);
        securityAlert=0;
        authenticatedLED=0;
        pirLED = 0;

    }

}