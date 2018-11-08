alphabet = ("a".."z").to_a
vowels = %w(a e i o u y)

vowels_hash = vowels.map { |vowel| [vowel, alphabet.index(vowel)] }.to_h

puts vowels_hash
