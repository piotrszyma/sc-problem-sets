fileLocation = "../input/A.txt"

open(fileLocation) do f
  input = split(readline(f))
  n=parse(Int64, input[1])
  l=parse(Int64, input[2])

  @printf "n: %d l: %d\n" n l

  data=zeros(Float64,n,n);
  
  while !eof(f)
      input = split(readline(f))
      x=parse(Int64, input[1])
      y=parse(Int64, input[2])
      var=parse(Float64, input[3])
      print(input[1])
      print(input[2])
      print(input[3])
      data[x, y]=var
  end
end