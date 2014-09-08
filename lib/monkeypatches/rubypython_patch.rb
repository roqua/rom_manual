# -*- ruby encoding: utf-8 -*-
require 'rubypython'
fail "Please check rubypython monkey patch after upgrade" unless RubyPython::VERSION == '0.6.3'

class RubyPython::Interpreter
  # MONKEYPATCH: The upstream version does not check in the location where
  # CircleCI stores this file.
  def find_python_lib
    # By default, the library name will be something like
    # libpython2.6.so, but that won't always work.
    @libbase = "#{::FFI::Platform::LIBPREFIX}#{@version_name}"
    @libext = ::FFI::Platform::LIBSUFFIX
    @libname = "#{@libbase}.#{@libext}"

    # We may need to look in multiple locations for Python, so let's
    # build this as an array.
    @locations = [ File.join(@sys_prefix, "lib", @libname) ]

    if ::FFI::Platform.mac?
      # On the Mac, let's add a special case that has even a different
      # @libname. This may not be fully useful on future versions of OS
      # X, but it should work on 10.5 and 10.6. Even if it doesn't, the
      # next step will (/usr/lib/libpython<version>.dylib is a symlink
      # to the correct location).
      @locations << File.join(@sys_prefix, "Python")
      # Let's also look in the location that was originally set in this
      # library:
      File.join(@sys_prefix, "lib", "#{@realname}", "config", @libname)
    end

    if ::FFI::Platform.unix?
      # On Unixes, let's look in some standard alternative places, too.
      # Just in case. Some Unixes don't include a .so symlink when they
      # should, so let's look for the base cases of .so.1 and .so.1.0, too.
      [ @libname, "#{@libname}.1", "#{@libname}.1.0" ].each do |name|
        if ::FFI::Platform::ARCH != 'i386'
          @locations << File.join("/opt/local/lib64", name)
          @locations << File.join("/opt/lib64", name)
          @locations << File.join("/usr/local/lib64", name)
          @locations << File.join("/usr/lib64", name)

          # MONKEYPATCH: THIS LINE WAS ADDED
          @locations << File.join("/usr/lib/x86_64-linux-gnu", name)
        end
        @locations << File.join("/opt/local/lib", name)
        @locations << File.join("/opt/lib", name)
        @locations << File.join("/usr/local/lib", name)
        @locations << File.join("/usr/lib", name)
      end
    end

    if ::FFI::Platform.windows?
      # On Windows, the appropriate DLL is usually be found in
      # %SYSTEMROOT%\system or %SYSTEMROOT%\system32; as a fallback we'll
      # use C:\Windows\system{,32} as well as the install directory and the
      # install directory + libs.
      system_root = File.expand_path(ENV['SYSTEMROOT']).gsub(/\\/, '/')
      @locations << File.join(system_root, 'system', @libname)
      @locations << File.join(system_root, 'system32', @libname)
      @locations << File.join("C:/WINDOWS", "System", @libname)
      @locations << File.join("C:/WINDOWS", "System32", @libname)
      @locations << File.join(sys_prefix, @libname)
      @locations << File.join(sys_prefix, 'libs', @libname)
      @locations << File.join(system_root, "SysWOW64", @libname)
      @locations << File.join("C:/WINDOWS", "SysWOW64", @libname)
    end

    # Let's add alternative extensions; again, just in case.
    @locations.dup.each do |location|
      path = File.dirname(location)
      base = File.basename(location, ".#{@libext}")
      @locations << File.join(path, "#{base}.so")    # Standard Unix
      @locations << File.join(path, "#{base}.dylib") # Mac OS X
      @locations << File.join(path, "#{base}.dll")   # Windows
    end

    # Remove redundant locations
    @locations.uniq!

    library = nil

    @locations.each do |location|
      if File.exists? location
        library = location
        break
      end
    end

    library
  end
end
