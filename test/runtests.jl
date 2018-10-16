using PiAnalysis
using Test

setprecision(BigFloat, 1024)

# Check that chud() is calculating pi accurately to 100 decimal places
# compare the result of chud() to that of Julia's pi

p1 = BigFloat(pi)
p2 = chud()
diff = abs(p1-p2)

@test diff < 10^(-100)

@show numDig()
