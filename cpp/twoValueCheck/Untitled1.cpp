#include <iostream>
using namespace std;
int userInput1, userInput2;

int main() {

    cout <<"provide two numbers: \n";
    cout <<"input 1 : ";
    cin >> userInput1;
    cout <<"input 2 : ";
    cin >> userInput2;

    if (userInput1 > userInput2) {
        cout <<"input one is greater than input two";
    } else if (userInput2 > userInput1) {
    cout <<"input two is greater than input one";
    } else {cout <<"the two inputs are equal";}

  return 0;
}
