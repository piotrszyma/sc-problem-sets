# znajdywanie najmniejszej nierozróżnialnej od 0 liczby w arytmetyce Float64
# autor: Piotr Szyma

f64_eps = Float64(1)

while Float64(1.0) + f64_eps/2 > Float64(1.0)
     f64_eps /= 2
end

x = Float64(1.0)

while (x * (Float64(1.0) / x)) == Float64(1.0)
    x += f64_eps
end

@printf "%s\n" bits(x)

@printf "%.15f\n\n" x
