include("./../task-1/ex1.jl");
using MyModule

f1 = x -> exp(1 - x) - 1
f1p = x -> (-1) * e^(1 - x)

f2 = x -> x * exp(-x)
f2p = x -> ((-1) * (e)^((-1) * x) * (x - 1)) 

delta = 10.0^(-5)
epsilon = 10.0^(-5)

# f1
# bisekcja
# stycznych
# siecznych

bisection = mbisekcji(f1, 0.0, 2.0, delta, epsilon)

netwon = mstycznych(f1, f1p, -1.0, delta, epsilon, 1000)

secant = msiecznych(f1, 0.0, 2.0, delta, epsilon, 1000)

println("f1")
println(bisection)
println(netwon)
println(secant)

# f2
# bisekcja
# stycznych
# siecznych

bisection = mbisekcji(f2, -1.0, 1.0, delta, epsilon)

netwon = mstycznych(f2, f2p, -0.5, delta, epsilon, 1000)

secant = msiecznych(f2, -1.0, 1.0, delta, epsilon, 1000)

println("f2")
println(bisection)
println(netwon)
println(secant)

# netwon = mstycznych(f1, f1p, 1000.0, delta, epsilon, 1000)
# println("f1 newton x0 === 1000")
# println(netwon)
# netwon = mstycznych(f2, f2p, 1.0, delta, epsilon, 1000)
# println("f2 newton x0 === 1")
# println(netwon)
# x = linspace(0, 3, 200)

