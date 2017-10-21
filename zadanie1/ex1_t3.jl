# Program liczący epsilon maszynowe dla Float16, Float32 oraz Float64
# Autor: Piotr Szyma

f16_eps = Float16(1)

while Float16(1.0) + f16_eps/2 > Float16(1.0)
     f16_eps /= 2
end

f32_eps = Float32(1)

while Float32(1.0) + f32_eps/2 > Float32(1.0)
     f32_eps /= 2
end

f64_eps = Float64(1)

while Float64(1.0) + f64_eps/2 > Float64(1.0)
     f64_eps /= 2
end

# Task

number = Float16(1.0)

while !isinf(number * 2)
    number *= 2
end

number = number * (2 - f16_eps)

@printf "found Float16 max:\t\t\t %.15e\n" number
@printf "realmax(Float16(0.0)) return value:\t %.15e\n" realmax(Float16(0.0))


number = Float32(1.0)

while !isinf(number * 2)
    number *= 2
end

number = number * (2 - f32_eps)

@printf "found Float32 max:\t\t\t %.15e\n" number
@printf "realmax(Float32(0.0)) return value:\t %.15e\n" realmax(Float32(0.0))

number = Float64(1.0)

while !isinf(number * 2)
    number *= 2
end

 number = number * (2 - f64_eps)

@printf "found Float64 max:\t\t\t %.15e\n" number
@printf "realmax(Float64(0.0)) return value:\t %.15e\n" realmax(Float64(0.0))
