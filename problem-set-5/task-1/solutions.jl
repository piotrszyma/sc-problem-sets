module blocksys
  export readMatrix, readVector, gaussianElimination, gaussianEliminationWithPivot

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

  function performGaussianElimination(A::SparseMatrixCSC, b::SparseVector, n::Int64, l::Int64, pivoting::Bool)
    # Perform gaussian elimination (zero lower  left triangle)
    mults = zeros(n)
    ptr = 0
    for k in 1:n-1
      for i in k+1:n
        # TODO: bounds
        mults[i] = A[i, k] / A[k, k]
        A[i, k] = 0.0
        for j in k+1:n
          A[i, j] = A[i, j] - mults[i] * A[k, j]
        end
        b[i] = b[i] - (mults[i] * b[k])
      end     
    end

    # Calculate solutions

    R = zeros(n)
    
    for i in n:-1:1
      s = b[i]
      for j in i+1:n
        s = s - A[i, j] * R[j]
      end
      R[i] = s / A[i, i]
    end
    return R
  end

  function gaussianEliminationWithPivot(A::SparseMatrixCSC, b::SparseVector, n::Int64, l::Int64)
    performGaussianElimination(A, b, n, l, true)
  end

  function gaussianElimination(A::SparseMatrixCSC, b::SparseVector, n::Int64, l::Int64)
    performGaussianElimination(A, b, n, l, false)
  end
end