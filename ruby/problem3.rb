# Largest prime factor

# The prime factors of 13195 are 5, 7, 13 and 29.
# What is the largest prime factor of the number 600851475143?

def run(num)
  x = num / 2
  found = false
  while found == false
    if x == 1
      break
    elsif num % x == 0
      if is_prime?(x)
        found = true
      else
        x -= 1
      end
    else
      x -= 1
    end
  end
  x
end

def is_prime?(num)
  if num == 0
    false
  elsif num == 1 || num == 2
    true
  else
    (2..num/2).detect{|i| num % i == 0}.nil?
  end
end