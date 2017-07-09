class Post < ApplicationRecord
	has_attachment  :thumb, thumb: [:jpg, :png, :gif]
	has_attachment  :hero, hero: [:jpg, :png, :gif]
end
