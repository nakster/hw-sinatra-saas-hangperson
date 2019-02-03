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

  def guess(char)
  # # finally handle check and return true
  #   # is case insensitive
  # letter.downcase!
   
  # #when invalid
  # if letter == nil || !(letter.class == String && letter =~ /^[A-z]$/i)
  #     raise ArgumentError
  # end
 
  # #checks for repeated letters
  #   if @guesses.include?(letter) || @wrong_guesses.include?(letter)
  #     return false
  #   end
    
  #   if @word.include? letter and !@guesses.include? letter
  #     @guesses.concat letter
  #     return true
  #   else
  #   # @wrong_guesses << letter
  #   @wrong_guesses.concat letter
  #   return true
  #   end
    
  #   return true
    if char =~ /[[:alpha:]]/
        char.downcase!
        if @word.include? char and !@guesses.include? char
          @guesses.concat char
          return true
        elsif !@wrong_guesses.include? char and !@word.include? char
          @wrong_guesses.concat char
          return true
        else
          return false
        end
      else
        char = :invalid
        raise ArgumentError
    end
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
