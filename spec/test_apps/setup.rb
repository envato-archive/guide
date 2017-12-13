module TestApps
  class Setup
    def self.call(*args)
      new(*args).call
    end

    def initialize(rails_version)
      @rails_version = rails_version
    end

    def call
      return if completed?
      abort(generate_app_instructions) unless app_exists?
      add_symlinks
      puts "Done!"
    end

    private

    attr_reader :rails_version

    def completed?
      app_exists? && symlinks_exist?
    end

    def app_exists?
      Dir.exists?(root)
    end

    def root
      File.join(test_apps_root, "rails-#{rails_version}")
    end

    def test_apps_root
      File.expand_path('..', __FILE__)
    end

    def symlinks_exist?
      symlink_sources.all? do |source|
        File.exist?(symlink_dest(source))
      end
    end

    def symlink_sources
      Dir[File.join(shared_root, '**/*')].select(&File.method(:file?))
    end

    def symlink_dest(source)
      source.sub(shared_root, root)
    end

    def shared_root
      File.join(test_apps_root, 'shared')
    end

    def generate_app_instructions
      <<~EOS

        A test app running rails v#{rails_version} needs to be added.

        This can be achieved by running:

            cd /tmp \\
            && gem install rails -v#{rails_version} \\
            && rails _#{rails_version}_ new test_app \\
              --database=sqlite3 \\
              --skip-yarn \\
              --skip-gemfile \\
              --skip-git \\
              --skip-keeps \\
              --skip-action-mailer \\
              --skip-puma \\
              --skip-action-cable \\
              --skip-spring \\
              --skip-listen \\
              --skip-coffee \\
              --skip-turbolinks \\
              --skip-test \\
              --skip-system-test \\
              --skip-bundle \\
            && mv test_app #{root} \\
            && cd #{gem_root} \\
            && bundle exec rake setup_test_app[#{rails_version}]

      EOS
    end

    def gem_root
      File.expand_path('../../..', __FILE__)
    end

    def add_symlinks
      [
        'app',
        'config/database.yml',
        'config/initializers/i18n.rb',
      ].each do |path|
        dest = File.join(root, path)
        target_dir = File.dirname(dest)
        FileUtils.mkdir_p(target_dir)
        FileUtils.cd(target_dir)
        relative_source = ['../' * path.count('/'), '../shared/', path].join
        FileUtils.ln_sf relative_source, dest
      end
    end
  end
end
