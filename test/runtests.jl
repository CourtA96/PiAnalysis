using PiAnalysis
using Test

# Check that chud() is calculating pi accurately to 100 decimal places
# by comparing the result of chud() to that of Julia's pi ( this also)
# serves to confirm that Julia's pi is accurate.

@testset "Test of chud()" begin

  setprecision(BigFloat,2048)

#  p1 = BigFloat(pi)
#  p2 = chud(2048)
#  diff = abs(p1-p2)

  a_temp = 10^(BigInt(500))
  a = BigFloat(1/a_temp)

 diff = piAccurate(2048)

  @test diff < a

end

@testset "Test of numDig()" begin

  oneTo10_temp = numDig(1,10)
  oneTo10 = oneTo10_temp[:,2]
  correctOneTo10 = [0,2,1,1,1,3,1,0,0,1]

  @test oneTo10-correctOneTo10 == [0,0,0,0,0,0,0,0,0,0]

  for i in 1:100
    i = 1
    ary = numDig(i,5*i)
    intvl = 5*i-i+1

    for j in 1:10
      @test ary[j,2] < (intvl/10) + sqrt(intvl)
      @test ary[j,2] > (intvl/10) - sqrt(intvl)
    end

  end
end
