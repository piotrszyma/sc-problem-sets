# Program do zadania nr 5
# generowanie wykresów funkcji anonimowych a i b
# autor Piotr Szyma


include("./../task-1/ex1.jl");
using MyModule


a = (x) -> exp(1) ^ x
b = (x) -> (x^2) * sin(x)

for n in 5:5:15
  rysujNnfx(a, 0.0, 1.0, n)
end

for n in 5:5:15
  rysujNnfx(b, -1.0, 1.0, n)
end