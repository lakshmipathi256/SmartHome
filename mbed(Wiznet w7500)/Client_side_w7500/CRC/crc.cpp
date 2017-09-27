#include "mbed.h"
#include "crc.h"
Serial output(USBTX,USBRX);                                          //USB serial to print the data in the console
char result1[18];                                                    //To store the character format of the CRC bit
int binary1[256];                                                    //To store the binary data in integer type
char binary2[256];                                                   //To store the binary data in chracter type
int generator[]= {1,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0};                  //CRC generator 
int v,v1;


//Function for generating CRC and transmitting it
char* crcCheck_transmit(char* targetChar)                                       //for transmission the data from gateway to slave device with crc
{
    int i1,j1,k1,l1,h1;



    v=0,v1=0;
    for(h1=0; h1<16; h1++) {                                                    //loop for binary printing
        printBinary(targetChar[h1]);
        output.printf(" - ");                               
    }
    //output.printf("%d",sizeof(f));
   // output.printf("\n The data to be analyzed is : ");
    int frame[v+16];
    for(h1=0; h1<v; h1++) {                                                     //storing the binary data in frame array                                                    
       // output.printf("%d",binary1[h1]);
        frame[h1]=binary1[h1];
    }
    //frame[2]=0;
 /*   output.printf("\n The value of v is : %d ",v);                              //Printing the value of V i.e total binary no.

    output.printf("\n Sender Side:");
    output.printf("\n Frame: ");*/
  /*  for(i1=0; i1<v; i1++) {                                                     // total binary stream printing 
        output.printf("%d",frame[i1]);
    }
    output.printf("\n Generator : ");            */                               // generator for CRC checking
   /* for(i1=0; i1<16; i1++) {
        output.printf("%d",generator[i1]);
    }*/

    //Append 0's
    int rs1=16-1;
    for (i1=v; i1<v+rs1; i1++) {                                                //appending the zeros to the data for calculating the crc 
        frame[i1]=0;
    }

    int temp2[v+16];
    for(i1=0; i1<v+16; i1++) {                                                  // copying the data from one array to another array
        temp2[i1]=frame[i1];
    }

  /*  output.printf("\n Message after appending 0's :");
    for(i1=0; i1<v+rs1; i1++) {                                                 //printing the data after appending zeros
        output.printf("%d",temp2[i1]);
    }*/

    //Division
    for(i1=0; i1<v; i1++) {                                                     //CRC generating  through division operation
        j1=0;
        k1=i1;
        //check whether it is divisible or not
        if (temp2[k1]>=generator[j1]) {
            for(j1=0,k1=i1; j1<16; j1++,k1++) {
                if((temp2[k1]==1 && generator[j1]==1) || (temp2[k1]==0 && generator[j1]==0)) {
                    temp2[k1]=0;
                } else {
                    temp2[k1]=1;
                }
            }
        }
    }

    //CRC
    int crc[16];
    for(i1=0,j1=v; i1<rs1; i1++,j1++) {                                         // storing CRC bits in CRC array
        crc[i1]=temp2[j1];
    }

    /*output.printf("\n CRC bits: ");                                             
    for(i1=0; i1<rs1; i1++) {                                                   //printing CRC bits
        output.printf("%d",crc[i1]);
    }*/

    //output.printf("\n Transmitted Frame: ");
    int tf2[v+16];
    char tf3[v+16];
    for(i1=0; i1<v; i1++) {                                                     // copying the data from one to another                          
        tf2[i1]=frame[i1];
    }
    for(i1=v,j1=0; i1<v+rs1; i1++,j1++) {                                       // Adding CRC bits to the data
        tf2[i1]=crc[j1];
    }
 /*   for(i1=0; i1<v+rs1; i1++) {                                                 // printing the data after adding the CRC bits to the data
        output.printf("%d",tf2[i1]);
    }*/

    tf2[v+rs1]=0;

 /*   output.printf("\n The final data to be sent is : ");                        // printing the Final data 
    for(i1=0; i1<=v+rs1; i1++) {
        output.printf("%d",tf2[i1]);
    }*/
    
   /* for(i1=0;i1<7;i1++)
    {
        tf2[i1]=1;
    }
    for(i1=136;i1<144;i1++)
    {
        tf2[i1]=1;
    }*/
    output.printf("\n The final data to be sent is : ");                        // printing the Final data 
    for(i1=0; i1<=v+rs1; i1++) {
        output.printf("%d",tf2[i1]);
        }
    for(i1=0; i1<=v+rs1; i1++) {
        charBinary(tf2[i1]);
    }
   /* output.printf("\n The final data to be sent is : ");
    for(i1=0; i1<=v+rs1; i1++) {
        output.printf("%c",binary2[i1]);
    }*/
    printChar(binary2);

    char* str=result1;
    //result1[18]='!';
    output.printf("\n check %s ", str);
    v=0,v1=0;
    return result1;
}



