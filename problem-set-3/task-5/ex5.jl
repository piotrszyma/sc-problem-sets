include("./../task-1/ex1.jl");
using MyModule

f = x -> 3 * x - e^x

bisection1 = mbisekcji(f, 0.0, 1.0, 10.0^(-4),10.0^(-4))

bisection2 = mbisekcji(f, 1.0, 2.0, 10.0^(-4),10.0^(-4))

println(bisection1)
println(bisection2)