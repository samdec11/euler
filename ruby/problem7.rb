# 10001st prime

# By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.

# What is the 10,001st prime number?

def run(num)
  counter = 1
  x = 2
  primes = []
  until counter > num
    if is_prime?(x)
      primes.shift
      primes << { counter => x }
      counter += 1
      x += 1
    else
      x += 1
    end
  end
  primes.shift
end

def is_prime?(num)
  case num
  when 1,0
    false
  when 2
    true
  else
    (2..num/2.0).none?{|x| num % x == 0}
  end
end

# 104743
