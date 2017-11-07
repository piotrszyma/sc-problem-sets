using Plots

in = linspace(1, 40, 200)

function ln(x)
  return log(exp(1), x)
end

function f(x)
  return (exp(1)^x) * ln(1 + exp(-x))
end

# in = map(in, f)
arr = [f(x) for x = in]

plot(arr)

png("juliaplot")