# frozen_string_literal: true

require 'set'
class ApplicationController < ActionController::API
  BOARD_SIZE = 4

  def game
    alphabet = ('a'..'z').to_a
    alphabet.delete('u')
    board = (1..BOARD_SIZE).map {(1..BOARD_SIZE).map {alphabet.at(rand(alphabet.size))}}
    render json: board, status: :ok
  end


  def validate
    board = JSON.parse params[:board]
    word = params[:word]

    result = false
    visited = Set.new

    search = lambda {|i, j, index|
      return false if i < 0 or j < 0 or
          (i == BOARD_SIZE) or (j == BOARD_SIZE)
      return true if index == word.size
      return false if board[i][j] != word[index]

      visit_key = "#{i}-#{j}"
      return false if visited.include? visit_key

      visited.add visit_key
      any_match = (i - 1..i + 1).any? do |next_i|
        (j - 1..j + 1).any? do |next_j|
          search[next_i, next_j, index + 1]
        end
      end
      visited.delete visit_key
      any_match
    }

    try_search = lambda {
      (0..3).any? do |i|
        (0..3).any? do |j|
          search[i, j, 0]
        end
      end
    }

    result = try_search[] if word.size > 2

    render json: result, status: :ok
  end
end
