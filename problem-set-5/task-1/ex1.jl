# Read from file

function read_matrix_from_file(filename)
  open(filename) do f
    lines = readlines(f)

    n, l = split(lines[1])
    n, l = parse(Int, n), parse(Int, l)

    v = n / l

    R = [[0.0 for _ in 1:n] for _ in 1:n]
    # INPUT = []
    for line in lines[2:end]
      x, y, value = split(line)
      x = parse(Int64, x)
      y = parse(Int64, y)
      value = parse(Float64, value)
      R[x][y] = value
    end
    for (i, r) in enumerate(1:n)
        println(R[r])
    end
    shift = -1;
    for (i, r) in enumerate(1:4:n)
        # println(r)
        for x in r:r+3
          println(shift)
          println(x)
        end
        shift += 1;
    end
    
    # first = INPUT[1:(l * (l + 1))]
    # middle = INPUT[(l * (l + 1)) + 1:(l * (l + 2)) - 1]
    # println(last)    
  end
end

function read_vector_from_file(filename)
  open(filename) do f
    lines = readlines(f)
    n, l = lines[1]
    for l in lines[2:end]
      v = l
    end
  end
end

read_matrix_from_file("../input/A.txt");
# read_vector_from_file("../input/b.txt");