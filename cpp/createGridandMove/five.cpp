#include <iostream>
using namespace std;

int main() {

	const int gridX = 4;
	const int gridY = 4;

	struct {
		int xPos = 2;
		int yPos = 1;
	} player;

	string ar[gridX][gridY] = {
	"[a]","[b]","[c]","[d]",
	"[e]","[f]","[g]","[h]",
	"[i]","[j]","[k]","[l]",
	"[m]","[n]","[o]","[p]"
	};

	
	for (int i = 0; i < gridX; i++) {
		for (int j = 0; j < gridY; j++) {
			if (player.xPos == i && player.yPos == j) {
				cout << "[@]";
			} else {
			cout << ar[i][j];
			}
		}
		cout << "\n";	
	}	

}
