module ApplicationHelper

  def color_picker_for(input_element)
    render "/shared/color_picker", :input_element => input_element.to_s
  end

end
