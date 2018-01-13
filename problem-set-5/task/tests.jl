include("./lib.jl")

using Base.Test
using blocksys
function testShouldReadMatrixAndEvalVector()
  M, n, l = readMatrix("./../input/16/A.txt")
  x = sparse(ones(n))
  result = matrixTimesX(M, x, n, l)

  expected, n = readVector("./../input/16/b.txt")
  
  for i in 1:length(expected)
    @test expected[i] ≈ result[i]    
  end
end
function testGaussianEliminationWithoutPivoting()
  M, n, l = readMatrix("./../input/16/A.txt")
  V, n = readVector("./../input/16/b.txt")
  result, error = gaussianElimination(M, V, n, l)
  expected = ones(n)
  for i in 1:length(expected)
    @test expected[i] ≈ result[i]    
  end
end
function testGaussianEliminationWithPivot()
  M, n, l = readMatrix("./../input/50000/A.txt")
  V, n = readVector("./../input/50000/b.txt")
  result, error = gaussianEliminationWithPivot(M, V, n, l)
  expected = ones(n)
  for i in 1:length(expected)
    @test expected[i] ≈ result[i]    
  end
end
function testGaussianElimination()
  M, n, l = readMatrix("./../input/16/A.txt")
  V, n = readVector("./../input/16/b.txt")
  result1, error = gaussianElimination(M, V, n, l)
  result2, error = gaussianEliminationWithPivot(M, V, n, l)
  expected = ones(n)
  
  for i in 1:length(expected)
    @test result1[i] ≈ result2[i]    
  end

  for i in 1:length(expected)
    @test expected[i] ≈ result1[i]    
  end
end

function testLowerUpperFactorizationWithPivot() 
  M, n, l = readMatrix("./../input/50000/A.txt")
  V, n = readVector("./../input/50000/b.txt")
  (L, U), error = lowerUpperFactorizationWithPivot(M, n, l)
end

function testLowerUpperFactorization() 
  M, n, l = readMatrix("./../input/16/A.txt")
  V, n = readVector("./../input/16/b.txt")
  (L, U), error = lowerUpperFactorization(M, n, l)
end

function testResultOfLU()
  M = sparse([
    1.0 4.0 -3.0 4.0;
    -2.0 8.0 5.0 4.0;
    3.0 2.0 3.0 4.0;
    3.0 4.0 7.0 4.0 ;
  ])
  b = sparse([1.0 ; 2.0 ; 3.0 ; 4.0])
  expectedResult = full(M) \ full(b) 

  n = 4
  l = 4

  (L1, U1), error = lowerUpperFactorization(M, n, l)
  result = solveFromLowerUpperMatrices(L1, U1, b, n, l)

  
  for i in 1:length(result)
    @test expectedResult[i] ≈ result[i]    
  end

  (L2, U2), error = lowerUpperFactorizationWithPivot(M, n, l)
  result = solveFromLowerUpperMatrices(L1, U2, b, n, l)
end

function testGaussianEliminationShouldThrowError()
  M, n, l = readMatrix("./../input/8/A.txt")
  V, n = readVector("./../input/8/b.txt")
  result, error = gaussianElimination(M, V, n, l)
  @test error == 1
end

# testShouldReadMatrixAndEvalVector()
# testGaussianEliminationWithoutPivoting()
testGaussianEliminationWithPivot()
# testGaussianElimination()
# testGaussianEliminationShouldThrowError()
# testLowerUpperFactorizationWithPivot();
# testLowerUpperFactorization();
# testResultOfLU()
