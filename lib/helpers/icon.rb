module IconHelper
  def icon(name)
    "<img class=\"icon\" src=\"/rom_manual/assets/images/icons/#{name}.png\" alt=\"#{name}\" />"
  end

  def tinyicon(name)
    "<img class=\"icon tiny\" src=\"/rom_manual/assets/images/icons/#{name}.png\" alt=\"#{name}\" />"
  end

end

include IconHelper
