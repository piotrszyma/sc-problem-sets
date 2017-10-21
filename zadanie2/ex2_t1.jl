# Program porównujący "wzór Kahana" z rzeczywistą wartością epsilon maszynowego
# autor Piotr Szyma

eps_f16 = Float16(3.0) * (Float16(4.0) / Float16(3.0) - Float16(1.0)) - Float16(1.0)

@printf "kahan's Float16 eps:\t\t %.15e\n" eps_f16
@printf "eps(Float16) return value:\t %.15e\n" eps(Float16)

eps_f32 = Float32(3.0) * (Float32(4.0) / Float32(3.0) - Float32(1.0)) - Float32(1.0)

@printf "kahan's Float32 eps:\t\t %.15e\n" eps_f32
@printf "eps(Float32) return value:\t %.15e\n" eps(Float32)

eps_f64 = Float64(3.0) * (Float64(4.0) / Float64(3.0) - Float64(1.0)) - Float64(1.0)

@printf "kahan's Float64 eps:\t\t %.15e\n" eps_f64
@printf "eps(Float64) return value:\t %.15e\n" eps(Float64)
