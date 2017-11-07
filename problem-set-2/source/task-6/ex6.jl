function evaluate(p_val, c_factor, iter_number)
  results = Float64[]
  p::Float64 = p_val
  c_factor::Float64 = c_factor
  i = 1
  while i <= iter_number
    p = p^2 + c_factor
    i += 1
    push!(results, p)
  end
  
  return results
end
o = Array[]
push!(o, evaluate(1, -2, 40))
push!(o, evaluate(1.99999999999999, -2, 40))
push!(o, evaluate(1, -2, 40))
push!(o, evaluate(1, -1, 40))
push!(o, evaluate(-1, -1, 40))
push!(o, evaluate(0.75, -1, 40))
push!(o, evaluate(0.25, -1, 40))

println(o)



# println("Wyniki (a)")
# println("\$\$")
# println("\\begin{array}{c|c|c}")
# println("n & (1) & (2)\\\\")
# println("\\hline")

# for i in 1:40
#   if i == 1 || i == 2 || i == 3 || i == 4 || i % 5 == 0
#     @printf "%d & %.15f & %.15f\\\\\n" i f32[i] f32_tr[i]
#   end
# end

# println("\\end{array}")
# println("\$\$")

# println("Wyniki (b)")
# println("\$\$")
# println("\\begin{array}{c|c|c}")
# println("n & Float32 & Float64\\\\")
# println("\\hline")

# for i in 1:40
#   if i == 1 || i == 2 || i == 3 || i == 4 || i % 5 == 0
#     @printf "%d & %.15f & %.15f\\\\\n" i f32[i] f64[i]
#   end
# end

# println("\\end{array}")
# println("\$\$")