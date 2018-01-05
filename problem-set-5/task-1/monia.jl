#Monika Tworek
#229776

module MyModule
include("matrixgen.jl")

export loadMatrix, loadVector, Gauss, ObliczGaussa, genB, writeX, rozkladLU, ObliczLU

function loadMatrix()
    file = "./A.txt"
    n = 0
    l = 0
    open(file) do f
        n, l = map(x -> parse(Int, x), split(readline(f)))
        A = spzeros(n, n)
        while !eof(f)
            line = split(readline(f))
            i = parse(Int, line[1])
            j = parse(Int, line[2])
            v = parse(Float64, line[3])
            A[i, j] = v
        end
        return A, n, l
    end
end

function loadVector()
    file = "./b.txt"
    b = Dict{Int64, Float64}()
    n = 0
    open(file) do f
        n = parse(Int, readline(f))
        i = 1
        while !eof(f)
            b[i] = parse(Float64, readline(f))
            i += 1
        end
    end
    return b
end

function Gauss(A::SparseMatrixCSC{Float64, Int64}, b::Dict{Int64, Float64}, isChoose::Bool, l::Int64, n::Int64)
	err = 0
	index = 0
	for k=1:n-1
        m = k+1+2*l > n ? n : k+1+2*l
        if(isChoose == true)
            max=0
            for j = k : m
                if abs(A[j,k]) > max
                    max = abs(A[j,k])
                    index = j
                end
            end
            for j = 1 : m
                temp = A[k,j]
                A[k,j] = A[index,j]
                A[index,j] = temp
            end
            temp = b[k]
            b[k] = b[index]
            b[index] = temp
        end

        if(abs(A[k,k]) < eps(Float64))
            err = 1
            return A, b, err
        end

        for j = k+1 : m
            j=Int64(j)
            k=Int64(k)
            a = A[j,k] / A[k,k]
            A[j,k]=0
            for i=k+1:n
                i=Int64(i)
                A[j,i] = A[j,i] - (a*A[k,i])
            end
            b[j] = b[j] - (a*b[k])
        end
    end
    return A, b, err
end

function ObliczGaussa(A::SparseMatrixCSC{Float64,Int64}, b::Dict{Int64,Float64}, n::Int64, l::Int64)
    x=ones(n)
    for j=n :-1 : 1
        m = j+1+2*l > n ? n : j+1+2*l
        s = b[j]
        for k = j+1 : m
            s = s - A[j,k]*x[k]
        end
        x[j] = s/A[j,j]
    end
    return x
end

function ObliczLU(A::SparseMatrixCSC{Float64,Int64}, b::Dict{Int64,Float64}, n::Int64, l::Int64)
    y=Dict{Int64, Float64}()
    y[1]=b[1]
    for i = 2 : n
        m = i+1+2*l > n ? n : i+1+2*l
        s = 0.0
        for j = 1 : i-1
            if(i==j)
                s+=y[j]
            else
                s += A[i,j] * y[j]
            end
        end
        y[i] = b[i] - s
    end
    x = ObliczGaussa(A, y, n, l)
    return x
end

function rozkladLU(A::SparseMatrixCSC{Float64,Int64}, b::Dict{Int64,Float64}, isChoose::Bool, n::Int64, l::Int64)
    err = 0
	index = 0
	for k=1:n-1
        m = k+1+2*l > n ? n : k+1+2*l
        if(isChoose == true)
            max=0
            for j = k : m
                if abs(A[j,k]) > max
                    max = abs(A[j,k])
                    index = j
                end
            end
            for j = 1 : m
                temp = A[k,j]
                A[k,j] = A[index,j]
                A[index,j] = temp
            end
            temp = b[k]
            b[k] = b[index]
            b[index] = temp
        end

        if(abs(A[k,k]) < eps(Float64))
            err = 1
            return A, err
        end

        for j = k+1 : m
            j=Int64(j)
            k=Int64(k)
            a = A[j,k] / A[k,k]
            A[j,k]=a
            for i=k+1:m
                i=Int64(i)
                A[j,i] = A[j,i] - (a*A[k,i])
            end
            b[j] = b[j] - (a*b[k])
        end
    end
    return A, b, err
end

function genB()
    M, n, l = loadMatrix()
    b = Dict{Int64, Float64}()
    for y = 1:n
        b[y] = 0
        yy = div((y - 1), l) * l
        for x = yy:yy+l
            if x < 1 || x > n
                continue
            end
            b[y] += M[y, x]
        end
        if l +  y > 0 && l + y <= n
            b[y] += M[l + y]
        end
    end
    return M, b, n, l
end

function writeX(x1::Vector, x2::Vector, n::Int64)
    open("nopivot.txt", "w") do f
        for i = 1:n
            xi = x2[i]
            write(f, "$xi\n")
        end
    end

    open("pivot.txt", "w") do f
        for i = 1:n
            xi = x1[i]
            write(f, "$xi\n")
        end
    end
end

function writeX(x1::Vector, x2::Vector, n::Int64, errorSize::Float64)
    open("nopivot.txt", "w") do f
        write(f, "$errorSize\n")
        for i = 1:n
            xi = x2[i]
            write(f, "$xi\n")
        end
    end

    open("pivot.txt", "w") do f
        write(f, "$errorSize\n")
        for i = 1:n
            xi = x1[i]
            write(f, "$xi\n")
        end
    end
end

end
