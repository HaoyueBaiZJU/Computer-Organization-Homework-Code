#include<iostream>
using namespace std;

void arrayPrint(const int array[], int size);
void countPrint(const int array[], int size);
void binCount(const int A[], int A_count[], int size);

int main(){
  const int SIZE = 10;
  const int MAX_RANGE= 99;
  int A[SIZE];
  int A_count[MAX_RANGE+1]={}; // empty initialization list will initialize 
                                  // every element of A_count[] to 0

  cout << " Please enter an integer from 0 to 99 into the array A[] one by one:"<<endl;
  //assume user input is always valid
  for(int i=0;i<SIZE;i++){
   cout << "Array["<<i<<"]: ";
   cin >> A[i];
  }

  binCount(A,A_count,SIZE);

  cout << "Original array:";
  arrayPrint(A,SIZE);

  cout << "Bin count output:"<<endl;
  countPrint(A_count,MAX_RANGE+1);
  return 0;
}

void binCount(const int A[], int A_count[], int size){
  for(int i=0;i<size;i++)
    A_count[A[i]]= A_count[A[i]]+1;
}

void arrayPrint(const int array[],int size){
  for(int i=0;i<size;i++)
    cout<<array[i]<<'\t';
  cout<<endl;
}

void countPrint(const int array[],int size){
  for(int i=0;i<size;i++)
    if(array[i]>0)
      {cout<<"The count of "<<i<<" in A[] is:"<<'\t';
      cout<<array[i]<<endl;}
  cout<<endl;
}

