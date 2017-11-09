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

function computeOnRandom(n, cond)
    ONES = ones(n, 1)
    A = matcond(n, cond)
    b = A * ONES
    gauss = A \ b
    inverted = inv(A) * b

    @printf "%d & %d & %.10e & %.10e \\\\\n" n cond norm(gauss - ONES)/norm(ONES) norm(inverted - ONES)/norm(ONES)
    
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

#  \subsubsection*{Macierz Hilberta}
#  $$
#  \begin{array}{c|c|c|c}
#  n & \textit{cond} & gauss & A^{-1}\\
#  \hline
#  1 & 1.00000e+00 & 0.0000000000e+00 & 0.0000000000e+00 \\
#  2 & 1.92815e+01 & 5.6610488670e-16 & 1.1240151438e-15 \\
#  3 & 5.24057e+02 & 8.0225937723e-15 & 9.8255260382e-15 \\
#  4 & 1.55137e+04 & 4.4515459602e-13 & 2.9504776373e-13 \\
#  5 & 4.76607e+05 & 1.6828426299e-12 & 8.5000557778e-12 \\
#  6 & 1.49511e+07 & 2.6189133023e-10 & 3.3474135070e-10 \\
#  7 & 4.75367e+08 & 1.2606867224e-08 & 5.1639591836e-09 \\
#  8 & 1.52576e+10 & 1.0265430657e-07 & 2.6987150743e-07 \\
#  9 & 4.93154e+11 & 4.8323571205e-06 & 9.1758468686e-06 \\
#  10 & 1.60244e+13 & 6.3291537230e-04 & 4.5521422517e-04 \\
#  11 & 5.22268e+14 & 1.1543958596e-02 & 8.0444667734e-03 \\
#  12 & 1.75147e+16 & 2.9756403107e-01 & 3.4392937091e-01 \\
#  13 & 3.34414e+18 & 2.3750178677e+00 & 5.5857968932e+00 \\
#  14 & 6.20079e+17 & 5.2810046468e+00 & 4.8006419290e+00 \\
#  15 & 3.67439e+17 & 1.1772947348e+00 & 4.8273577213e+00 \\
#  16 & 7.86547e+17 & 2.0564655824e+01 & 3.1736467496e+01 \\
#  17 & 1.26368e+18 & 1.7742214635e+01 & 1.5910335963e+01 \\
#  18 & 2.24463e+18 & 4.2764564411e+00 & 6.2812234335e+00 \\
#  19 & 6.47195e+18 & 2.2119937293e+01 & 2.2925614016e+01 \\
#  20 & 1.35537e+18 & 1.4930069669e+01 & 2.1539498603e+01 \\
#  \end{array}
#  $$
#  \subsubsection*{Losowa macierz o zadanym współczynniku \textit{cond}}
#  $$
#  \begin{array}{c|c|c|c}
#  n & \textit{cond} & gauss & A^{-1}\\
#  \hline
#  5 & 2.1065000811e-16 & 1.7199501140e-16 \\
#  5 & 2.4825341532e-16 & 1.8577584505e-16 \\
#  5 & 1.7901808365e-16 & 1.5700924587e-16 \\
#  5 & 2.4825341532e-16 & 1.9860273226e-16 \\
#  5 & 4.2711132546e-16 & 5.5288660752e-16 \\
#  10 & 2.3551386880e-16 & 2.9582808635e-16 \\
#  10 & 1.2658490091e-16 & 1.0532500406e-16 \\
#  10 & 6.9333405666e-16 & 6.5116260378e-16 \\
#  10 & 2.8305244335e-16 & 3.0807438657e-16 \\
#  10 & 5.4389598220e-16 & 5.1717806477e-16 \\
#  20 & 4.5842935719e-16 & 5.8008489024e-16 \\
#  20 & 4.8074067160e-16 & 3.8459253728e-16 \\
#  20 & 5.5121203545e-16 & 3.9565083834e-16 \\
#  20 & 4.7298628134e-16 & 3.4844027278e-16 \\
#  20 & 5.6446952974e-16 & 5.9529077749e-16 \\
#  \end{array}
#  $$