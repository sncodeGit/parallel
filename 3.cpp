#include <iostream>
#include <vector>
#include <cmath>
#include <omp.h>

double f(double x){
    return 2*x*cos(x);
}

// double integral(double a, double b, size_t N){
//     double res = 0.0;
//     double h = (b-a)/N;
//     double sums[omp_get_max_threads()];
//     for(size_t i = 0; i < omp_get_max_threads(); i++){
//         sums[i] = 0.0;
//     }
// 	#pragma omp parallel for shared(a, h, sums)
// 	for(size_t i = 0; i < N; i++){
// 	    sums[omp_get_thread_num()] += f(a + i*h)*h;
//     }
//     for(size_t i = 0; i < omp_get_max_threads(); i++){
//         res += sums[i];
//     }
//     return res;
// }

double integral(double a, double b, size_t N){
    double res = 0.0;
    double h = (b-a)/N;
	#pragma omp parallel for shared(a, h) reduction(+:res)
	for(size_t i = 0; i < N; i++){
	    res += f(a + i*h)*h;
    }
    return res;
}

using namespace std;

int main(){
    double a, b;
    size_t N;
    cin >> a >> b >> N;
    
    double start = omp_get_wtime();
    //
    double res = integral(a, b, N);
    double end = omp_get_wtime();
    cout << end - start << endl;
    // cout << res << endl;

    return 0;
}