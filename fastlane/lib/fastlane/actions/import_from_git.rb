module Fastlane
  module Actions
    class ImportFromGitAction < Action
      def self.run(params)
        # this is implemented in the fast_file.rb
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Import another Fastfile from a remote git repository to use its lanes"
      end

      def self.details
        "This is useful if you have shared lanes across multiple apps and you want to store the Fastfile in a remote git repository."
      end

      def self.available_options
        [
          # Because the `run` method is actually implemented in `fast_file.rb`,
          # and because magic, some of the parameters on `ConfigItem`s (e.g.
          # `conflicting_options`, `verify_block`) are completely ignored.
          FastlaneCore::ConfigItem.new(key: :url,
                                       description: "The URL of the repository to import the Fastfile from",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :branch,
                                       description: "The branch or tag to check-out on the repository",
                                       default_value: 'HEAD',
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :dependencies,
                                      description: "The array of additional Fastfiles in the repository",
                                      default_value: [],
                                      optional: true),
          FastlaneCore::ConfigItem.new(key: :path,
                                       description: "The path of the Fastfile in the repository",
                                       default_value: 'fastlane/Fastfile',
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :version,
                                       description: "The version to checkout on the repository. Optimistic match operator or multiple conditions can be used to select the latest version within constraints",
                                       type: Array,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :cache_path,
                                       description: "The path to a directory where the repository should be cloned into. Defaults to `nil`, which causes the repository to be cloned on every call, to a temporary directory",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :git_basic_authorization,
                                       description: "Use a basic authorization header to access the git repo (e.g.: access via HTTPS, GitHub Actions, etc), usually a string in Base64",
                                       optional: true)
        ]
      end

      def self.authors
        ["fabiomassimo", "KrauseFx", "Liquidsoul"]
      end

      def self.is_supported?(platform)
        true
      end

      def self.example_code
        [
          'import_from_git(
            url: "git@github.com:fastlane/fastlane.git", # The URL of the repository to import the Fastfile from.
            branch: "HEAD", # The branch to checkout on the repository.
            path: "fastlane/Fastfile", # The path of the Fastfile in the repository.
            version: "~> 1.0.0" # The version to checkout on the repository. Optimistic match operator can be used to select the latest version within constraints.
          )',
          'import_from_git(
            url: "git@github.com:fastlane/fastlane.git", # The URL of the repository to import the Fastfile from.
            branch: "HEAD", # The branch to checkout on the repository.
            path: "fastlane/Fastfile", # The path of the Fastfile in the repository.
            version: [">= 1.1.0", "< 2.0.0"], # The version to checkout on the repository. Multiple conditions can be used to select the latest version within constraints.
            cache_path: "~/.cache/fastlane/imported" # A directory in which the repository will be added, which means that it will not be cloned again on subsequent calls.
            git_basic_authorization: "<YOUR BASE64 KEY>"
          )'
        ]
      end

      def self.category
        :misc
      end
    end
  end
end
