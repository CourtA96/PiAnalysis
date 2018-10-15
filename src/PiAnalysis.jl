module PiAnalysis

# using Plots

# Number of digits in pi = n
n = 100

setprecision(BigFloat,100000)

# Chudnovsky algorithm
export chud
function chud()

  pInvTemp = 0

  for i in 0:30

    pInvTemp = pInvTemp + (-1)^(i)*factorial(BigInt(6*i))*BigInt(545140134*i+13591409)/((factorial(BigInt(3*i))*((factorial(BigInt(i)))^3)*(BigInt(640320)^BigFloat(3*i+(3/2)))))

  end

  pInv = BigFloat(pInvTemp*12)

  p = BigFloat(1/pInv)

  return BigFloat(p)

end

end # module
