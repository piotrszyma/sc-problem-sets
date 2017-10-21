# Program liczący ETA dla Float16, Float32, Float64
# Autor: Piotr Szyma

number = Float16(1.0)

while number / 2 > Float16(0.0)
     number /= 2
end

@printf "found Float16 eta:\t\t\t %.15e\n" number
@printf "nextfloat(Float16(0.0)) return value:\t %.15e\n" nextfloat(Float16(0.0))

number = Float32(1.0)

while number / 2 > Float32(0.0)
     number /= 2
end

@printf "found Float32 eta:\t\t\t %.15e\n" number
@printf "nextfloat(Float32(0.0)) return value:\t %.15e\n" nextfloat(Float32(0.0))

number = Float64(1.0)

while number / 2 > Float64(0.0)
     number /= 2
end

@printf "found Float64 eta:\t\t\t %.15e\n" number
@printf "nextfloat(Float64(0.0)) return value:\t %.15e\n" nextfloat(Float64(0.0))
