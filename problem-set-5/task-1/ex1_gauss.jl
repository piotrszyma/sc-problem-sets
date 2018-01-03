# Read from file

function generate_entry(values_list, size)
  parsed_list = []
  for v in values_list
    x, y, value = split(v)
    x = parse(Int64, x)
    y = parse(Int64, y)
    value = parse(Float64, value)
    push!(parsed_list, [x, y, value])
  end

  A_start = 1
  B_start = A_start + 2 * size
  C_start = B_start + size * size
  C_vals = parsed_list[A_start:A_start+2*size-1]
  A_vals = parsed_list[B_start:B_start+size*size-1]
  B_vals = parsed_list[C_start:end]

  A = zeros(Float64, size, size)
  B = zeros(Float64, size, size)
  C = zeros(Float64, size, size)
  
  counter = 1
  for i in 1:4
    for j in 1:4
      x, y, value = A_vals[counter]
      x = trunc(Int64, x)
      y = trunc(Int64, y)
      A[i, j] = value
      counter+=1
    end
  end

  counter = 1
  for j in 1:4
    x, y, value = B_vals[counter]
    x = trunc(Int64, x)
    y = trunc(Int64, y)
    B[j, j] = value
    counter+=1
  end

  counter = 1

  for i in 1:4
    for j in 3:4
      x, y, value = C_vals[counter]
      x = trunc(Int64, x)
      y = trunc(Int64, y)
      C[i, j] = value
      counter+=1
    end
  end

  return [sparse(x) for x in [A, B, C]]
end

function read_matrix_from_file(filename)
  open(filename) do f
    lines = readlines(f)
  end

    n, l = split(lines[1])
    n, l = parse(Int, n), parse(Int, l)

    v = n / l
    lines = [["0 0 0.0" for i in 1:2*l]; lines[2:end]; ["0 0 0.0" for i in 1:l];]

    parsed_input = []

    for index in 1:(l+3)*l:length(lines)
      A, B, C = generate_entry(lines[index:index + l*(l+3) - 1], l)
      push!(parsed_input, [C, A, B])
    end

    return parsed_input
end

function read_vector_from_file(filename, v)
  lines = []
  open(filename) do f
    lines = [parse(Float64, l) for l in readlines(f)]
  end
  n = trunc(Int, lines[1])
  l = trunc(Int, n / v)
  vector = []
  for block in 1:l:n
    push!(vector, lines[block:block+l-1])
  end
  return vector
end

matrix = read_matrix_from_file("../input/A.txt");

vector = read_vector_from_file("../input/b.txt", length(matrix))

A = reshape([
  [1.0, 2.0, 3.0, 4.0]
  [0.0, 1.0, 0.0, 0.0]
  [0.0, 0.0, 1.0, 0.0]
  [0.0, 0.0, 0.0, 1.0]
], 4, 4)
 
b = reshape([1.0, 1.0, 1.0, 1.0], 4)

A = sparse(A)
b = sparse(b)

function gaussianElimination(a::SparseMatrixCSC, b::SparseVector)
  n = trunc(Int, sqrt(length(a)))
  for k in 1:n - 1
    for i in k+1:n
      a[i, k] = a[i, k] / a[k, k]
      for j in k+1:n
        a[i, j] = a[i, j] - a[i, k] * a[k, j]
      end
    end
  end

  for k in 1:n - 1
    for i in k+1:n
      b[i] = b[i] - a[i, k] * b[k]
    end
  end
  x = [0.0 for i in 1:n]

  for i in n:-1:1
    s = b[i]
    for j in i+1:n
      s = s - a[i, j] * x[j]
    end
    x[i] = s / a[i, i]
  end
  return x
end

function gaussianElimination2(a::SparseMatrixCSC, b::SparseVector)
  n = trunc(Int, sqrt(length(a)))
  s = [0.0 for i in 1:n]
  p = [0 for i in 1:n]
  
  for i in 1:n
    s[i] = 0
    for j in 1:n
      s[i] = max(s[i], abs(a[i, j]))
    end
    p[i] = i
    println(p[i])
  end
  j = 0
  for k in 1:n-1
    r_max = 0
    for i in k:n
      r = abs(a[p[i], k] / s[p[i]])
      if r > r_max
        r_max = r
        j = i
      end
    end
    temp = p[k]
    p[k] = p[j]
    p[j] = temp
    for i in k+1:n
      a[p[i], k] = a[p[i], k] / a[p[k], k]
       for j in k+1:n
        a[p[i], j] = a[p[i], j] - a[p[i], k] * a[p[k], j]
       end
    end
  end
  
  # forward elimination

  for k in 1:n-1
    for i in k+1:n
      b[p[i]] = b[p[i]] - a[p[i], k] * b[p[k]]
    end
  end
  # backward solve
  x = [0.0 for i in 1:n]

  for i in n:-1:1
    s = b[p[i]]
    for j in i+1:n
      s = s - a[p[i], j] * x[j]
    end
    x[i] = s / a[p[i], i]
  end

  return x
end

function luDecomposition(a::SparseMatrixCSC)
  n = trunc(Int, sqrt(length(a)))
  L = reshape([0.0 for i in 1:n * n], n, n)
  U = reshape([0.0 for i in 1:n * n], n, n)

  # decomposition
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
println(luDecomposition(sparse(x)))

println(lufact(x))
# println(A \ b)