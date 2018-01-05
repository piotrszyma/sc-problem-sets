include("./solutions.jl")
include("./monia.jl")

using Base.Test
using blocksys
using MyModule

function testShouldReadMatrixFromFile()
  M, n, l = readMatrix("./../input/A.txt")
  println(M)
end

function testShouldReadVectorFromFile()
  V, n = readVector("./../input/b.txt")
  println(V)  
end


function test1()
  A, n, l = loadMatrix()
  b = loadVector()
  x = ones(n)
  A1, b1, err = Gauss(A, b, true, l, n)
  x1 = ObliczGaussa(A1, b1, n, l)
  println(x1)
  err1 = 0.0
  err1+=norm(x1 -x)/norm(x)
  println(err1)
  A1, b1, err = Gauss(A, b, false, l, n)
  x2 = ObliczGaussa(A1, b1, n, l)
  err2 = 0.0
  err2+=norm(x2 -x)/norm(x)
  println(err2)
  writeX(x1, x2, n)
  println("Done")
end

function testGaussianEliminationWithoutPivoting()
  M, n, l = readMatrix("./../input/A.txt")
  V, n = readVector("./../input/b.txt")
  X = gaussianElimination(M, V, n, l)
  println(X)
end
function testGaussianEliminationWithPivot()
  M, n, l = readMatrix("./../input/A.txt")
  V, n = readVector("./../input/b.txt")
  X = gaussianEliminationWithPivot(M, V, n, l)
  println(X)
end
# testShouldReadMatrixFromFile()
# testShouldReadVectorFromFile()
# testGaussianEliminationWithoutPivoting()
testGaussianEliminationWithPivot()