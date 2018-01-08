include("./lib.jl")

using blocksys

function readMatrixAndVectorSolveAndWriteToFile()
  M, _, l = readMatrix("./../input/16/A.txt")
  V, n = readVector("./../input/16/b.txt")

  println(M)
  # for row in 1:n
  #   println(colRange(row, l, n))
  # end
  # x, error = gaussianElimination(M, V, n, l)
  # writeVector(x, "./../input/16/result.txt")
end

readMatrixAndVectorSolveAndWriteToFile()
