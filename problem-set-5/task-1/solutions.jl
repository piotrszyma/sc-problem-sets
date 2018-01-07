module blocksys
  export 
  readMatrix, 
  readVector, 
  gaussianElimination,
  gaussianEliminationWithPivot,
  lowerUpperFactorization,
  lowerUpperFactorizationWithPivot,
  solveFromLowerUpperMatrices,
  printMatrix

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

  function performGaussianElimination(A::SparseMatrixCSC, b::SparseVector, n::Int64, l::Int64, pivoting::Bool, solve::Bool)
    # Perform gaussian elimination (zero lower  left triangle)
    mults = zeros(n)
    L = zeros(n, n)
    U = A
    index = 0
    for k in 1:n-1
      # consider matrix construction
      m = k + 1 + 2 * l > n ? n : k + 1 + 2 * l
      for i in k+1:n
        if pivoting == true
          max = 0
          # find max
          for j = k : m
              if abs(U[j,k]) > max
                  max = abs(U[j,k])
                  index = j
              end
          end
          # replace max with current
          for j = 1 : m
              temp = U[k,j]
              U[k,j] = U[index,j]
              U[index,j] = temp
          end
          temp = b[k]
          b[k] = b[index]
          b[index] = temp
        end
        mults[i] = U[i, k] / U[k, k]
        L[i, k] = mults[i]
        U[i, k] = 0.0
        for j in k+1:m
          U[i, j] = U[i, j] - mults[i] * U[k, j]
        end
        b[i] = b[i] - (mults[i] * b[k])
      end     
    end
    # calculate solutions
    if solve
      R = backwardSubstitution(U, b, n, l)
      return R
    else
      # return U
      for i in 1:n
        L[i, i] = 1.0
      end
      return sparse(L), sparse(A)
    end
    
  end

  function gaussianElimination(A::SparseMatrixCSC, b::SparseVector, n::Int64, l::Int64)
    X = performGaussianElimination(A, b, n, l, false, true)
    return sparse(X)
  end
  
  function gaussianEliminationWithPivot(A::SparseMatrixCSC, b::SparseVector, n::Int64, l::Int64)
    X = performGaussianElimination(A, b, n, l, true, true)
    return sparse(X)
  end

  function lowerUpperFactorization(A::SparseMatrixCSC, n::Int64, l::Int64)
    b = spzeros(n)
    L, U = performGaussianElimination(A, b, n, l, false, false)
    printMatrix(L)
    printMatrix(U)
    printMatrix(L * U)
    return L, U
  end

  function lowerUpperFactorizationWithPivot(A::SparseMatrixCSC, n::Int64, l::Int64)
    b = spzeros(n)
    L, U = performGaussianElimination(A, b, n, l, true, false)
    return L, U
  end

  function forwardSubstitution(L::SparseMatrixCSC, b::SparseVector, n::Int64, l::Int64)
    R = spzeros(n)
    for i in 1:n
      s = b[i]
      for j in 1:i-1
        s = s - L[i, j] * R[j]
      end
      R[i] = s / L[i, i]
    end
    return R
  end
  
  function backwardSubstitution(U::SparseMatrixCSC, b::SparseVector, n::Int64, l::Int64)
    # this is valid
    R = spzeros(n)
    for i in n:-1:1
      s = b[i]
      for j in i+1:n
        s = s - U[i, j] * R[j]
      end
      R[i] = s / U[i, i]
    end
    return R
  end

  function solveFromLowerUpperMatrices(L::SparseMatrixCSC, U::SparseMatrixCSC, b::SparseVector, n::Int64, l::Int64)
    y = forwardSubstitution(L, b, n, l)
    x = backwardSubstitution(U, y, n, l)
    return x
  end
end 