lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "slide/selector/core/version"

Gem::Specification.new do |spec|
  spec.name          = "slide-selector"
  spec.version       = Slide::Selector::VERSION
  spec.authors       = ["Touqeer-tqr"]
  spec.email         = ["tqr093@gmail.com"]

  spec.summary       = %q{custom input tag with range-slider & text-field type selectors}
  spec.description   = %q{Custom form field_tag of range-slider with text_field type selector. You can either choose from drop down or enter your own value and the slider will auto-adjust or you can use the slider to adjust values. This all through on form field f.slide_selector. Check out https://github.com/Touqeer-tqr/custom-form for sample app}
  spec.homepage      = "https://github.com/Touqeer-tqr/slide-selector"
  spec.license       = "MIT"

  spec.required_ruby_version = '>= 2.0.0'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", '~> 2.1'
  spec.add_development_dependency "rake", '~> 12.3'
end
