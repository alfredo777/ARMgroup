class SharedFile < ActiveRecord::Base
  belongs_to :fileable, polimorfic: true
  
end
