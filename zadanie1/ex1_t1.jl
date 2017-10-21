# Program liczący epsilon maszynowe dla arytmetyk Float16, Float32 oraz Float64
# Autor: Piotr Szyma

number = Float16(1)

while Float16(1.0) + number/2 > Float16(1.0)
     number /= 2
end

@printf "found Float16 epsilon:\t\t %.15e\n" number
@printf "eps(Float16) return value:\t %.15e\n" eps(Float16)

number = Float32(1)

while Float32(1.0) + number/2 > Float32(1.0)
     number /= 2
end

@printf "found Float32 epsilon:\t\t %.15e\n" number
@printf "eps(Float32) return value:\t %.15e\n" eps(Float32)

number = Float64(1)

while Float64(1.0) + number/2 > Float64(1.0)
     number /= 2
end

@printf "found Float64 epsilon:\t\t %.15e\n" number
@printf "eps(Float64) return value:\t %.15e\n" eps(Float64)
