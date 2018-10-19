using PiAnalysis
using Test

# Check that chud() is calculating pi accurately by comparing the
# result of chud() to that of Julia's pi then check piAccurate() by
# comparing the difference to the result of piAccurate()
#
# Either they're both right or they're both wrong

@testset "Test of chud() and piAccurate()" begin

  # Check the accuracy of chud() and pi from 1024 bits
  # to 102400 bits

  for i in 1:10

    # Set the precision

    setprecision(BigFloat,1024*i)

    # Compute the difference between pi and chud() and then
    # compare to piAccurate()

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

# Check that the first 10 digits of numDig() are correct and then
# check that the results of numDig() and digCompare() don't vary
# outside statistical probability

@testset "Test of numDig()" begin

  # Check that the first ten digits are correct

  oneTo10_temp = numDig(1,10,1024)
  oneTo10 = oneTo10_temp[:,2]
  correctOneTo10 = [0,2,1,1,1,3,1,0,0,1]

  @test oneTo10-correctOneTo10 == [0,0,0,0,0,0,0,0,0,0]

  # Check that the results of numDig() and digCompare() don't vary
  # outside statistical probability
  #
  # The digits of pi are randomly distributed, so the count for each
  # digit shouldn't vary outside (+/-)sqrt(N) of 1/10th of N
  # where N is the length of the interval. By the same reasoning,
  # the result for each digit in digCompare() should be within
  # (+/-)sqrt(2)*sqrt(N) since errors add in quadrature.

  for i in 1:100

    ary1 = numDig(i,5*i,2048)
    ary2 = digCompare(i,2*i,2*i+1,3*i+1,2048)
    intvl = 5*i-i+1
    intvl2 = 2*i-i+1

    for j in 1:10
      @test ary1[j,2] < (intvl/10) + sqrt(intvl) # Test of numDig()
      @test ary1[j,2] > (intvl/10) - sqrt(intvl)
      @test ary2[j,2] < sqrt(2) * sqrt(intvl2)         # Test of digCompare()
      @test ary2[j,2] > -sqrt(2) * sqrt(intvl2)
    end

  end
end
