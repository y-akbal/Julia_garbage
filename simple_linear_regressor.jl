using Flux
using Distributions
using Printf
X = Float32.(randn(10,10000))
W = Float32.(randn(1,10))
b = Float32.(randn(1))
y =  W*X .+ b


model = Dense(10,1)

function loss_(X,y)
    return Flux.mse(flatten(model(X)),y)
end

function train(X,y; lr = 0.001f0::Float32, n = 1000::Int64)
    params = Flux.params(model)
    for i in 1:n
        loss__ = loss_(X,y)
        if i% 100 == 0
            @printf("loss is %f \n", loss__)
        end
        #println(loss__)
        grad = gradient(()-> loss_(X,y), Flux.params(model))
        for layer in params
            layer .-= lr.*grad[layer]
        end
    end
end


train(X[:,3:10],y[:,3:10], n = 200, lr = 0.1)

