include("./lib.jl")

using Base.Test
using blocksys

function testShouldReadMatrixFromFile()
  M, n, l = readMatrix("./../input/16/A.txt")
end

function testShouldReadVectorFromFile()
  V, n = readVector("./../input/16/b.txt")
end

function testShouldReadMatrixAndEvalVector()
  M, n, l = readMatrix("./../input/16/A.txt")
  x = sparse(ones(n))
  V = matrixTimesX(M, x, n, l)
  println(V)
end

function testGaussianEliminationWithoutPivoting()
  M, n, l = readMatrix("./../input/50000/A.txt")
  V, n = readVector("./../input/50000/b.txt")
  x = @time gaussianElimination(M, V, n, l)
end
function testGaussianEliminationWithPivot()
  M, n, l = readMatrix("./../input/A.txt")
  V, n = readVector("./../input/b.txt")
  X = gaussianEliminationWithPivot(M, V, n, l)
  # println(X)
end

function testLowerUpperFactorization()
  M, n, l = readMatrix("./../input/A.txt")
  L, U = lowerUpperFactorization(M, n, l)
end

function testResultOfLU()
  M = sparse([
    1.0 4.0 -3.0 ;
    -2.0 8.0 5.0 ;
    3.0 4.0 7.0 ;
  ])
  b = sparse([1.0 ; 2.0 ; 3.0])
  expectedResult = full(M) \ full(b) 

  n = 3
  l = 3

  (L, U), error = lowerUpperFactorization(M, n, l)
  result = solveFromLowerUpperMatrices(L, U, b, n, l)

  for i in 1:length(result)
    @test expectedResult[i] ≈ result[i]    
  end
end
# testShouldReadMatrixFromFile()
# testShouldReadVectorFromFile()
testGaussianEliminationWithoutPivoting()
# testGaussianEliminationWithPivot()
# testLowerUpperFactorization()
# testResultOfLU()
# testShouldReadMatrixAndEvalVector()