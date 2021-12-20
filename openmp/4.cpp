#include <iostream>
#include <vector>
#include <random>
#include <omp.h>

using namespace std;

int get_min(vector<int> line, int m)
{
    omp_set_nested(false);
    int mn = line.at(0);
    #pragma parallel for reduction(min:mn)
    for (size_t i = 0; i < m; i++){
        if (line.at(i) < mn)
            mn = line.at(i);
    }
    return mn;
}


int get_max(vector<vector<int>> matrix, int n, int m){
    int mx;
    vector<int> min_of_lines(n);
    for (size_t i; i<n; i++){
        min_of_lines.at(i) = 1001;
    }
    #pragma omp parallel for shared(m)
    for (size_t i = 0; i < n; i++)
        min_of_lines.at(i) = get_min(matrix.at(i), m);
    mx = min_of_lines.at(0);
    #pragma omp parallel for shared(n) reduction(max:mx)
    for (size_t i = 1; i < n; i++)
        if (min_of_lines.at(i) > mx)
            mx = min_of_lines.at(i);
    return mx;
}

vector<int> randomVector(size_t size)
{
    vector<int> v(size);
    for (size_t i = 0; i < size; i++){
        int b = rand() % 2000 + 1 - 1000;
        v.at(i) = b;
    }
    return v;
}

int main(){
    srand(1);
    size_t n, m;
    cin >> n >> m;

    vector<vector<int>> matrix;
    for (size_t i=0; i<n; i++){
        matrix.push_back(randomVector(m));
    }

    // for (auto i : matrix) {
    //     for (auto j : i) {
    //         cout << j << " ";
    //     }
    //     cout << endl;
    // }
    // cout << endl;

    double start = omp_get_wtime();
    //
    int mx = get_max(matrix, n, m);
    double end = omp_get_wtime();
    cout << end - start << endl;
    // cout << mx << endl;

    return 0;
}