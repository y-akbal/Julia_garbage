using Plots
using LinearAlgebra
using Parameters

@with_kw mutable struct Kol  #@with_kw macro here allows one to set x,y  = 0 default which does not make sense at fist glance
    """
    θ is the tuple of angles (in radian, relative to x-axis)
    r is the tuple of radii
    x x-cord of the robotic arm
    y y-cord of the //
    """
    θ::Vector{Float32}
    r::Vector{Float32}
    x::Float32 = randn()
    y::Float32 = randn()
end

a = Kol(θ = Float32.(abs.(randn(20))), r = Float32.(abs.(randn(20)))) ### initialize the arm

function last_pt(a::Kol)
    x = 0
    y = 0
    for (i,j) in zip(a.θ, a.r)
        x += j*cos(i)
        y += j*sin(i)
    end
    a.x = x
    a.y = y        
end


function distance(a::Kol, p::Vector{Float32})  ### distance between current position of the arm and the point p
    t = [a.x, a.y]
    return norm(t-p)
end

function get_grad(a::Kol, p::Vector{Float32}) ### this dude gives the gradient with respect to the angles
    ∇θ = [2*(p[1] - a.x)*i*sin(j) - 2*(p[2] - a.y)*i*cos(j) for (i,j) in zip(a.r,a.θ)]
    return ∇θ
end


function arm_move(a::Kol, p::Vector{Float32}, lr::Float32 = 0.01f0)
    Lx = []
    Ly = []
    grad = [0 for i in a.θ]
    for i in 1:10000
        last_pt(a) #### update x,y coordinates of the arm
        push!(Lx,a.x)
        push!(Ly,a.y)
        a.θ = a.θ - lr*get_grad(a, p)/norm(get_grad(a,p))
        println(distance(a, p))
    end
    return Lx, Ly
end


a = Kol(θ = Float32.(abs.(randn(20))), r = Float32.(abs.(randn(20)))) ### initialize the arm

p = Float32.([1,5])

Lx, Ly = arm_move(a, p)
using Plots
scatter!(Lx, Ly)
 
