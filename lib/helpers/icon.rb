module IconHelper
  def icon(name)
    "<img class=\"icon\" src=\"/assets/images/icons/#{name}.png\" alt=\"#{name}\" />"
  end

  def tinyicon(name)
    "<img class=\"icon tiny\" src=\"/assets/images/icons/#{name}.png\" alt=\"#{name}\" />"
  end

end

include IconHelper
