using PiAnalysis
using Test

setprecision(BigFloat, 1024)

p1 = BigFloat(pi)
p2 = chud()
diff = abs(p1-p2)


@show diff
@show p2
@show numDig()
