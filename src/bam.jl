using PyCall
@pyimport pysam

immutable Column
    depth::Float64
    A::Float64
    T::Float64
    C::Float64
    G::Float64
    N::Float64
    indel::Float64
end
import Base: zero
function zero(::Type{Column})
    Column(0.0,0,0,0,0,0,0)
end
#function zeros()
#=
function Column(depth,A,T,C,G,N,indel)
    Column(depth,A,T,C,G,C,N,indel)
end
=#
function Column(depth::Float64, probs::Array{Float64,1})
    @assert length(probs) == 6
    A,T,C,G,N,indel = probs
    Column(depth,A,T,C,G,N,indel)
end
type Aera
    sample_name::AbstractString
    chr::AbstractString
    st_pos::Int64
    ed_pos::Int64
    data::Array{Column,1}
end
function Aera(sample_name::AbstractString,chr::AbstractString,st_pos::Int64,ed_pos::Int64)
    chr = lowercase(chr)
    data = zeros(Column,ed_pos-st_pos+2)
    Aera(sample_name,chr,st_pos,ed_pos,data)
end

import Base: getindex,setindex!
getindex(aera::Aera, i::Int64) = aera.data[i]
function setindex!(aera::Aera, col::Column, i::Int64)
    aera.data[i] = col
end

immutable SAera
    sample_names::Array{AbstractString,1}
    chr::AbstractString
    st_pos::Int64
    ed_pos::Int64
    data::Array{Column,2}
end

#=
function ChrStat(fls)
end
=#



function chrstat(fl::AbstractString,chr::ASCIIString,st_pos::Int64,ed_pos::Int64)

    chr = lowercase(chr)
    area = Aera(fl,chr,st_pos,ed_pos)
    samfile = pysam.AlignmentFile(fl, "rb")
    i = 0
    @show chr,st_pos,ed_pos
    for column in samfile[:pileup](chr, st_pos, ed_pos)
        if column[:pos] < st_pos
            continue
        end
        if column[:pos] > ed_pos
            break
        end
        println("pos is ",column[:pos])
        basedict = OrderedDict{Char,Float64}('A'=>0,'T'=>0,'C'=>0,'G'=>0,'N'=>0,'D'=>0)
        for read in column[:pileups]
            if read[:is_refskip] != 0
                basedict['N'] += 1
                continue
            end
            if read[:is_del] != 0
                basedict['D'] += 1
                continue
            end
            query_pos = read[:query_position]+1
            @show read[:alignment][:query_name],read[:alignment][:query_sequence],query_pos
            @show read[:alignment][:query_sequence][read[:query_position]+1],i
       #     @show read[:alignment][:query_sequence],length(read[:alignment][:query_sequence]),i
            basedict[read[:alignment][:query_sequence][query_pos]] += 1
        end
        
        depth = sum(collect(values(basedict)))
        probs = collect(values(basedict)) ./ depth
        i += 1
        #area[i] = Column(depth,probs)
        #@show i,Column(depth,probs)
    end
    #@show area
end

function pileupstat()
    const fl = "../data/bam/004_gdna_rg.bam"
    samfile = pysam.AlignmentFile(fl, "rb")
    @show samfile
    for column in samfile[:pileup]("chr1", 100, 5000)
        println()
        for read in column[:pileups]
            if read[:is_del] == 0 && read[:is_refskip] == 0
                print(read[:alignment][:query_sequence][read[:query_position]+1])
            end
        end
        #sleep(0.1)
    end
end

function chrstat()
    chrstat("../data/bam/004_gdna_rg.bam","chr1",100000,200020)
end
println("hello")
