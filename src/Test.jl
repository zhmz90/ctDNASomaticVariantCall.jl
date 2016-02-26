module Test

type Te
    a::Int64
    b::Int64


end

function Te(a::ASCIIString, b::ASCIIString)
    a = parse(Int64, a)
    b = parse(Int64, b)
    Te(a,b)
end



end
