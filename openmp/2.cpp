#include <iostream>
#include <vector>
#include <random>
#include <omp.h>

using namespace std;

long scalar(vector<int> vec1, vector<int> vec2){
    long result = 0;
    size_t i;
    #pragma omp parallel for shared(vec1, vec2) private(i) reduction(+:result)
	for (i = 0; i < vec1.size(); ++i)
        	result += (vec1.at(i) * vec2.at(i));
    return result;
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
    size_t len;
    cin >> len;

    vector<int> vec1(randomVector(len));
    vector<int> vec2(randomVector(len));
    
    // for (auto i : vec1) {
    //     cout << i << " ";
    // }
    // cout << endl;
    // for (auto i : vec2) {
    //     cout << i << " ";
    // }
    // cout << endl;

    double start = omp_get_wtime();
    //
    long sc = scalar(vec1, vec2);
    double end = omp_get_wtime();
    cout << end - start << endl;
    // cout << sc << endl;

    return 0;
}