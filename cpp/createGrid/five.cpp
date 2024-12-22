#include <iostream>
using namespace std;

int main() {
	string ar[4][4] = {
	"[a]","[b]","[c]","[d]",
	"[e]","[f]","[g]","[h]",
	"[i]","[j]","[k]","[l]",
	"[m]","[n]","[o]","[p]"
	};
	
	for (int i = 0; i < 4; i++) {
		for (int j = 0; j < 4; j++) {
			cout << ar[i][j];
		}
		cout << "\n";	
	}	

}
