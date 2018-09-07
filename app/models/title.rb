class Title < ActiveRecord::Base
  has_many :figures, :through :figure_titles
  has_many :landmarks, :through :figures
  has_many :figure_titles
end
