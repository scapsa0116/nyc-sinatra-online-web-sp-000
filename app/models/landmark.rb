class Landmark < ActiveRecord::Base
  belongs_to :figure
  has_many :landmarks
  has_many :figure_titles 
  has_many :figures, through: :figure_titles
end
