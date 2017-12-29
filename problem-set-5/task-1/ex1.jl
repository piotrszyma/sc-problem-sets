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

  println(A)

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

println(vector)