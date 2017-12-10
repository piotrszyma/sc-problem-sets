# Testy modułowe
# autor Piotr Szyma

include("ex1.jl");

using MyModule
using Base.Test

function compareArrays(valueToCheck, expectedValue)
  for (index, number) in enumerate(valueToCheck)
    @test number ≈ expectedValue[index] atol=ε
  end
end

ε = 0.001
x = [-2.0, -1.0, 0.0, 1.0, 2.0, 3.0]
f = [-25.0, 3.0, 1.0, -1.0, 27.0, 235.0]

@test ilorazyRoznicowe(x, f) == [-25.0, 28.0, -15.0, 5.0, 0.0, 1.0]

@test warNewton([1.0, 2.0, 3.0, 4.0, 5.0, 6.0], [1.0, 2.74953, -3.30607, 3.035, -0.885002, 0.124822], 1.0) == 1.0
@test warNewton([1.0, 2.0, 3.0, 4.0, 5.0, 6.0], [1.0, 2.74953, -3.30607, 3.035, -0.885002, 0.124822], -2.0) ≈ -862.17359 atol=ε
@test warNewton([1.0, 2.0, 3.0, 4.0, 5.0, 6.0], [1.0, 2.74953, -3.30607, 3.035, -0.885002, 0.124822], 5.0) ≈ 23.9252 atol=ε

compareArrays(naturalna([1.0, 2.0, 3.0, 4.0, 5.0, 6.0], [1.0, 2.74953, -3.30607, 3.035, -0.885002, 0.124822]),
[-62.7904, 124.504, -80.5761, 22.4949, -2.75733, 0.124822])


