using Polynomials

coefficients=[1, -210.0, 20615.0,-1256850.0,
      53327946.0,-1672280820.0, 40171771630.0, -756111184500.0,          
      11310276995381.0, -135585182899530.0,
      1307535010540395.0,     -10142299865511450.0,
      63030812099294896.0,     -311333643161390640.0,
      1206647803780373360.0,     -3599979517947607200.0,
      8037811822645051776.0,      -12870931245150988800.0,
      13803759753640704000.0,      -8752948036761600000.0,
      2432902008176640000.0]

P_x = Poly(reverse(coefficients))
p_x = poly([i for i in 1.0:20.0])

rootsOfP_x = reverse(roots(P_x))

println("Wyniki (a)")
println("\$\$")
println("\\begin{array}{c|c|c|c}")
println("k & |P(z_k)| & |p(z_k)| & |z_k - k|\\\\")
println("\\hline")
for i in 1:20
  print(i)
  print(" & ")
  print(abs(polyval(P_x, rootsOfP_x[i])))
  print(" & ")
  print(abs(polyval(p_x, rootsOfP_x[i])))
  print(" & ")
  print(abs(i - rootsOfP_x[i]))
  print("\\\\\n")
end
println("\\end{array}")
println("\$\$")


coefficientsModified = [
  1,
  -210 - 2.0^(-23),
  20615,
  -1256850,
  53327946,
  -1672280820,
  40171771630,
  -756111184500,
  11310276995381,
  -135585182899530,
  1307535010540395,
  -10142299865511450,
  63030812099294900,
  -311333643161390660,
  1206647803780373200,
  -3599979517947607000,
  8037811822645051000,
  -12870931245150988000,
  13803759753640704000,
  -8752948036761600000,
  2432902008176640000
]

P_x = Poly(reverse(coefficientsModified))
rootsOfP_x = reverse(roots(P_x))

println("Wyniki (b)")
println("\$\$")
println("\\begin{array}{c|c|c}")
println("k & |P(z_k)| & |z_k - k|\\\\")
println("\\hline")
for i in 1:20
  print(i)
  print(" & ")
  print(abs(polyval(P_x, rootsOfP_x[i])))
  print(" & ")
  print(abs(i - rootsOfP_x[i]))
  print("\\\\\n")
end
println("\\end{array}")
println("\$\$")