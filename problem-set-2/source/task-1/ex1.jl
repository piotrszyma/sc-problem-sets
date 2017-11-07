# Modyfikacja zadania 5 z listy 1
# autor Piotr Szyma

function sumForward(vec_x, vec_y, n_type)
    n = length(vec_x)
    sum = n_type(0.0)
    i = 1
    while i <= n
        sum += vec_x[i] * vec_y[i]
        i+=1
    end
    return sum
end

function sumBackward(vec_x, vec_y, n_type)
    n = length(vec_x)
    sum = n_type(0.0)
    i = n
    while i >= n_type(1.0)
        sum += vec_x[i] * vec_y[i]
        i-=1;
    end
    return sum
end

function sortedDescending(vec_x, vec_y, n_type)
    n = length(vec_x)
    
    i = n
    
    p_sums = Array{n_type}(n)
    
    while i > 0
        p_sums[i] =  vec_x[i] * vec_y[i]
        i -= 1
    end
    
    p_pos = n_type[]
    p_neg = n_type[]
    
    for num in p_sums
        if num >=0
            push!(p_pos, num)
        else
            push!(p_neg, num)
        end
    end
    
    sort!(p_pos, rev=true)
    sort!(p_neg)
    
    p_pos_sum = n_type(0.0)
    p_neg_sum = n_type(0.0)
    
    for num in p_pos
        p_pos_sum += num
    end
    
    for num in p_neg
        p_neg_sum += num
    end
    
    sum = p_pos_sum + p_neg_sum
    return sum
end

function sortedAscending(vec_x, vec_y, n_type)
    n = length(vec_x)
    i = n

    p_sums = Array{n_type}(n)

    while i > 0
        p_sums[i] =  vec_x[i] * vec_y[i]
        i -= 1
    end

    p_pos = n_type[]
    p_neg = n_type[]

    for num in p_sums
        if num >=0
            push!(p_pos, num)
        else
            push!(p_neg, num)
        end
    end

    sort!(p_pos)
    sort!(p_neg, rev=true)

    p_pos_sum = n_type(0.0)
    p_neg_sum = n_type(0.0)

    for num in p_pos
        p_pos_sum += num
    end

    for num in p_neg
        p_neg_sum += num
    end

    sum = p_pos_sum + p_neg_sum
    return sum
end

vec_x = [2.718281828,(-1.0) * 3.141592654, 1.414213562, 0.5772156649, 0.3010299957]
vec_y = [1486.2497, 878366.9879,(-1.0) * 22.37492, 4773714.647, 0.000185049]

vec_x_2 = [2.718281828,(-1.0) * 3.141592654, 1.414213562, 0.577215664, 0.301029995]

# a) "forward"

n_type = Float64
println("\\subsubsection*{Float64}")
println("\$\$")
println("\\begin{array}{c|c|c}")
println("algorytm & przed & po\\\\")
println("\\hline")
@printf "1 & %15e & %15e \\\\\n" sumForward(vec_x, vec_y, n_type) sumForward(vec_x_2, vec_y, n_type)
@printf "2 & %15e & %15e \\\\\n" sumBackward(vec_x, vec_y, n_type) sumBackward(vec_x_2, vec_y, n_type)
@printf "3 & %15e & %15e \\\\\n" sortedDescending(vec_x, vec_y, n_type) sortedDescending(vec_x_2, vec_y, n_type)
@printf "4 & %15e & %15e \\\\\n" sortedAscending(vec_x, vec_y, n_type) sortedAscending(vec_x_2, vec_y, n_type)
println("\\end{array}")
println("\$\$")

vec_x = [Float32(vec_x[i]) for i = 1:size(vec_x,1)]
vec_y = [Float32(vec_y[i]) for i = 1:size(vec_y,1)]
vec_x_2 = [Float32(vec_x_2[i]) for i = 1:size(vec_x_2,1)]

n_type = Float32

println("\\subsubsection*{Float32}")
println("\$\$")
println("\\begin{array}{c|c|c}")
println("algorytm & przed & po\\\\")
println("\\hline")
@printf "1 & %15e & %15e \\\\\n" sumForward(vec_x, vec_y, n_type) sumForward(vec_x_2, vec_y, n_type)
@printf "2 & %15e & %15e \\\\\n" sumBackward(vec_x, vec_y, n_type) sumBackward(vec_x_2, vec_y, n_type)
@printf "3 & %15e & %15e \\\\\n" sortedDescending(vec_x, vec_y, n_type) sortedDescending(vec_x_2, vec_y, n_type)
@printf "4 & %15e & %15e \\\\\n" sortedAscending(vec_x, vec_y, n_type) sortedAscending(vec_x_2, vec_y, n_type)
println("\\end{array}")
println("\$\$")