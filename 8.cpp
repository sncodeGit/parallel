#include <iostream>
#include <omp.h>


using namespace std;

void test(char c, int n){
    int buf;
    if (c == 's'){
        #pragma omp parallel for schedule(static)
        for (int i = 0; i < n; i++){
            if (i % 4 == 0){
                buf = rand() % 100000 + rand() % 10000 + rand() % 1000 + rand() % 100 + rand() % 10 + 1;
                }
            else
                buf = rand() % 1000;
            }
    }
    else if(c == 'g'){
        #pragma omp parallel for schedule(guided)
        for (int i = 0; i < n; i++){
            if (i % 4 == 0){
                buf = rand() % 100000 + rand() % 10000 + rand() % 1000 + rand() % 100 + rand() % 10 + 1;
                }
            else
                buf = rand() % 1000;
            }
    }
    else if (c == 'd'){
        #pragma omp parallel for schedule(dynamic)
        for (int i = 0; i < n; i++){
            if (i % 4 == 0){
                buf = rand() % 100000 + rand() % 10000 + rand() % 1000 + rand() % 100 + rand() % 10 + 1;
            }
            else
                buf = rand() % 1000;
        }
    }
}


int main(){
    srand(time(0));

    size_t n;
    cin >> n;

    double start = omp_get_wtime();
    //
    test('s', n);
    double end = omp_get_wtime();
    cout << end - start << endl;

    start = omp_get_wtime();
    //
    test('g', n);
    end = omp_get_wtime();
    cout << end - start << endl;

    start = omp_get_wtime();
    //
    test('d', n);
    end = omp_get_wtime();
    cout << end - start << endl;

    return 0;
}
