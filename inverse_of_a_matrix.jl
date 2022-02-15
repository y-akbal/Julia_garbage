
using LinearAlgebra

size_ = 1000
function create_random_mat(size_::Int64)
    A = randn(Float32, size_, size_)
    return A
end

A = create_random_mat(size_) ### this is the matrix to be inverted
B = create_random_mat(size_) ### this is the matrix that is going to be the inverse of A

function iterate(A::Array{Float32,2}, B::Array{Float32,2}, n::Int64, lr::Float64)
    lr = convert(Float32, lr)
    transpose_ = permutedims(A)
    id = typeof(A)(I, size(A))
    for i in 1:n
        ∇f = transpose_*(A*B - id)
        B = B - (lr/norm(B)).*∇f
        
        println(norm(A*B-I))
        
    end
    return B
end

@time B = iterate(A, B, 100, 0.1) ### if you are lucky and adjust the right learning rate you will get the inverse of A, even can see smurfs if stay calm for a while.
