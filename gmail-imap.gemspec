# -*- encoding: utf-8 -*-
require File.expand_path('../lib/gmail_imap', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Paul Rosania"]
  gem.email         = ["paul.rosania@gmail.com"]
  gem.description   = %q{Use with Net::IMAP to interact with Gmail's IMAP extensions.}
  gem.summary       = %q{A Gmail extension-aware accessory to Net::IMAP.}
  gem.homepage      = "https://github.com/paulrosania/gmail-imap"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "gmail-imap"
  gem.require_paths = ["lib"]
  gem.version       = GmailImap::VERSION

  gem.add_development_dependency "mocha", ['>= 0']
end
