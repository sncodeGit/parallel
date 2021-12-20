#include <iostream>
#include <vector>
#include <random>
#include <omp.h>
#include <fstream>

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
    size_t len, count;
    cin >> len >> count;
    vector<vector<int>> vectors;

    ofstream fout("arrays.txt", ios::out);

    for (size_t i=0; i < count; i++){
        for (auto j : randomVector(len)) {
                fout << j << " ";
        }
        fout << endl;
        for (auto j : randomVector(len)) {
                fout << j << " ";
        }
        fout << endl;
    }

    fout.close();
    ifstream fin("arrays.txt", ios::in);

    double start = omp_get_wtime();
    //

    long long k = 0;
    #pragma omp parallel sections
    {
        #pragma omp section
        {
            int val;
            omp_lock_t lock;
            omp_init_lock(&lock);
            for(size_t i=0; i<count*2; i++){
                vector<int> vec;
                for(size_t j=0; j<len; j++){
                    fin >> val;
                    vec.push_back(val);
                }
                omp_set_lock(&lock);
                vectors.push_back(vec);
                k = k + 1;
                omp_unset_lock(&lock);
            }
        }
        #pragma omp section
        {
            vector<int> vec1(0);
            vector<int> vec2(0);
            int sc;
            long long m = 0;
            omp_lock_t lock_;
            omp_init_lock(&lock_);
            while (!((k == count*2) && (m == count * 2))){
                if (k - m > 1){
                    omp_set_lock(&lock_);
                    if (k - m > 1){
                        vec1 = vectors[m];
                        vec2 = vectors[m+1];
                        // for (auto i : vec1) {
                        //     cout << i << " ";
                        // }
                        // cout << " | ";
                        // for (auto i : vec2) {
                        //     cout << i << " ";
                        // }
                        // cout << endl;
                        m += 2;
                    }
                    omp_unset_lock(&lock_);
                    if ((vec1.size() != 0) && (vec2.size() != 0)){
                        sc = scalar(vec1, vec2);
                    }
                }
            }
        }
    }

    double end = omp_get_wtime();
    cout << end - start << endl;
    // cout << sc << endl;

    fin.close();

    return 0;
}

