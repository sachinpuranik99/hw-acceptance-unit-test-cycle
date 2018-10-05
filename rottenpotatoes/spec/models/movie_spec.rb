require 'spec_helper'
require 'rails_helper'
 describe "Movie" do
  describe 'searching same director' do
    it 'should find Movie with director' do
      expect(Movie).to receive(:where).with(:director => 'Tom')
      Movie.same_director("Tom")
    end
    it 'should not find Movie with different director' do
      expect(Movie).not_to receive(:where).with(:director => 'Jack')
      Movie.same_director("Tom")
    end
  end
end