include("ex1.jl");

using MyModule
using Base.Test

EPSILON = 10.0^(-5)
DELTA = 10.0^(-5)

FUNC = x -> log(x)
FUNC_D = x -> 1/x
RES = 1.0
@test mbisekcji(FUNC, 0.5, 2.5, DELTA, EPSILON)[1] ≈ RES atol=EPSILON
@test mbisekcji(FUNC, 0.3, 100.0, DELTA, EPSILON)[1] ≈ RES atol=EPSILON
@test mbisekcji(FUNC, 0.7, 50.0, DELTA, EPSILON)[1] ≈ RES atol=EPSILON
@test mbisekcji(FUNC, 0.7, 100050.0, DELTA, EPSILON)[1] ≈ RES atol=EPSILON
@test mbisekcji(FUNC, 0.3, 1.5, DELTA, EPSILON)[1] ≈ RES atol=EPSILON

@test mbisekcji(FUNC, 200.0, 500.0, DELTA,EPSILON) == (0, 0, 0, 1)
@test mbisekcji(FUNC, 0.3, 0.7, DELTA,EPSILON) == (0, 0, 0, 1)

@test mstycznych(FUNC, FUNC_D, 0.5, DELTA, EPSILON, 1000)[1] ≈ RES atol=EPSILON 

@test mstycznych(FUNC, FUNC_D, 1.0, DELTA, EPSILON, 1000)[1] ≈ RES atol=EPSILON 

@test mstycznych(FUNC, FUNC_D, 1.5, DELTA, EPSILON, 1000)[1] ≈ RES atol=EPSILON 

@test msiecznych(FUNC, 0.5, 1.5, DELTA, EPSILON, 1000)[1] ≈ RES atol=EPSILON

@test msiecznych(FUNC, 0.5, 20.0, DELTA, EPSILON, 1000)[1] ≈ RES atol=EPSILON

@test msiecznych(FUNC, 0.8, 1.2, DELTA, EPSILON, 1000)[1] ≈ RES atol=EPSILON

FUNC = x -> 3x + 7

RES = (-7.0) / 3.0
@test mbisekcji(FUNC, -8.0, 8.0, DELTA, EPSILON)[1] ≈ RES atol=EPSILON
@test mbisekcji(FUNC, -100.0, 8.0, DELTA, EPSILON)[1] ≈ RES atol=EPSILON
@test mbisekcji(FUNC, -12300.0, 822.0, DELTA, EPSILON)[1] ≈ RES atol=EPSILON

@test mbisekcji(FUNC, 200.0, 500.0, DELTA,EPSILON) == (0, 0, 0, 1)
@test mbisekcji(FUNC, 0.3, 0.7, DELTA,EPSILON) == (0, 0, 0, 1)

@test msiecznych(FUNC, 0.5, 1.5, DELTA, EPSILON, 1000)[1] ≈ RES atol=EPSILON

@test msiecznych(FUNC, 0.5, 20.0, DELTA, EPSILON, 1000)[1] ≈ RES atol=EPSILON

@test msiecznych(FUNC, 0.8, 1.2, DELTA, EPSILON, 1000)[1] ≈ RES atol=EPSILON


FUNC = x -> x * exp(-x)
FUNC_D = x -> ((-1) * (e)^((-1) * x) * (x - 1)) 

@test mstycznych(FUNC, FUNC_D, 1.0, DELTA, EPSILON, 1000)[4] == 2

@test mstycznych(FUNC, FUNC_D, 5.0, DELTA, EPSILON, 1000)[4] == 0

@test mstycznych(FUNC, FUNC_D, 80.0, DELTA, EPSILON, 1000)[4] == 2

@test mstycznych(FUNC, FUNC_D, 30.0, DELTA, EPSILON, 1000)[4] == 2
