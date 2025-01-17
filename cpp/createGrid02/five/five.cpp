#include <iostream>
#include <vector>
using namespace std;

int main() {
	
	int rows = 5;
	int columns = 5;
	
	int gridX = 0;
	int gridY = 0;	

	vector<vector<int>> grid(rows, vector<int>(columns, 0));

	for (int x = 0; x < rows; x++) {
		gridY = 0;
		gridX = gridX + 1;
		for (int y = 0; y < rows; y++) {
			gridY = gridY + 1;
			grid[x][y] = gridX * 10 + gridY;
		}	
	}

for (int x = 0; x < rows; x++) {
	for (int y = 0; y < columns; y++) {
	cout<<grid[x][y] << " ";
	}
	cout<<endl;
}
return 0;

}
