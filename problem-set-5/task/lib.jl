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

  function writeVector(vector::SparseVector, filepath::String)
    open(filepath, "w") do f
      for n in vector
        write(f, "$n\n")
      end
    end
  end

  function writeVector(vector::SparseVector, error::Float64, filepath::String)
    open(filepath, "w") do f
      write(f, "$error\n")
      for n in vector
        write(f, "$n\n")
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
        # if pivoting == true
        #   max = 0
        #   # find max
        #   for j = k : m
        #       # [row, col]
        #       if abs(U[j,k]) > max
        #           max = abs(U[j,k])
        #           index = j
        #       end
        #   end
        #   # replace max with current
        #   for j = 1 : m
        #       temp = U[k,j]
        #       U[k,j] = U[index,j]
        #       U[index,j] = temp
        #   end
        #   temp = b[k]
        #   b[k] = b[index]
        #   b[index] = temp
        # end
  function performGaussianElimination(A::SparseMatrixCSC, b::SparseVector, n::Int64, l::Int64, pivoting::Bool, solve::Bool)
    # Perform gaussian elimination (zero lower  left triangle)
    mults = spzeros(n)
    L = spzeros(n, n)
    U = A
    index = 0
    # for all columns
    for k in 1:n-1
      # for all indexes bigger than middle
      for i in k+1:n
        # if middle is ~ 0, error
        if abs(U[k, k]) < eps(Float64)
          return A, 1
        end

        mults[i] = U[i, k] / U[k, k]
        L[i, k] = mults[i]
        U[i, k] = 0.0
        # printMatrix(U)
        # forward elimination
        # divide 
        for j in k+1:k+1+(l * l)
          U[i, j] = U[i, j] - mults[i] * U[k, j]
        end
        b[i] = b[i] - (mults[i] * b[k])
      end     
    end
    # 
    if solve
      R = backwardSubstitution(U, b, n, l)
      return R, 0
    else
      # return U
      for i in 1:n
        L[i, i] = 1.0
      end
      return (L, A), 0
    end
  end

  function gaussianElimination(A::SparseMatrixCSC, b::SparseVector, n::Int64, l::Int64)
    X, error = performGaussianElimination(A, b, n, l, false, true)
    return sparse(X), error
  end
  
  function gaussianEliminationWithPivot(A::SparseMatrixCSC, b::SparseVector, n::Int64, l::Int64)
    X, error = performGaussianElimination(A, b, n, l, true, true)
    return sparse(X), error
  end

  function lowerUpperFactorization(A::SparseMatrixCSC, n::Int64, l::Int64)
    b = spzeros(n)
    (L, U), error = performGaussianElimination(A, b, n, l, false, false)
    return (L, U), error
  end

  function lowerUpperFactorizationWithPivot(A::SparseMatrixCSC, n::Int64, l::Int64)
    b = spzeros(n)
    (L, U), error = performGaussianElimination(A, b, n, l, true, false)
    return (L, U), error
  end

  function forwardSubstitution(L::SparseMatrixCSC, b::SparseVector, n::Int64, l::Int64)
    R = spzeros(n)
    for row in 1:n
      s = b[row]
      # for col in 1:i-1
      # is it ok?
      for col in colRange(row, row-1, l)
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
      for col in colRange(row, n, l)
        s = s - U[row, col] * R[col]
      end
      R[row] = s / U[row, row]
    end
    return R
  end

  function solveFromLowerUpperMatrices(L::SparseMatrixCSC, U::SparseMatrixCSC, b::SparseVector, n::Int64, l::Int64)
    y = forwardSubstitution(L, b, n, l)
    x = backwardSubstitution(U, y, n, l)
    return x
  end
end 