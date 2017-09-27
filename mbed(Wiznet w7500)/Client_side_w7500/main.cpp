/***************************************************************************************************                PROGRAM FOR CONFIGURATION OF SLAVE DEVICE                 ******************************************************************************/
#include "mbed.h"
#include "string.h"
#include "udaes.h"
#include "crc.h"

#include<sstream>
#include "AES.h"

Serial pc(USBTX,USBRX);                //Serial Configuration for USB serial
Serial device(PA_13,PA_14);            //Serial Configuration for Bluetooth
DigitalOut myled(D13);                 //Indicator to show status of the command coming from gateway
AnalogIn ldr(A0);                      //Reading from LDR
AnalogIn temp(A1);   
int compare_strings(char [], char []); //Function for comparing two strings to compare with the command coming from the gateway
void dataPattern(char [],int);             //Function for Dataformat of the data to be sent
void bluetooth();
int flag,flag1,count=0,w1=0;
char ackmsgon[7]="LED ON";            //Response for the status of the LED
char ackmsgoff[8]="LED OFF";          //Response for the status of the LED
char sendData[21];                     //Data to be sent to the gateway with the encrypted format of the response
char message2[18];                     //Received formatted messsage from the gateway
char message3[18];
char encryptedData[16];                     //Encrypted message from the gateway
char ldrsensor[9];                    //Reading from the LDR
char tempsensor[9];
char* encrypt;
char* decrypt;
char crc1[3];
int final[26];
char dataReceive[30];
//Main function
int main()
{

    int x,p2=0;
    char command_buf[] = {'O','N'};                //Data for the comparision with the command received from the gateway
    char command_buf1[] = {'O','F','F'};           //Data for the comaprision with the command received from the gateway
    myled = 1;
    while(1) {
        //  count=0;
        float ldrout = ldr.read();                  //Read the LDR
        float tempout = temp.read();
        float tempC = ((tempout*3.3)-0.600)*100.0;
        //  int err = sensor.readData();
       //   pc.printf("\nTemperature is : %f",tempC);
   //  wait(1);
        if(device.readable()) {                     // Check whether the data is received BLE or not
          bluetooth();                //Receive the message and store it in message2
          device.gets(dataReceive,19);
            pc.printf("The data received is : %s",dataReceive);                      //Print the message2


            for(x=0; x<19; x++) {
                message3[x]=dataReceive[x];              //Extract the exact encrypted data with CRC bytes from message2 and store it in message3
            }
            for(x=0; x<30; x++) {
                dataReceive[x]='\0';              //Extract the exact encrypted data with CRC bytes from message2 and store it in message3
            }

            int flg = crcCheck_receive(message3);   //Do the CRC check for the message3
            pc.printf("\n The flag  value is : %d",flg);  //Print the status of the flg which the output of the crcCheck_receive
            if(flg==0) {                                  //if flg is 0
                pc.printf("\nCRC operation is successful");       //print CRC operation is successful
                for(x=0; x<16; x++) {
                    encryptedData[x]=message3[x];              //Extract the encrypted data from the message3 and store it in encryptedData
                }
                decrypt = decryptData(encryptedData);          //Decrypt the encryptedData and store it in decrypt
                flag = compare_strings(decrypt, command_buf);    //Compare the decrypted the message for "ON" condition and store the status in flag
                flag1 = compare_strings(decrypt, command_buf1);  //Compare the decrypted the message for "OFF" condition and store the status in flag1

                //if message1 is ON
                if (flag == 1) {
                    myled = 0;                                     //Turn ON the LED
                   // wait_ms(1);                                       //Wait for 1 second
                    encrypt=encryptData(ackmsgon);
                                     //Encrypt the response
                    dataPattern(encrypt,50);                        //Create the datapattern and combine it with the encrypted repsonse and send it to the gateway

                }
                //if message1 is OFF
                else if(flag1==1) {
                    myled =1;                                     //Turn OFF the LED
                  //  wait_ms(10);                                      //Wait for 1 second
                    encrypt=encryptData(ackmsgoff);                        //Encrypt the response
                    dataPattern(encrypt,50);                       //Create the datapattern and combine it with the encrypted repsonse and send it to the gateway

                }
                else if(flag1==1) {
                    myled =1;                                     //Turn OFF the LED
                  //  wait_ms(10);                                      //Wait for 1 second
                    encrypt=encryptData(ackmsgoff);                        //Encrypt the response
                    dataPattern(encrypt,50);                       //Create the datapattern and combine it with the encrypted repsonse and send it to the gateway

                }
            } else {
                pc.printf("\nCRC Operation Failed");
            }
        }

        //if LDR reading is greater than or equal to 0.200000
       /* else if(ldrout>0.200000) {
                                                    //Wait for 1 second
            sprintf(ldrsensor,"%f",ldrout);                 //Convert the float format to string format
            ldrsensor[8]='0';
            encrypt=encryptData(ldrsensor);                        //Encrypt the response
            dataPattern(encrypt,100);
            memset(ldrsensor,'\0',sizeof(ldrsensor));                          //Create the datapattern and combine it with the encrypted LDR reading and send it to the gateway
             wait(5);
        }*/

       /*else if(tempC>25.000000) {
                                                    //Wait for 1 second
            sprintf(tempsensor,"%f",tempout);                 //Convert the float format to string format
            //tempsensor[8]='0';
            encrypt=encryptData(tempsensor);                        //Encrypt the response
            dataPattern(encrypt,100);                          //Create the datapattern and combine it with the encrypted LDR reading and send it to the gateway
             memset(tempsensor,'\0',sizeof(tempsensor)); 
             wait(5);
        }*/
    }




}
//Function for the data pattern format
void dataPattern(char* encack,int time)
{
    // v3=0;
    int v2=0;
    int w2;
    //Adding the start bit[0]
   
    //Adding the whole encrypted data
    /*  for(int w=2;w<18;w++)
      {
          sendData[w]=encack[v3];
          v3++;
      }*/
  


    char* crctr = crcCheck_transmit(encack);                      //Genrating the CRC bits from the encrypted data and store it in crctr
   
    
    for(w2=0; w2<18; w2++) {
        sendData[w2]=crctr[w2];                               //Storing the CRC along with the encrypted data in the sendData
      
    }
    pc.printf("\n The Data should be sent is : %s\n",sendData);    //Print the whole format of the data combined with encrypted data


    //For loop for sending the whole data via BLE
    for(int k=0; k<19; k++) {
        wait_ms(time);                                            //Wait for 20 milisecond
        pc.putc(sendData[k]);                                   //Print the character
        device.putc(sendData[k]);                               //Send the character via BLE
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
                dataReceive[z]=c;                                  //
                printf("%c",c);
                z++;
            }
        }
    }
}
//Function to compare two strings
int compare_strings(char a[], char b[])
{
    int c = 0;                                                      //Initial count=0
    int n=strlen(decrypt);                                          //Size of the decrypted message

    //Run the loop till the size is less than n
    for(int s=0; s<n; s++) {
        if(a[s] == b[s])            //if both the data is matched in the respective location
            c++;                    //Increment c
        else                        //if both the data is not matched in the respective location
            break;                  //Break the loop
    }


    if(c==n) {                      //If c is equal to n
        return 1;                   //return 1
    } else                         //If c is not equal to n
        return 0;                  //Return 0
}
