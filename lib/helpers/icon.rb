module IconHelper
  def icon(name)
    "<img class=\"icon\" src=\"/rom_manual/assets/images/icons/#{name}.png\" />"
  end

  def tinyicon(name)
    "<img class=\"icon tiny\" src=\"/rom_manual/assets/images/icons/#{name}.png\" />"
  end

end

include IconHelper
