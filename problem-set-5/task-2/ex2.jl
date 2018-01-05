
function luDecomposition(a::SparseMatrixCSC)
  n = trunc(Int, sqrt(length(a)))
  L = reshape([0.0 for i in 1:n * n], n, n)
  U = reshape([0.0 for i in 1:n * n], n, n)

  # decomposition
  for i in 1:n
    #upper triangular
    for k in i:n
      #summation of L(i, j) * U(j, k)
      sum = 0
      for j in 1:i
        sum += L[i, j] * U[j, k]
      end
      U[i, k] = a[i, k] - sum;
    end

    #lower triangular
    for k in i:n
      if i == k
        L[i, i] = 1.0
      else
        sum = 0
        for j in 1:i
          sum += L[k, j] * U[j, i]
        end
        L[k, i] = (a[k, i] - sum) / U[i, i]
      end
    end
  end
  return L, U
end


# A * x = b
# x = b / A

# println(gaussianElimination2(A, b))
x = [ 2. -4. -4. ; 
     -1.  6. -2. ; 
     -2.  3.  8. ]
# println(luDecomposition(sparse(x)))

# println(lufact(x))
# println(A \ b)