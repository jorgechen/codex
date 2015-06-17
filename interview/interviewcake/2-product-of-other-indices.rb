# def get_products_of_all_ints_except_at_index(a)
#   # First get product of everything
#   product_of_all = 1
#   a.each do |value|
#     product_of_all *= value
#   end

#   puts "product_of_all = #{product_of_all}"

#   result = a.map {|value| (product_of_all / value) }

#   result
# end



def get_products_of_all_ints_except_at_index(a)

  if a.length == 0
    raise 'Array is empty'
  end

  # Initialize a list of 0s
  products = (0...a.length).map {|x| 1}

  # Multiply everything to left of each index
  product = 1
  a.each_with_index do |value, index|

    # Skip the last
    next if index == a.length - 1

    product *= value

    products[index + 1] *= product
  end

  puts products.inspect

  # Multiply to the right of each index
  product = 1
  for index in (1...a.length).to_a.reverse #skips 0
    value = a[index]

    product *= value

    puts product

    products[index - 1] *= product
  end

  products

end


input = [1, 2, 0, 4, 5, 6]

puts input.inspect

out = get_products_of_all_ints_except_at_index(input)

puts out.inspect
