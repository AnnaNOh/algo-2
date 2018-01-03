require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)

  # make a hash of all the charcters and the count
  hash = Hash.new(0)
  odd_chars = 0
  string.chars.each do |charc|
    hash[charc] += 1
    if hash[charc].odd?
      odd_chars += 1
    else
      odd_chars -= 1
    end
  end

  #palindromes can only have 1 odd # character 
  odd_chars <= 1

end
