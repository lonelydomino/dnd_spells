require_relative 'lib/dnd_spells/version'

Gem::Specification.new do |spec|
  spec.name          = "dnd_spells"
  spec.version       = DndSpells::VERSION
  spec.authors       = ["Michael Martinez"]
  spec.email         = ["zeroeclipse@live.com"]
  spec.summary       = "Spells in Dungeons & Dragons."
  spec.description   = "Provides information for spells in Dungeons & Dragons."
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  #spec.metadata["allowed_push_host"] = "http://mygemserver.com"
  #spec.metadata["homepage_uri"] = spec.homepage
  #spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  #spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  
  spec.add_dependency "httparty"
  spec.add_dependency "tty-progressbar"
  spec.add_dependency "pry"
end
