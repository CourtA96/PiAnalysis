using PiAnalysis
using Test

setprecision(BigFloat, 1024)

# Check that chud() is calculating pi accurately to 100 decimal places
# compare the result of chud() to that of Julia's pi

p1 = BigFloat(pi)
p2 = chud()
diff = abs(p1-p2)

@test diff < 10^(-100)

@testset "Test of numDig()" begin

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
