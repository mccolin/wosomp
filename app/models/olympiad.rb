# WOSOMP
# Olympiad -- A single olympics

class Olympiad < ActiveRecord::Base
  
  is_sluggable :name, :slug_column=>:slug
  
end
