require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    alphabet = Array("A".."Z")
    @letters = Array.new(10) { alphabet.sample }
  end

  def score
    @attempt = params[:attempt]
    @grid = params[:grid].gsub(" ", "")
    @score = the_score(@attempt)
    @message = message(@attempt)
  end


  def english_word(attempt)
    dictionary = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    dictionary_json = open(dictionary).read
    dictionary_hash = JSON.parse(dictionary_json)
  end

  def letter_from_grid(attempt)
    attempt.upcase.split("").all? do |letter|
      attempt.upcase.count(letter) <= @grid.count(letter)
    end
  end

  def the_score(attempt)
    if english_word(@attempt.upcase)["found"] == false
      score = 0
    elsif letter_from_grid(@attempt) == false
      score = 0
    else
      score = @attempt.upcase.length.to_i
    end
  end

 def message(attempt)
   if english_word(@attempt.upcase)["found"] == false
     message = "Not an English word"
   elsif letter_from_grid(@attempt) == false
     message = "Not in the grid"
   else
     message = "Well done, your score is #{@score}"
   end
 end
end
