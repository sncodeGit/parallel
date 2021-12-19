#include <iostream>
#include <vector>
#include <cmath>
#include <omp.h>

double f(double x){
    return 2*x*cos(x);
}

double integral_critical(double a, double b, size_t N){
    double res = 0.0;
    double h = (b-a)/N;
	#pragma omp parallel for shared(a, h, res)
	for(size_t i = 0; i < N; i++){
        #pragma omp critical
	    res += f(a + i*h)*h;
    }
    return res;
}

double integral_reduction(double a, double b, size_t N){
    double res = 0.0;
    double h = (b-a)/N;
	#pragma omp parallel for shared(a, h) reduction(+:res)
	for(size_t i = 0; i < N; i++){
	    res += f(a + i*h)*h;
    }
    return res;
}

double integral_lock(double a, double b, size_t N){
    double res = 0.0;
    double h = (b-a)/N;
    omp_lock_t lock;
    omp_init_lock(&lock);
	#pragma omp parallel for shared(a, h, res)
	for(size_t i = 0; i < N; i++){
        omp_set_lock(&lock);
	    res += f(a + i*h)*h;
        omp_unset_lock(&lock);
    }
    return res;
}

double integral_atomic(double a, double b, size_t N){
    double res = 0.0;
    double h = (b-a)/N;
	#pragma omp parallel for shared(a, h, res)
	for(size_t i = 0; i < N; i++){
        #pragma omp atomic
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
    double res = integral_critical(a, b, N);
    double end = omp_get_wtime();
    cout << end - start << endl;
    // cout << res << endl;

    start = omp_get_wtime();
    //
    res = integral_reduction(a, b, N);
    end = omp_get_wtime();
    cout << end - start << endl;

    start = omp_get_wtime();
    //
    res = integral_lock(a, b, N);
    end = omp_get_wtime();
    cout << end - start << endl;

    start = omp_get_wtime();
    //
    res = integral_atomic(a, b, N);
    end = omp_get_wtime();
    cout << end - start << endl;

    return 0;
}
