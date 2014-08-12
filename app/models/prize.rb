class Prize < ActiveRecord::Base
  belongs_to :goal

  validates_presence_of :name
end
