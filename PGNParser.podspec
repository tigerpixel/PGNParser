#
# Be sure to run `pod lib lint PGNParser.podspec' to ensure this is a
# valid spec before submitting.
#
# The podspec file for PGNParser. A functional parser for Portabe Game Notation.

Pod::Spec.new do |s|
  s.name             = 'PGNParser'
  s.version          = '0.4.0'
  s.summary          = 'A simple way to parse Portable Game Notation into Swift objects.'
  s.description      = <<-DESC
A simple way to parse Portable Game Notation into Swift objects. Easily parse game strings into Swift objects with just a single call. More work is required to fully suppourt the format. Pull requests for improvements are welcome.
                       DESC

  s.homepage         = 'https://github.com/tigerpixel/PGNParser'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Tigerpixel' => 'l.flynn2@live.co.uk' }
  s.source           = { :git => 'https://github.com/tigerpixel/PGNParser.git', :tag => s.version.to_s }

  s.requires_arc          = true
  s.ios.deployment_target = '8.0'
  s.watchos.deployment_target = '2.0'
  s.osx.deployment_target = '10.9'
  s.tvos.deployment_target = '9.0'
  s.swift_version = '5.1'

  s.source_files = 'Sources/**/*.swift'

  s.dependency 'Currier'
  s.dependency 'ParserCombinator'
end
