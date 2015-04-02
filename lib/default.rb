# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.

include Nanoc::Helpers::Rendering
include Nanoc::Helpers::Blogging
include Nanoc::Helpers::HTMLEscape

require_relative 'helpers/sidebar'
include RoQua::Helpers::Sidebar
