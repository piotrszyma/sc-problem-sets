include("../lib/func.jl")

function computeAbsoluteError(m, n)
    return norm(m - n) / norm(n)
end

function computeOnHilbert(n)
    A = hilb(n)
    b = A * ones(n, 1)
    gauss = A \ b
    inverted = inv(A)  * b

    gauss_abs_err = computeAbsoluteError(gauss, ones(n, 1))
    inverted_abs_err = computeAbsoluteError(inverted, ones(n, 1))
    @printf "%d & %.10e & %.10e \\\\\n" n gauss_abs_err inverted_abs_err
end

function computeOnRandom(n, cond)
    A = matcond(n, cond)
    b = A * ones(n, 1)
    gauss = A \ b
    inverted = inv(A)  * b

    gauss_abs_err = computeAbsoluteError(gauss, ones(n, 1))
    inverted_abs_err = computeAbsoluteError(inverted, ones(n, 1))
    @printf "%d & %d & %.10e & %.10e \\\\\n" n cond gauss_abs_err inverted_abs_err
    
end
println("\\subsubsection*{Macierz Hilberta}")
println("\$\$")
println("\\begin{array}{c|c|c}")
println("n & gauss & random\\\\")
println("\\hline")
for n = 1:20
    computeOnHilbert(n)
end
println("\\end{array}")
println("\$\$")
println("\\subsubsection*{Losowa macierz o zadanym współczynniku \\textit{cond}}")
println("\$\$")
println("\\begin{array}{c|c|c|c}")
println("n & \\textit{cond} & gauss & random\\\\")
println("\\hline")

 for n = [5, 10, 20]
     for c = [1.0, 3.0, 7.0, 12.0, 16.0]
         computeOnRandom(n, c)
     end
 end
 println("\\end{array}")
 println("\$\$")
 