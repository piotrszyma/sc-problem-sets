include("./lib.jl")
include("./matrixgen.jl")


using blocksys, matrixgen
using Base.Test

function testReadMatrixAndVectorSolveAndWriteToFile()
  M, _, l = readMatrix("./../input/16/A.txt")
  V, n = readVector("./../input/16/b.txt")
  x, error = gaussianElimination(M, V, n, l)
  x1 = ones(n)
  err = norm(x - x1) / norm(x)
  writeVector(x1, "./../input/16/sol.txt")
  writeVector(x1, err, "./../input/16/sol_err.txt")
  x, error = gaussianEliminationWithPivot(M, V, n, l)
  x1 = ones(n)
  err = norm(x - x1) / norm(x)
  writeVector(x1, "./../input/16/sol_pivot.txt")
  writeVector(x1, err, "./../input/16/sol_pivot_err.txt")
end

function testGenerateLUFactAndMult()
  # n::Int, l::Int, ck::Float64, outputfile::String
  blockmat(12, 4, 100.0, "./../input/random/A.txt")
  M, n, l = readMatrix("./../input/random/A.txt")
  (L, U), error = lowerUpperFactorization(M, n, l)
  
  M1 = L * U

  for i in 1:n
    for j in 1:n
      @test M[i, j] ≈ M1[i, j]
    end
  end

end
# testReadMatrixAndVectorSolveAndWriteToFile()
testGenerateLUFactAndMult()