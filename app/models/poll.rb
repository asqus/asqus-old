class Poll < ActiveRecord::Base
  belongs_to :creator, :class_name => "User"
  
  def self.all_with_map_coords
    results = Poll.all  
    results.each_with_index { |poll, i|
      case i
        when 0
          x = 79
          y = 87
        when 1
          x = 50
          y = 50
        when 2
          x = 70
          y = 50
        when 3
          x = 90
          y = 50
        else
          x = 10 + i*5
          y = 40 + i*3
        end
      i = 5 if i > 5
      poll['map_x_coord'] = x
      poll['map_y_coord'] = y
    }
  end
  
end
