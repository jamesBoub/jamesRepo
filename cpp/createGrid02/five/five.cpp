#include <iostream>
#include <vector>

using namespace std;

int main() {

vector<vector<int>> grid = {};
vector<int> cell = {1,2};

int xOff = 0;
int yOff = 0;

int x = 8;
int y = 8;


for (int i = 0; i < x; i++) {
	yOff += 1;
	xOff = 1;
	for (int j = 0; j < y; j++) {
	vector<int> cell = {xOff,yOff};
	grid.push_back(cell);
	xOff += 1;
	}
}

for (unsigned int i = 0; i < grid.size(); i++) {
	//cout<<"\n";
	if ((i % x != 0) || (i % y != 0)) {
	//cout<<i;
	cout<<" ["<<grid[i][0]<<" "<<grid[i][1]<<"] ";
	} else {
	cout<<"\n";
	cout<<" ["<<grid[i][0]<<" "<<grid[i][1]<<"] ";
	}
}
}
