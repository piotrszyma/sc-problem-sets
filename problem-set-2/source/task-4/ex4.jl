using Polynomials

coefficients = [
  1,
  -210,
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

polyFromCoefficients = Poly(coefficients)
rootsOfPolyFromCoefficients = roots(polyFromCoefficients)

polyFromRoots = poly([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20])
println("Wyniki")
println("\$\$")
println("\\begin{array}{c|c|c|c|c}")
println("k & |P(z_k)| & |p(z_k)| & |z_k - k|\\\\")
println("\\hline")
for (index, root) = enumerate(rootsOfPolyFromCoefficients)
  print(index)
  print(" & ")
  print(abs(polyval(polyFromCoefficients, root)))
  print(" & ")
  print(abs(polyval(polyFromRoots, root)))
  print(" & ")
  print(abs(index - root))
  print("\\\\\n")
end
println("\\end{array}")
println("\$\$")
