function matcond(n::Int, c::Float64)
# Function generates a random square matrix A of size n with
# a given condition number c.
# Inputs:
#	n: size of matrix A, n>1
#	c: condition of matrix A, c>= 1.0
#
# Usage: matcond (10, 100.0);
#
# Pawel Zielinski
        if n < 2
            error("size n should be > 1")
        end
        if c< 1.0
            error("condition number  c of a matrix  should be >= 1.0")
        end
        (U,S,V)=svd(rand(n,n))
        return U*diagm(linspace(1.0,c,n))*V'
end

function hilb(n::Int)
# Function generates the Hilbert matrix  A of size n,
#  A (i, j) = 1 / (i + j - 1)
# Inputs:
#	n: size of matrix A, n>0
#
#
# Usage: hilb (10)
#
# Pawel Zielinski
        if n < 1
            error("size n should be > 0")
        end
        A= Array{Float64}(n,n)
        for j=1:n, i=1:n
                A[i,j]= 1 / (i + j - 1)
        end
        return A
end

# Obliczenia na macierzy Hilberta & macierzy losowej
# autor Piotr Szyma

function computeAbsoluteError(m, n)
    return norm(ones(n, 1) - m) / norm(ones(n, 1))
end

function computeOnHilbert(n)
    A = hilb(n)
    ONES = ones(n, 1)
    b = A * ONES
    gauss = A \ b
    inverted = inv(A) * b
    @printf "%d & %.5e & %.10e & %.10e \\\\\n" n cond(A) norm(gauss - ONES)/norm(ONES) norm(inverted - ONES)/norm(ONES)
end

function computeOnRandom(n, con)
    ONES = ones(n, 1)
    A = matcond(n, 10^con)
    b = A * ONES
    gauss = A \ b
    inverted = inv(A) * b

    @printf "%d & %d & %.10e & %.10e \\\\\n" n con norm(gauss - ONES)/norm(ONES) norm(inverted - ONES)/norm(ONES)
    
end
println("\\subsubsection*{Macierz Hilberta}")
println("\$\$")
println("\\begin{array}{c|c|c|c}")
println("n & \\textit{cond} & gauss & A^{-1}\\\\")
println("\\hline")
for x = 1:20
    computeOnHilbert(x)
end
println("\\end{array}")
println("\$\$")
println("\\subsubsection*{Losowa macierz o zadanym współczynniku \\textit{cond}}")
println("\$\$")
println("\\begin{array}{c|c|c|c}")
println("n & \\textit{cond} & gauss & A^{-1}\\\\")
println("\\hline")

 for x = [5, 10, 20]
     for c = [1.0, 3.0, 7.0, 12.0, 16.0]
         computeOnRandom(x, c)
     end
 end
 println("\\end{array}")
 println("\$\$")
