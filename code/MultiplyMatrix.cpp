#include<iostream>
#include<ctime>
using namespace std;

void matrixMultiply(int a[], int b[], int c[], int n, int col);
void print(int a[], int row, int col);

int main() {
    int n = 4;
    int col = 2, row = 2; // col/row in the matrix
    int originalMatrixA[4];
    int originalMatrixB[4];
    int outputMatrix[4];

    //assume user input is always valid
    for(int i=0;i<n;i++){
    cout << "MatrixA["<<i<<"]: ";
    cin >> originalMatrixA[i];
    }

    for(int i=0;i<n;i++){
    cout << "MatrixB["<<i<<"]: ";
    cin >> originalMatrixB[i];
    }

    cout << "The original matrix A is\n";
    print(originalMatrixA, row, col);

    cout << "The original matrix B is\n";
    print(originalMatrixB, row, col);

    matrixMultiply(originalMatrixA, originalMatrixB, outputMatrix, n, col);
    cout << "The multiplied output matrix is\n";
    print(outputMatrix, col, row);

    return 0;

}

void matrixMultiply(int a[], int b[], int c[], int n, int col) {
// use the multiply function in MIPS to replace the * operator below
    c[0] = a[0]*b[0] + a[1]*b[2]; 
    c[1] = a[0]*b[1] + a[1]*b[3]; 
    c[2] = a[2]*b[0] + a[3]*b[2]; 
    c[3] = a[2]*b[1] + a[3]*b[3]; 
}

void print(int a[], int row, int col) {
    for (int i = 0; i < row; i++) {
        for(int j = 0; j < col; j++)
            cout << a[i*col + j] << " ";
        cout << endl;
    }
    cout << endl;
}

