# Program sprawdzający wyniki obliczeń rekurencji po 40 iteracji dla różnych zestawów danych
# autor Piotr Szyma

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
push!(o, evaluate(2, -2, 40))
push!(o, evaluate(1.99999999999999, -2, 40))
push!(o, evaluate(1, -1, 40))
push!(o, evaluate(-1, -1, 40))
push!(o, evaluate(0.75, -1, 40))
push!(o, evaluate(0.25, -1, 40))

println("\$\$")
println("\\begin{array}{c|c|c|c|c}")
println("\^{algorytm}/_{iteracja} & 1 & 2 & 4 & 5\\\\")
println("\\hline")

for i in 1:40
  if i == 1 || i == 2 || i == 3 || i == 4 || i % 5 == 0
    @printf "%d & %.9f & %.9f & %.9f & %.9f \\\\\n" i o[1][i] o[2][i] o[4][i] o[5][i]
  end
end

println("\\end{array}")
println("\$\$")

println("\$\$")
println("\\begin{array}{c|c|c|c}")
println("\^{algorytm}/_{iteracja} & 3 & 6 & 7\\\\")
println("\\hline")

for i in 1:40
  if i == 1 || i == 2 || i == 3 || i == 4 || i % 5 == 0
    @printf "%d & %.10f & %.10f & %.10f \\\\\n" i o[3][i] o[6][i] o[7][i]
  end
end

println("\\end{array}")
println("\$\$")