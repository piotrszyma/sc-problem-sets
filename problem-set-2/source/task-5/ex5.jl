# Program liczący rekurencję z zadania 5
# autor Piotr Szyma

function evaluate(p_val, r_factor, iter_number, T)
    results = T[]
    p::T = p_val
    r_factor::T = r_factor
    i = 1
    while i <= iter_number
      p = p + r_factor * p * (1 - p)
      push!(results, p)
      i+=1
    end
    
    return results
end

function evaluateWithTrunc(p_val, r_factor, iter_number, T)
  results = T[]
  p::T = p_val
  r_factor::T = r_factor
  i = 1
  while i <= iter_number

    p = p + r_factor * p * (1 - p)
    if i == 10
      @printf "\n\n\n%.15f\n\n\n" p
    end
    push!(results, p)
    

    i+=1
  end
  return results
end


f32 = evaluate(0.01, 3, 40, Float32)
f32_tr = evaluateWithTrunc(0.01, 3, 40, Float32)
f64 = evaluate(0.01, 3, 40, Float64)
f64_tr = evaluateWithTrunc(0.01, 3, 40, Float64)

println("Wyniki (a)")
println("\$\$")
println("\\begin{array}{c|c|c}")
println("n & (1) & (2)\\\\")
println("\\hline")

for i in 1:40
  if i == 1 || i == 2 || i == 3 || i == 4 || i % 5 == 0
    @printf "%d & %.15f & %.15f\\\\\n" i f32[i] f32_tr[i]
  end
end

println("\\end{array}")
println("\$\$")

println("Wyniki (b)")
println("\$\$")
println("\\begin{array}{c|c|c}")
println("n & Float32 & Float64\\\\")
println("\\hline")

for i in 1:40
  if i == 1 || i == 2 || i == 3 || i == 4 || i % 5 == 0
    @printf "%d & %.15f & %.15f\\\\\n" i f32[i] f64[i]
  end
end

println("\\end{array}")
println("\$\$")