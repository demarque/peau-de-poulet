#encoding: utf-8
class Game
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :cheater, type: Boolean, default: false
  field :score, type: Integer, default: 0

  before_save :filter_name

  def filter_name
    self.name.gsub!(/[àâ]/, 'a')
    self.name.gsub!(/[éèê]/, 'e')
    self.name.gsub!(/[ç]/, 'c')
    self.name.gsub!(/[ô]/, 'o')
    self.name.gsub!(/[ùû]/, 'u')
  end
end
