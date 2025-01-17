#include <iostream>
#include <vector>
using namespace std;

int main() {

	struct Pos {
		int x;
		int y;
	};
	
	int rows = 5;
	int columns = 5;
	
	int gridX = 0;
	int gridY = 0;	

	vector<vector<Pos>> grid(rows, vector<Pos>(columns));

	for (int x = 0; x < rows; x++) {
		gridY = 0;
		gridX = gridX + 1;
		for (int y = 0; y < rows; y++) {
			gridY = gridY + 1;
			grid[x][y].x = gridX;
			grid[x][y].y = gridY;
		}	
	}

for (int x = 0; x < rows; x++) {
	for (int y = 0; y < columns; y++) {
	cout<<"[ "<<grid[x][y].y<<" "<<grid[x][y].x<<" ]";	
	}
	cout<<endl;
}
return 0;

}
