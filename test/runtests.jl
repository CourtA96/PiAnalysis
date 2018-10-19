using PiAnalysis
using Test

# Check that chud() is calculating pi accurately to 100 decimal places
# by comparing the result of chud() to that of Julia's pi ( this also)
# serves to confirm that Julia's pi is accurate.

@testset "Test of chud() and piAccurate()" begin

  for i in 1:10

    setprecision(BigFloat,1024*i)

    p1 = BigFloat(pi)
    p2 = chud(1024*i)
    diff1 = abs(p1-p2)
    diff2 = piAccurate(1024*i)

    a_temp = 10^(BigInt(300*i))
    a = BigFloat(1/a_temp)

    @test diff1 < a
    @test diff2 == diff1

  end

end

@testset "Test of numDig()" begin

  oneTo10_temp = numDig(1,10,1024)
  oneTo10 = oneTo10_temp[:,2]
  correctOneTo10 = [0,2,1,1,1,3,1,0,0,1]

  @test oneTo10-correctOneTo10 == [0,0,0,0,0,0,0,0,0,0]

  for i in 1:100
    i = 1
    ary = numDig(i,5*i,2048)
    intvl = 5*i-i+1

    for j in 1:10
      @test ary[j,2] < (intvl/10) + sqrt(intvl)
      @test ary[j,2] > (intvl/10) - sqrt(intvl)
    end

  end
end
