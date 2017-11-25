include("./../task-1/ex1.jl");
using MyModule

f2 = x -> x * e^(-x)
f2p = x -> ((-1) * (e)^((-1) * x) * (x - 1)) 

delta = 10.0^(-5)
epsilon = 10.0^(-5)


# netwon = mstycznych(f2, f2p, -20.0, delta, epsilon, 1000)

for x in -2.5:0.1:2.5
  print(mstycznych(f2, f2p, x, delta, epsilon, 100))
  @printf "%f %f\n" mstycznych(f2, f2p, x, delta, epsilon, 1000)[1] x
end