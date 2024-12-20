#include <iostream>
#include <vector>
using namespace std;

// this makes an array filled by the user, outputting a random item


int main() {
	
string name;
char type;
char type2;
vector<string> nameList;

	do {	

		do {
			cout << "Enter a name\n";
			cin >> name;
			cout << "You entered " << name << ", are you satisfied? y/n \n";
			cin >> type;

		if (type != 'y' && type != 'n') {
			cin.clear();
			cin.ignore();
			cout << "Invalid\n";
		}

		} while (type != 'y');

		nameList.push_back(name);
		cout << "Add another name? y/n ";
		cin >> type2;

	} while (type2 != 'n');
	
	int vectorSize = nameList.size();	

	for (int i = 0; i < vectorSize; i++) {
		cout << nameList.at(i) << "\n";}
		
	return 0;
	

}
