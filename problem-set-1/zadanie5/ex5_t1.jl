# Obliczanie iloczynu skalarnego dwóch wektorów za pośrednictwem różnych algorytmów
# autor Piotr Szyma

# Float64

x = [2.718281828,(-1.0) * 3.141592654, 1.414213562, 0.5772156649, 0.3010299957]
y = [1486.2497, 878366.9879,(-1.0) * 22.37492, 4773714.647, 0.000185049]

# a) "forward"

n_type = Float64

n = length(x)

sum = n_type(0.0)

i = 1

while i <= n
    sum += x[i] * y[i]
    i+=1
end

@printf "Sum forward:\t\t%15e\n" sum

# b) "backward"

sum = n_type(0.0)

i = n

while i >= n_type(1.0)
    sum += x[i] * y[i]
    i-=1;
end

@printf "Sum backward:\t\t%15e\n" sum

# c) sorted descending

#partial sums

i = n

p_sums = Array{n_type}(n)

while i > 0
    p_sums[i] =  x[i] * y[i]
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

p_pos_sum = 0.0
p_neg_sum = 0.0

for num in p_pos
    p_pos_sum += num
end

for num in p_neg
    p_neg_sum += num
end

sum = p_neg_sum + p_pos_sum

@printf "Sum pos desc neg asc:\t%15e\n" sum
# d) sorted ascending

#partial sums

i = n

p_sums = Array{n_type}(n)

while i > 0
    p_sums[i] =  x[i] * y[i]
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

p_pos_sum = 0.0
p_neg_sum = 0.0

for num in p_pos
    p_pos_sum += num
end

for num in p_neg
    p_neg_sum += num
end

sum = p_neg_sum + p_pos_sum

@printf "Sum pos asc neg desc:\t%15e\n" sum

# Float32

@printf "Float32\n"

x = [Float32(x[i]) for i = 1:size(x,1)]
y = [Float32(y[i]) for i = 1:size(y,1)]


# a) "forward"

n_type = Float32

n = length(x)

sum = n_type(0.0)

i = 1

while i <= n
    sum += x[i] * y[i]
    i+=1
end

@printf "Sum forward:\t\t%15e\n" sum

# b) "backward"

sum = n_type(0.0)

i = n

while i >= n_type(1.0)
    sum += x[i] * y[i]
    i-=1;
end

@printf "Sum backward:\t\t%15e\n" sum



# c) sorted descending

#partial sums

i = n

p_sums = Array{n_type}(n)

while i > 0
    p_sums[i] =  x[i] * y[i]
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

@printf "Sum pos desc neg asc:\t%15e\n" sum


# D) sorted descending

#partial sums

i = n

p_sums = Array{n_type}(n)

while i > 0
    p_sums[i] =  x[i] * y[i]
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

@printf "Sum pos asc neg desc:\t%15e\n" sum
