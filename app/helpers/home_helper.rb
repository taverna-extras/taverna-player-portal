module HomeHelper

  def navbar_link(title, url, controller, options = {})
    li_options = {}

    if controller_name == controller
      li_options[:class] = 'active'
    end

    content_tag :li, li_options do
      link_to title, url, options
    end
  end

end
