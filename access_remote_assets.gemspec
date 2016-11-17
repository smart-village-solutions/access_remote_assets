Gem::Specification.new do |s|
  s.name               = "access_remote_assets"
  s.version            = "0.0.1"

  s.authors = ["Holger Frohloff"]
  s.date = %q{2016-11-17}
  s.description = %q{A simple rack middleware to temporarily redirect requests for missing assets.}
  s.email = %q{h.frohloff@ikusei.de}
  s.license = "MIT"
  s.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  s.homepage = %q{http://rubygems.org/gems/access_remote_assets}
  s.require_paths = ["lib"]
  s.summary = %q{access_remote_assets!}

  s.add_dependency             "rack", '>= 1.0', '< 3.0'
end

