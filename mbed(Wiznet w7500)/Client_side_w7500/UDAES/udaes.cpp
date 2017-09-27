#include "mbed.h"
#include "udaes.h"
#include "AES.h"
#include<cstring>

Serial aespc(USBTX,USBRX);             //USB serial pin to print in the console
AES aes;                               //Object for AES
const char key[16] = { 0x2B, 0x7E, 0x15, 0x16, 0x28, 0xAE, 0xD2, 0xA6, 0xAB, 0xF7, 0x15, 0x88, 0x09, 0xCF, 0x4F, 0x3C }; //Key used for AES encryption and decryption
const char iv[16] = { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F };  //Format used for AES-CBC encryption and decryption
char message1[16];     //Character array to store the decrypted message
char encackmsg[16];    //Character array to store the encrypted message


//Function to print the hexadecimal ASCII value of the data taking data and its length as parameters
void printData(const void* data, size_t length)
{
    const char* dataBytes = (const char*)data;   //Casting the data to the character pointers
    for (size_t i = 0; i < length; i++) {  
        if ((i % 8) == 0)
            printf("\n\t");
        printf("0x%02X, ", dataBytes[i]);       //Print the hexadecimal ASCII value of the respective character
    }
    printf("\n");
}


//Function for encryption of data taking char enc[] as a parameter
char* encryptData(char enc[])
{
      printf("\nOriginal message: \"%s\"", enc);                 //Print the message to be encrypted i.e. enc[] 
     //printData(enc, 16);                                         //Print the hexadecimal ASCII form of the data
     aes.setup(key, AES::KEY_128, AES::MODE_CBC, iv);            //Setup the configuration of AES in 128 bit and CBC mode
     aes.encrypt(enc, encackmsg, 16);                            //Encrypt the given message and store it in encackmsg
     aes.clear();                                                //clear the AES
     printf("\nEncrypted message: \"%s\"\n", encackmsg);         //Print the encrypted data stored in encackmsg
     printData(encackmsg, sizeof(encackmsg));                    //Print the hexadecimal ASCII form of the encackmsg
     char* encstr=encackmsg;                                     //Store the value of encackmsg in encstr
     return encstr;                                              //Return encstr
}


//Function for decryption of data taking char dec[] as a parameter
char* decryptData(char dec[])
{
     //aespc.printf("\nThe received message is : %s",dec);         //Print the decrypted data to be encrypted i.e. dec[]
     aes.setup(key, AES::KEY_128, AES::MODE_CBC, iv);            //Setup the configuration of AES in 128 bit and CBC mode
     aes.decrypt(dec, message1, sizeof(dec));                    //Decrypt the given encrypted data and store it in message1
     aes.clear();                                                //clear the AES
     printf("\nDecrypted message: \"%s\"", message1);            //Print the Decrypted data stored in message1
   //  printData(message1, sizeof(message1));                      //Print the hexadecimal ASCII form of the message1
     char* decstr=message1;                                      //Store the value of message1 in decstr
     return decstr;                                              //Return decstr

}