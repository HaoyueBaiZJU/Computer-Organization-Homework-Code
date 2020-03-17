#include<iostream>
#include<string>
#include <math.h>
using namespace std;

void mirror(int n, int smallArray[], int bigArray[]);
void addOneToLeft(int n, int array[]);
void printGrayCode(int n, int array[]);

int main(){
	int n;
//array1[] holds the trivial 1-bit Gray code
	int array1[2]={0,1};
//array2[] holds the 2-bit Gray code generated from the Gray code in array1
	int array2[4];
//array3[] holds the 3-bit Gray code generated from the Gray code in array2
	int array3[8];
//array4[] holds the 4-bit Gray code generated from the Gray code in array3
	int array4[16];

	cout << "Please enter the bit number (range: 1~4) of Gray Code: ";
	cin>>n;
	cout<<"The Gray Code output is"<<endl;

    // assume user entered n is always valid in the range 1,2,3,4
	if (n == 1){//user indicates he/she wants to output the 1-bit Gray code
	    // no need to generate, it is already in array1[], so just print it
		printGrayCode(n, array1);
	}
	else{
		// generate 2-bit Gray Code
		mirror(2, array1, array2);
		addOneToLeft(2, array2);
		if (n==2){
        //user wants to output the 2-bit Gray code
			printGrayCode(n, array2); return 0;}

		// generate 3-bit Gray Code
		mirror(4, array2, array3);
		addOneToLeft(4, array3);
		if (n==3){
        //user wants to output the 3-bit Gray code
printGrayCode(n, array3); return 0;}

		// generate 4-bit Gray Code
		mirror(8, array3, array4);
		addOneToLeft(8, array4);
		if (n==4){
// user wants to output the 4-bit Gray code
printGrayCode(n, array4); return 0;}
		} // end if (n==4){}
} // end else{}


void mirror(int n, int smallArray[], int bigArray[]){
	int len=n+n; // length of the bigArray[] for the new Gray code is 2*n

    //mirror the elements of smallArray[] to occupy the right half of
    //bigArray[]
	for(int i=len/2;i<len;i++){
		bigArray[i]=smallArray[len-i-1];
	}

    //copy the elements of smallArray[] to occupy the left half of
    //bigArray[]
	for(int i=0;i<len/2;i++){
		bigArray[i]=smallArray[i];
	}
	return;
}

void addOneToLeft(int n, int array[]){
	int len=n+n;
	int value=n;

	//add one to the elements at the right half of array[]
	//leave the elements at the left half of the array[] unchanged
	for(int i=len/2;i<len;i++){
		array[i]= value+array[i];
	}
	return;
}


//output each elements in the array[] in n bits.
//pad "0" to the left whenever necessary to make the output to be n-bit
void printGrayCode(int n, int array[]){
    for(int i=0;i<(int)pow(2,n);i++){
		int r;
		int q;
		int ch[n];
		for (int j=n;j>0;j--){
			r = array[i] % 2;
		    q = array[i] / 2;
		    array[i] = q;
			ch[j]=r;
		}
		for (int j=1;j<=n;j++){
			cout<<ch[j];
		}
        cout<<"  ";
	}
	return;
}
