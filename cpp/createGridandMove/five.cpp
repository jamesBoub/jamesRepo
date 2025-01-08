#include <iostream>
using namespace std;

	struct Player {
		int xPos;
		int yPos;
	};

void gridPrint(int gridX, int gridY, Player player, string ar[4][4]) {
	for (int i = 0; i < gridX; i++) {
		for (int j = 0; j < gridY; j++) {
			if (player.yPos == i && player.xPos == j) {
				cout << "[@]";
			} else {
			cout << ar[i][j];
			}
		}
		cout << "\n";	
	}	

}

int main() {

	bool active = true;
	char decision;
	const int gridX = 4;
	const int gridY = 4;

	Player player = {2, 1};
	player = {0,0};

	string ar[gridX][gridY] = {
	"[a]","[b]","[c]","[d]",
	"[e]","[f]","[g]","[h]",
	"[i]","[j]","[k]","[l]",
	"[m]","[n]","[o]","[p]\n"
	};

	gridPrint(gridX, gridY, player, ar);


	do {

		cout << "what do you want to do? \n";
	cout << "w: north \n" << "a: west \n" << "s: south \n" << "d: east \n" << "q: quit \n";
	cin >> decision;

	switch (decision) {
	case 'q':
		active = false;
		break;
	case 'w':
		if (player.yPos > 0) {
		player.yPos -= 1;
		}
		break;
	case 'a':
		if (player.xPos > 0) {
		player.xPos -= 1;
		}
	      	break;
	case 's':
		if (player.yPos < 3) {
		player.yPos += 1;
		}
		break;
	case 'd':
		if (player.xPos < 3) {
		player.xPos += 1;
		}
		break;
	default:
		cout << "please enter a valid response. \n";
		break;
	}

	gridPrint(gridX, gridY, player, ar);

	} while (active == true);
	return 0;
}
