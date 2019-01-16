require 'test_helper'
class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test "the truth" do
    assert true
  end

  test "get /game should generate board" do
    get '/game'
    board = JSON.parse(@response.body)
    assert_equal 4, board.size
    board.each {|row| assert_equal 4, row.size}
  end

  test "get board should return different boards" do
    get '/game'
    board1 = JSON.parse(@response.body)
    get '/game'
    board2 = JSON.parse(@response.body)
    assert_not_equal board1.flatten, board2.flatten
  end

  test 'validate returns false when word length too small' do
    post '/validate', params: {
        board: [
            %w[a b c d],
            %w[a b c d],
            %w[a b c d],
            %w[a b c d]],
        word: 'aa'}.to_json
    result = JSON.parse(@response.body)
    assert_equal false, result
  end

  test 'validate returns true when word is found' do
    post '/validate', params: {
        board: [
            %w[a b c d],
            %w[a b c d],
            %w[a b c d],
            %w[a b c d]],
        word: 'aaa'}.to_json
    result = JSON.parse(@response.body)
    assert_equal true, result
  end

  test 'validate returns false when cell is visited' do
    post '/validate', params: {
        board: [
            %w[a b c d],
            %w[a b c d],
            %w[a b c d],
            %w[a b c d]],
        word: 'aaaaa'}.to_json
    result = JSON.parse(@response.body)
    assert_equal false, result
  end
end