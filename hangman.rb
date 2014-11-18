
# Checks to see if letter appears in word
# Returns the positions in word where the letter appears
def check_letter(word, letter)
  word_check = word.split ('')
  count = 0
  never_matched = true
  positions = []
  word_check.each do |correct_letter|
    if letter == correct_letter
      positions.push(count)
      never_matched = false
    end
    count = count + 1
  end

  return positions
end

#Checks if letter is in the array.
# If the letter does exist in the array, it returns true
# Otherwise, it returns false
def letter_exists_in_array(letter, array)
  letter_found = false
  array.each do |array_letter|
    if letter == array_letter
      letter_found = true
    end
  end
  return letter_found
end

# Displays the correctly guessed letters and also blanks for the letters that need to be guessed
def display_result(word_played, guessed_letters)
  letters = word_played.split('')
  letters.each do |letter|
    if letter_exists_in_array(letter, guessed_letters)
      print letter + ' '
    else
      print '_ '
    end
  end
  puts ' '
end

# Outputs a message saying the positions where the letter was found
def display_position_msg(positions)
  if positions.length > 0
    print 'Great job, your letter is at positions: '
    positions.each do |current_position|
      print (current_position + 1).to_s
      print ' '
    end
  end
  puts ' '
end

# Returns whether the user has correctly guessed every letter in word
def guessed_entire_word(word, guessed_letters)
  word_array = word.split('')

  word_array.each do |letter_in_word|
    did_guess_letter = false
    guessed_letters.each do |letter|
      if letter_in_word == letter
        did_guess_letter = true
      end
    end
    if did_guess_letter == false
      return false
    end
  end

  return true
end

# Draws parts of the hangman depending on parts (which is how many times the user has guessed incorrectly)
def draw_man(parts)
  if parts == 0
    puts '____________'
    puts '|'
    puts '|'
    puts '|'
    puts '|'
    puts '|'
    puts '|'
    puts '-----------'
  end
  if parts == 1
    puts '____________'
    puts '|       |'
    puts '|       @'
    puts '|'
    puts '|'
    puts '|'
    puts '|'
    puts '-----------'
  end
  if parts == 2
    puts '____________'
    puts '|       |'
    puts '|       @'
    puts '|       |'
    puts '|'
    puts '|'
    puts '|'
    puts '-----------'
  end
  if parts == 3
    puts '____________'
    puts '|       |'
    puts '|       @'
    puts '|      /|'
    puts '|'
    puts '|'
    puts '|'
    puts '-----------'
  end
  if parts == 4
    puts '____________'
    puts '|       |'
    puts '|       @'
    puts '|      /|\\'
    puts '|'
    puts '|'
    puts '|'
    puts '-----------'
  end
  if parts == 5
    puts '____________'
    puts '|       |'
    puts '|       @'
    puts '|      /|\\'
    puts '|       |'
    puts '|'
    puts '|'
    puts '-----------'
  end
  if parts == 6
    puts '____________'
    puts '|       |'
    puts '|       @'
    puts '|      /|\\'
    puts '|       |'
    puts '|      / '
    puts '|'
    puts '-----------'
  end
  if parts == 7
    puts '____________'
    puts '|       |'
    puts '|       @'
    puts '|      /|\\'
    puts '|       |'
    puts '|      / \\'
    puts '|'
    puts '-----------'
  end
end

def get_word()
  easy_word_list = ['elephant', 'caterpillar', 'giraffe', 'penguin', 'horse', 'eagle']
  hard_word_list = ['electron', 'chemistry', 'sulfur', 'magnitude', 'isotope', 'cation']

  puts 'Press e for easy, or any other character for hard'
  option = gets.chomp
  if option == 'e'
    word_list = easy_word_list
  else
    word_list = hard_word_list
  end
  return word_list[rand(1..word_list.length)]
end

# start of program

draw_man(0)

played_word = get_word()

wrong_guesses = 0
letters_guessed = []

done = false
while done == false
  puts 'Press 1 to guess a letter!'
  puts 'Press 2 to guess the word!'
  option = gets.chomp
  if option == '1'
    puts 'Guess a letter!'
    letter_guess = gets.chomp.downcase
    letters_guessed.push(letter_guess)

    positions = check_letter(played_word, letter_guess)
    if positions.length == 0 # no match, incorrect answer
      wrong_guesses = wrong_guesses + 1
      draw_man(wrong_guesses)
    end

    display_result(played_word, letters_guessed)
    display_position_msg(positions)

    done = guessed_entire_word(played_word, letters_guessed)
    if done == true
      puts 'You guessed the word!'
      puts 'Thanks for playing!'
    end
    if wrong_guesses >= 7
      done = true
      puts 'The correct word was: ' + played_word
      puts 'Sorry, better luck next time!'
    end
  elsif option == '2'
    puts 'Guess the word!'
    word_guess = gets.chomp.downcase
    if word_guess == played_word
      puts 'You guessed the word!'
      puts 'Thanks for playing!!'
      done = true
    else
      puts 'Sorry, that is not the word!'
    end
  else
    puts 'Please choose a valid option.'
  end
  puts 'Letters guessed: ' + letters_guessed.to_s
end