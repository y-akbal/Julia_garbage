function attention(Q :: Matrix{Float64}, K :: Matrix{Float64}, V :: Matrix{Float64})
    attention_scores = Q*transpose(K)/sqrt(length(Q))
    exp_d = exp.(attention_scores)
    allignment_scores = exp_d./(sum(exp_d, dims = 2))
    attention_vecs = allignment_scores*V
    
    return allignment_scores ,attention_vecs
end