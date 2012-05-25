class Poll < ActiveRecord::Base
  belongs_to :creator, :class_name => "User"
  
  def self.all_with_map_information
    #Poll.find_by_sql('SELECT polls.title, users.first_name, reps.created_at FROM polls JOIN users ON users.id = polls.creator_id JOIN reps ON reps.user_id = users.id')
    results = Poll.all  
    results.each_with_index { |poll, i|
      case i
        when 0
          x = 79
          y = 87.5
          creator_info = {
            'type' => 'user',
            'name' => 'Jake Schwartz',
            'title' => 'Michigan Governor'
          }
        when 1
          x = 57.5
          y = 74
          creator_info = {
            'type' => 'rep',
            'name' => 'Gov. Rick Snyder',
            'title' => 'Michigan Governor'
          }
        when 2
          x = 92
          y = 67
          creator_info = {
            'type' => 'rep',
            'name' => 'Rep. Justin Amash',
            'title' => 'Michigan state representative'
          }
        when 3
          x = 90
          y = 50
          creator_info = {
            'type' => 'user',
            'name' => 'Adam Williams'
          }
        else
          x = 10 + i*5
          y = 40 + i*3
          creator_info = {
            'type' => 'user',
            'name' => 'Brad Chick'
          }
        end
      i = 5 if i > 5
      poll['map_x_coord'] = x
      poll['map_y_coord'] = y
      poll['creator_info'] = creator_info
    }
  end
  
end
