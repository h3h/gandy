require 'digest'
require 'fileutils'
require 'pathname'

module Gandy
  BUNDLED_HOOK_PATH = '../../../bin/gandy-post-checkout'
  GANDY_SRC_INCLUDE = "\nsource gandy-post-checkout\n"
  GANDY_SRC_MARK = "#--gandy-src"
  HOOK_PATH = '.git/hooks/post-checkout'

  class Installer
    def self.install!
      new.install!
    end

    def initialize(git_dir = nil, hook_file = nil, bundled_hook_file = nil)
      @bundled_hook_file  = bundled_hook_file || Pathname.new(File.expand_path(BUNDLED_HOOK_PATH, __FILE__))
      @git_dir            = git_dir           || Pathname.new('.git')
      @hook_file          = hook_file         || Pathname.new(HOOK_PATH)
    end

    def install!
      unless @git_dir.directory?
        Gandy.print "Can't find a .git/ directory. Run `rake gandy:install` from your Rails project root.", :error
        exit 1
      end

      if hook_file_exists?
        if hook_file_is_ours?
          if hook_file_needs_update?
            Gandy.print "Found an existing gandy hook. Updating..."
            write_hook_file!
          else
            Gandy.print "Gandy hook file already installed.", :success
          end
        else
          Gandy.print "Found an existing git post-checkout hook. Appending gandy hook..."
          append_hook_file!
          Gandy.print "Done.", :success
        end
      else
        Gandy.print "Installing gandy hook..."
        write_hook_file!
        Gandy.print "Done.", :success
      end
    end

    private

    def append_hook_file!
      if @hook_file.writable?
        FileUtils.copy(@bundled_hook_file, 'gandy-' + @hook_file)
        File.open(@hook_file, 'a') { |f| f.write(GANDY_SRC_INCLUDE) }
      else
        Gandy.print "Can't modify existing .git/hooks/post-checkout file.", :error
      end
    end

    def hook_file_exists?
      @hook_file.file?
    end

    def hook_file_is_ours?
      lines = @hook_file.readlines
      (lines[1] && lines[-1] &&
              lines[1].strip == GANDY_SRC_MARK && lines[-1].strip == GANDY_SRC_MARK)
    end

    def hook_file_needs_update?
      bundled_hook_hash = Digest::SHA256.file(@bundled_hook_file).hexdigest
      installed_hook_hash = Digest::SHA256.file(@hook_file).hexdigest
      installed_hook_hash != bundled_hook_hash
    end

    def write_hook_file!
      FileUtils.remove_entry(@hook_file)
      FileUtils.copy(@bundled_hook_file, @hook_file)
    end
  end
end
