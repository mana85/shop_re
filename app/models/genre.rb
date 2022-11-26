class Genre < ApplicationRecord
  has_many :products

  def self.search_for(content)
    genres = Genre.where("genre LIKE?", "#{content}")
    genres.inject(init = []){|result, genre| result + genre.products}
  end

end
