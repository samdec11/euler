# Special Pythagorean triplet

# A Pythagorean triplet is a set of three natural numbers, a < b < c, for which a^2 + b^2 = c^2
# For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.

# There exists exactly one Pythagorean triplet for which a + b + c = 1000.
# Find the product abc.

def run
  sum = 1000
  squares = []
  x = 1
  while x ** 2 < 1000
    x += 1
    squares << x ** 2
  end
end
