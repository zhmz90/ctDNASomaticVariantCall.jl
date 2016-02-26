module Pileup

const flpath = "/home/guo/haplox/Github/ctDNASomaticVariantCall/data/pileup/024_gdna.pileup"

type Record
    chr::ASCIIString
    pos::Int64
    ref::ASCIIString
    depth::Int64
    bases::ASCIIString
    quals::ASCIIString
end
function Record(chr::AbstractString,pos::AbstractString,ref::AbstractString,
                depth::Int64,bases::AbstractString,quals::AbstractString)
    
    chr = convert(ASCIIString, chr)
    pos = parse(Int64, convert(ASCIIString, pos))
    ref = convert(ASCIIString, ref)
    bases = convert(ASCIIString, bases)
    quals = convert(ASCIIString, quals)
    
    Record(chr,pos,ref,depth,bases,quals)
end

function pile2bases(pile::ASCIIString,ref::Char,depth::Int64)
    bases = ""
    indel = 0
    for i in 1:length(pile)
        s = pile[i]
        if indel > 0
            indel -= 1
            continue
        end
        if s == '.'
            bases = string(bases, uppercase(ref))
        elseif s == ','
            bases = string(bases, lowercase(ref))
        elseif s in ['A','T','C','G','N','a','t','c','g','n']
            bases = string(bases, s)
        elseif s in ['^','$']
            continue
        elseif s == '-'
            try
            indel = 1 + parse(Int64, pile[i+1])
            bases = string(bases, "D")
                catch ex
                @show ex,pile
            end
        elseif s == '+'
            indel = 1 + parse(Int64, pile[i+1])
            bases = string(bases, "I")
        elseif s == '*'
            bases = string(bases, "D")
        else
            continue
        end
    end    
    return bases
end
function parsepile()
    data_len = 1000_000
    data = Array{Record,1}(data_len)
    i = 0
    open(flpath) do file
        while !eof(file)
            raw = readline(file)
            row = split(strip(raw),"\t")
            if row[4] == "0" || length(row) > 6
                @show row
                continue
            end
            chr,pos,ref,depth,pile,quals = row
            i += 1
            @assert length(ref) == 1
            pile = convert(ASCIIString,pile)
            depth = parse(Int64, convert(ASCIIString,depth))
            bases = pile2bases(pile,ref[1],depth)
            rec = Record(chr,pos,ref,depth,bases,quals)
            if i <= data_len
                data[i] = rec
            else
                data_len = data_len + 1000_000
                resize!(data, data_len)
                data[i] = rec
            end
        end
    end

    data = data[1:i]
    #map(x->println(x.bases), data)
    nothing
end
parsepile()

end
