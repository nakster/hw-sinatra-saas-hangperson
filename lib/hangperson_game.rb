class HangpersonGame
  attr_accessor :word , :guesses , :wrong_guesses

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)
   # finally handle check and return true
   #when invalid
   if letter == nil || !(letter.class == String && letter =~ /^[A-z]$/i)
      raise ArgumentError
   end
   # is case insensitive
   letter.downcase!
   
   #checks for repeated letters
    if @guesses.include?(letter) || @wrong_guesses.include?(letter)
      return false
    end
    
    if @word.include? letter
      @guesses << letter
    else
     @wrong_guesses << letter
    end
    
    return true
  end

  def word_with_guesses
    result = ''
    @word.split('').each do |char|
      if @guesses.include? char
        result << char
      else
        result << '-'
      end
    end
    return result
  end
  
  def check_win_or_lose
    # if word_with_guesses.downcase == @word.downcase
    #   return :win
    # elsif @wrong_guesses.length >= 7
    #   return :lose
    # else
    #   return :play
    # end
    counter = 0
    return :lose if @wrong_guesses.length >= 7
      @word.each_char do |letter|
        counter += 1 if @guesses.include? letter
      end
      if counter == @word.length then :win
      else :play end
  end
  
  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
