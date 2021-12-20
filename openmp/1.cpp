#include <iostream>
#include <vector>
#include <random>
#include <omp.h>

using namespace std;

// int get_max(vector<int> vec){
//     int mx = vec.at(0);
//     size_t i;
//     #pragma omp parallel for shared(vec) private(i) reduction(max:mx)
//     for(size_t i=0; i < vec.size(); i++)
//         mx = max(mx, vec.at(i));
//     return mx;
// }

int get_max(vector<int> vec){
    int mx = vec.at(0);
    size_t i;
    #pragma omp parallel for private(i) shared(mx, vec)
    for(i=0; i < vec.size(); i++){
        if (vec.at(i) > mx){
            #pragma omp critical
            if (vec.at(i) > mx){
                mx = vec.at(i);
            }
        }
    }
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
    size_t len;
    cin >> len;

    vector<int> vec(randomVector(len));
    
    // for (auto i : vec) {
    //     cout << i << " ";
    // }
    // cout << endl;

    double start = omp_get_wtime();
    //
    int mx = get_max(vec);
    double end = omp_get_wtime();
    cout << end - start << endl;
    // cout << mx << endl;

    return 0;
}