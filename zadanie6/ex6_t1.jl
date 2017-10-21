# Porównanie różnych algorytmów liczących wartości tej samej - w matematycznym sensie - funkcji
# autor Piotr Szyma

function f(x)
    return sqrt(Float64(x) ^ 2.0 + 1.0) - 1.0
end

function g(x)
    return (Float64(x) ^ 2.0) / (sqrt(Float64(x) ^ 2.0 + 1.0) + 1.0)
end


i = 1

while i < 15
    @printf "%15e\n" f(8.0 ^ ((-1) * i))
    i+=1
end

print("\n\n")

i = 1

while i < 15
    @printf "%15e\n" g(8.0 ^ ((-1) * i))
    i+=1
end
