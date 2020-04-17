require "open-uri"
require "json"

class GamesController < ApplicationController

  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @letters = params[:letters].split
    @resultados = ""
    if validate_letters?
      if leitura_json?
        @resultados = "rolou!"
      else
        @resultados = "não existe a palavra"
      end
    else
      @resultados = "tentou roubar né safadinho"
    end
  end

private

  def validate_letters?
    @tentativa = params[:words].chars
    @tentativa.all? { |t| @tentativa.count(t) <= @letters.count(t) }
  end

  def leitura_json?
    response = open("https://wagon-dictionary.herokuapp.com/#{@tentativa.join}")
    json = JSON.parse(response.read)["found"]
  end
end

# response = open("https://wagon-dictionary.herokuapp.com/table")
  #   @tentativa.each do |letter|
  #     @score = 0
  #     if @letters.include?(letter)
  #       score += 10
  #     else
  #       score += 0
  #     end

  #     return score
  #   end
  # @score


