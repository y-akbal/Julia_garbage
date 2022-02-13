
using LinearAlgebra

size_ = 10000
function create_random_mat(size_::Int32)
    A = randn(size_, size_)
    return convert(Matrix{Float64}, A)
end

A = create_random_mat(size_) ### this is the matrix to be inverted
B = create_random_mat(size_) ### this is the matrix that is going to be the inverse of A


function iterate(A::Matrix{Float32}, B::Matrix{Float32}, n::Int64, lr::Float64)
    for i in 1:n
        gradient = transpose(A)*(A*B- I)
        B = B - lr*gradient
        println(norm(A*B-I))
    end
    return B
end

B = iterate(A, B, 100000, 0.0001) ### if you are lucky and adjust the right learning rate you will get the inverse of A, even stay calm for a while can see smurfs.

