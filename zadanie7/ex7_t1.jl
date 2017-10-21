# Obliczanie pochodnej funkcji
# Porównanie arytmetyk Float32 oraz Float64
# autor Piotr Szyma

function derivative(f, x, h)
    return (f(x + h) - f(x)) / h
end

function f(x)
    return sin(x) + cos(3 * x)
end


n = 1
val = Float64(0.116942281)

while n < 55
    der = derivative(f, 1, 2.0 ^ ((-1) * n))
    @printf "%2d.\t%15e\t%15e\n" n der abs(der - val)
    n+=1
end

print("\n")

n = 1

while n < 55
    der = derivative(f, 1, 2.0 ^ ((1 - ((-1) * n))))
    @printf "%2d.\t%15e\t%15e\n" n der abs(der - val)
    n+=1
end
