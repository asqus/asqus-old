module ApplicationHelper

end


class String
  def is_numeric?
    s = self
    s.to_i.to_s == s || s.to_f.to_s == s
  end
end

