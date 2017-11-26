include("./../task-1/ex1.jl");
using MyModule

f1 = x -> exp(1 - x) - 1
f1p = x -> (-1) * e^(1 - x)

f2 = x -> x * e^(-x)
f2p = x -> ((-1) * (e)^((-1) * x) * (x - 1)) 

delta = 10.0^(-5)
epsilon = 10.0^(-5)


println("F1")


for i = 1.2:0.2:30
  print(i);
  print("\t");
  println(mstycznych(f1, f1p, i, delta, epsilon, 1000));
end

println("F2")

for i = 0.0:0.2:30
  print(i);
  print("\t");
  println(mstycznych(f2, f2p, i, delta, epsilon, 1000));
end


println("F2 x0 = 1.0")
println(mstycznych(f2, f2p, 1.0, delta, epsilon, 1000));
