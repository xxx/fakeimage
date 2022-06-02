# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = 'fakeimage'
  spec.version = 0.9
  spec.authors = ['Michael Dungan']
  spec.email = ['mpd@jesters-court.net']

  spec.summary = 'A placeholder image generator'
  spec.description = 'This gem providers a small server to allow linking to arbitrarily-sized placeholder images.'
  spec.homepage = 'https://github.com/xxx/fakeimage'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.7.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/xxx/fakeimage'
  spec.metadata['rubygems_mfa_required'] = 'true'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'puma'
  spec.add_runtime_dependency 'rmagick'
  spec.add_runtime_dependency 'sinatra'

  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-performance'
  spec.add_development_dependency 'rubocop-rake'
end
