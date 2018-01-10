module blocksys
  export 
  readMatrix, 
  readVector, 
  writeVector,
  printMatrix,  
  
  gaussianElimination,
  gaussianEliminationWithPivot,
  lowerUpperFactorization,
  lowerUpperFactorizationWithPivot,
  
  
  solveFromLowerUpperMatrices,

  colRange,
  matrixTimesX
  
  

  function printMatrix(matrix) 
    n = trunc(Int, sqrt(length(matrix)))
    @printf "%d x %d matrix\n\n" n n
    for x in 1:n
      for y in 1:n
        @printf "%5.2f" matrix[x, y]
        print(" ")
      end
      print("\n")
    end
    println()
  end

  function printVector(vector)
    n = length(vector)
    println("Vector")
    print("[ ")
    for i in 1:n
      print(vector[i])
      print(" ")
    end
    print(" ]")
  end

  function readMatrix(filepath::String)
    lines = []
    open(filepath) do f
      lines = readlines(f)
    end
      n, l = [parse(Int, x) for x in split(lines[1])]
      M = spzeros(n, n)
      for line in lines[2:end]
        x, y, value = split(line)
        x = parse(Int64, x)
        y = parse(Int64, y)
        value = parse(Float64, value)
        M[x, y] = value
      end

      return M, n, l
  end

  function readVector(filepath::String)
    lines = []
    open(filepath) do f
      lines = readlines(f)
    end
      n = parse(Int64, lines[1])

      V = spzeros(n)
      
      for (i, l) in enumerate(lines[2:end])
        V[i] = parse(Float64, l)
      end
      return V, n
  end

  function writeVector(vector::Array{Float64}, filepath::String)
    open(filepath, "w") do f
      for n in vector
        @printf(f, "%0.10f\n", n)
      end
    end
  end

  function writeVector(vector::Array{Float64}, error::Float64, filepath::String)
    open(filepath, "w") do f
      write(f, "$error\n")
      for n in vector
        @printf(f, "%0.10f\n", n)
      end
    end
  end

  function matrixTimesX(matrix::SparseMatrixCSC, x::SparseVector, n::Int64, l::Int64)
    # it works
    b = spzeros(n)
    for row in 1:n
      b[row] = 0.0
      for col in colRange(row, n, l)
        b[row] = b[row] + matrix[row, col] * x[col]
      end
    end
    return b
  end

  function colRange(row::Int64, n::Int64, l::Int64)
    minMul = trunc(Int, (row - 1) / l) - 1
    maxMul = minMul + 3
    min = (minMul * l + 1) > 1 ? (minMul * l + 1) : 1 
    max = (maxMul * l) < n ? maxMul * l : n
    return min:max
  end

  function combineRanges(upperRow::Int64, lowerRow::Int64, n::Int64, l::Int64)
     upper = colRange(upperRow, n, l)
     lower = colRange(lowerRow, n, l)
     if upper[end] >= lower[1]
      return collect(lower[1] : upper[end])
     else
      return vcat(collect(lower), collect(upper))
     end
  end

  function performGaussianElimination(A::SparseMatrixCSC, b::SparseVector, n::Int64, l::Int64, pivoting::Bool, solve::Bool)
    if !solve 
      pivoting = false
    end
    # Perform gaussian elimination (zero lower  left triangle)
    L = spzeros(n, n)
    U = copy(A)
    maxRowIndex = 0

    # for all columns
    for k in 1:n-1
      limit = k + 2 * l > n ? n : k + 2 * l
        if pivoting == true
          max = 0
          # find max
          for j = k:limit
              # [row, col]
              if abs(U[j,k]) > max
                  max = abs(U[j,k])
                  maxRowIndex = j
              end
          end
          if maxRowIndex != k
            for j = combineRanges(k, maxRowIndex, n, l)
              U[k, j], U[maxRowIndex, j] = U[maxRowIndex, j], U[k, j]
            end
            b[k], b[maxRowIndex] = b[maxRowIndex], b[k]
          end
        end
        if abs(U[k, k]) < eps(Float64)
          val = U[k, k]
          println("Error: U[$k, $k] = $val < eps(Float64)!")
          return [], 1
        end
      # for all rows to zero in column
      for i in k+1:limit
        factor = U[i, k] / U[k, k]
        L[i, k] = factor
        U[i, k] = 0.0
        # for all columns in row
        for j in k+1:limit
          # multiply by first row
          U[i, j] = U[i, j] - factor * U[k, j]
        end
        b[i] = b[i] - factor * b[k]
      end     
    end
    if solve
      R = backwardSubstitution(U, b, n, l)
      return R, 0
    else
      for i in 1:n
        L[i, i] = 1.0
      end  
      return (L, U), 0
    end
  end

  function gaussianElimination(A::SparseMatrixCSC, b::SparseVector, n::Int64, l::Int64)
    X, error = performGaussianElimination(copy(A), copy(b), n, l, false, true)
    return sparse(X), error
  end
  
  function gaussianEliminationWithPivot(A::SparseMatrixCSC, b::SparseVector, n::Int64, l::Int64)
    X, error = performGaussianElimination(copy(A), copy(b), n, l, true, true)
    return sparse(X), error
  end

  function lowerUpperFactorization(A::SparseMatrixCSC, n::Int64, l::Int64)
    b = spzeros(n)
    (L, U), error = performGaussianElimination(copy(A), copy(b), n, l, false, false)
    return (L, U), error
  end

  function lowerUpperFactorizationWithPivot(A::SparseMatrixCSC, n::Int64, l::Int64)
    b = spzeros(n)
    (L, U), error = performGaussianElimination(copy(A), copy(b), n, l, true, false)
    return (L, A), error
  end

  function forwardSubstitution(L::SparseMatrixCSC, b::SparseVector, n::Int64, l::Int64)
    R = spzeros(n)
    for row in 1:n
      s = b[row]
      # for col in 1:i-1
      # is it ok?
      for col in colRange(row, row-1, l)
      # range = (row - 2*l > 1 ? row - 2*l : 1) :(row + 2*l > n ? n : row + 2 * l)
      # for col in range
        s = s - L[row, col] * R[col]
      end
      R[row] = s / L[row, row]
    end
    return R
  end
  
  function backwardSubstitution(U::SparseMatrixCSC, b::SparseVector, n::Int64, l::Int64)
    # this is valid
    R = spzeros(n)
    for row in n:-1:1
      s = b[row]
      # for col in i+1:n
      # range = (row-2*l > 1 ? row-2*l : 1):(row+2*l > n ? n : row + 2*l)
      for col in colRange(row, n, l)
      # for col in range
        s = s - U[row, col] * R[col]
      end
      R[row] = s / U[row, row]
    end
    return R
  end

  function solveFromLowerUpperMatrices(L::SparseMatrixCSC, U::SparseMatrixCSC, b::SparseVector, n::Int64, l::Int64)
    y = forwardSubstitution(copy(L), b, n, l)
    x = backwardSubstitution(copy(U), y, n, l)
    return x
  end
end 