//Function for CRC Checksum
int crcCheck_receive(char  a1[])
{
    int i,j,k,l;                                //Variable required for CRC checksum
    int rs=15;                                  //Value of should be N - 1 if the generator is of N bits
    v=0;
    /*output.printf("\n Receiver side : ");
    output.printf("\n Received Frame: ");*/

//For loop to convert the given data to binary form
for(int m=0; m<18; m++) {
                printBinary(a1[m]);
                output.printf("-");
            }
            
    //For loop to print the binary form of the data        
   /* for(i=0; i<v; i++) {
        output.printf("%d",binary1[i]);
    }*/
    v=v-16;
    int tf[v+16];           //Variable to store the binsry form of the data
    
    //For loop to store the bianry form of data into tf
    for(i=0; i<v+rs; i++) {
        tf[i]=binary1[i];
    }
    
   /* output.printf("\n");
    output.printf("The data to be Analyzed on the receiving side : ");*/
    
    //For loop to print the data to be analyzed
    /*for(i=0; i<v+rs; i++) {
        output.printf("%d",tf[i]);
    }*/
    
    int temp[v+16];
     int temp2[v+16];
    for(i=0; i<v+rs; i++) {
        temp[i]=tf[i];
    }
    output.printf("\n The value before operation is :");
for(i=0; i<v+rs; i++) {
        output.printf("%d",temp[i]);
    }
    //Division
    for(i=0; i<v; i++) {
        j=0;
        k=i;
        if (temp[k]>=generator[j]) {
            for(j=0,k=i; j<16; j++,k++) {
                if(temp[k] == generator[j]) {               //If the data bit and generator bit are same 
                    temp[k]=0;                                                                         //Result is 0
                } else {                                                                               //If the data bit and generator bit are not same
                    temp[k]=1;                                                                         //Result is 1
                }
            }
        }
    }
     output.printf("\n The value after operation is :");
   for(i=0; i<v+rs; i++) {
        output.printf("%d",temp[i]);
    }
    output.printf("\n Reaminder: ");
    int rrem[16];                                                                                     //Char array to store the remainder of the CRC checksum
    
    //For loop to store the remainder
    for (i=v,j=0; i<v+rs; i++,j++) {
        rrem[j]= temp[i];
    }
    
    //For loop to print the remainder
    for(i=0; i<rs; i++) {
        output.printf("%d",rrem[i]);
    }

    int flag=0;                          //Variable to store the status of the flag
    
    //For loop to check the remainder
    for(i=0; i<rs; i++) {
        if(rrem[i]!=0) {      //If remainder bit is not equal to 0
            flag=1;            //Set the flag value as 1
            break;
        }
    }

    if(flag==0) {          //if flag value is 0
        //output.printf("\n Since Remainder Is 0 Hence Message Transmitted From Sender To Receriver Is Correct");
        return 0;          //Return 0
        

    } else {              //if flag value is not zero
       // output.printf(" \n Since Remainder Is Not 0 Hence Message Transmitted From Sender To Receriver Contains Error");
       return 1;          //return 1
    }
    v=0;
}

//Function to print the binary format of the data which takes char c as a parameter
void printBinary(char c)
{

    for (int i = 7; i >= 0; --i) {
        int x = ((c & (1 << i))? 1 : 0);
        output.printf("%d",x);
        binary1[v]=x;
        v++;
    }
}

//Function to convertthe data  from integer form to binary form which takes int c1 as parameter
void charBinary(int c1)
{
    char x1 = ((c1 & 1)? '1' : '0');
    //   output.printf("%c",x1);
    binary2[v1]=x1;
    v1++;
}


/* ####### printChar function to convert the binary value into the respective character ########## */

void printChar(char x2[])
{

    //memcpy(a, b, sizeof(a));
    char *ON = x2 ;
    output.printf("\n");
    output.printf("%c",x2);
    char subbuff[9];
    for(int j=0; j<sizeof(result1); j++) {
        result1[j]='\0';
    }
    unsigned char c3;
    int k1;
    int index = 0;
    int fichero_len = (int)strlen(ON);

    for(k1 = 0; k1 < fichero_len; k1 += 8) {
        memcpy(subbuff, &ON[k1], 8);                   // <--- copy 8 butes only
        subbuff[8] = '\0';
        c3 = (unsigned char)strtol(subbuff, 0, 2);
        //printf("\%s = %c = %d = 0x%.2X\n", subbuff, c3, c3, c3);
        result1[index++] = c3;
        result1[index] = '\0';
    }
    printf("\nResult = %s\n", result1);

}

