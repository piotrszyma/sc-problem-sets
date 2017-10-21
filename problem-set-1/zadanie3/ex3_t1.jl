# Program sprawdzający odległość między kolejnymi różnymi liczbami w różnych przedziałach
# Arytmetyka Float64
# Autor Piotr Szyma

function show_result(n, d)
    k = 0
    @printf "init:\n%s\nnextfloat:\n%s\n" bits(n) bits(nextfloat(n))
    @printf "loop:\n%s\n" bits(n)
    n += d
    while  k < 5
        @printf "%s\n" bits(n)
        n += d
        k+= 1
    end
end

delta = Float64(2.0 ^ (-52))

@printf "For [1, 2]; delta = 2 ^ (-52)\n"

number = Float64(1.0)

show_result(number, delta)

@printf "For [0.5, 1] delta = 2 ^ (-53)\n"

delta = Float64(2.0 ^ (-53))
number = Float64(0.5)

show_result(number, delta)


@printf "For [2, 4] delta = 2 ^ (-51)\n"
delta = Float64(2.0 ^ (-51))
number = Float64(2.0)

show_result(number, delta)
