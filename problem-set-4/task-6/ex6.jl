include("./../task-1/ex1.jl");
using MyModule

a = (x) -> abs(x)
b = (x) -> 1 / (1 + x ^ 2)

for n in 5:5:15
  rysujNnfx(a, -1.0, 1.0, n)
end

for n in 5:5:15
  rysujNnfx(b, -5.0, 5.0, n)
end