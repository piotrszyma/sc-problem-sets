module MyModule

export mbisekcji, mstycznych, msiecznych

function mbisekcji(f, a::Float64, b::Float64, delta::Float64, epsilon::Float64)
  u = f(a)
  v = f(b)
  e = b - a
  i = 0;
  if (sign(u) == sign(v))
    return (0, 0, 0, 1)
  end
  while true
    i += 1;
    e = e / 2;
    c = a + e
    w = f(c)
    if(abs(e) < delta || abs(w) < epsilon)
      return (c, w, i, 0)
    end
    if (sign(w) != sign(u))
      b = c; v = w;
    else
      a = c; u = w;
    end
  end
end

function mstycznych(f, pf, x0::Float64, delta::Float64, epsilon::Float64, maxit::Int)
  v = f(x0)
  if (abs(v) < epsilon) 
    return (x0, v, 0, 0)
  end

  if (abs(pf(x0)) < epsilon)
    return (x0, v, 0, 2)
  end 

  for k in [1:maxit...]
    x1 = x0 - (v / (pf(x0)))
    v = f(x1)
    if (abs(x1 - x0) < delta || abs(v) < epsilon)
      return (x1, v, k, 0)
    end
    x0 = x1;
  end
  return (x0, f(x0), maxit, 0)  
end

function msiecznych(f, a::Float64, b::Float64, delta::Float64, epsilon::Float64,
  maxit::Int)
  fa = f(a)
  fb = f(b)
  for k in [1:maxit...]
    if abs(fa) > abs(fb)
      a, b = b, a
      fa, fb = fb, fa
    end
    s = (b - a) / (fb - fa)
    b = a
    fb = fa
    a = a - (fa * s)
    fa = f(a)
    if (abs(b - a) < delta || abs(fa) < epsilon)
        return (a, fa, k, 0)
    end
  end
  return (a, fa, maxit, 1)  
end

end