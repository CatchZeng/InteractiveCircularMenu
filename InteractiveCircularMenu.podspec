#
# Be sure to run `pod lib lint InteractiveCircularMenu.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'InteractiveCircularMenu'
  s.version          = '0.1.0'
  s.swift_version    = '4.2'
  s.summary          = 'Interactive circular menu'
  s.description      = 'Interactive, infinite, springback, customizable(color, width, speed, angles) circular menu.'
  s.homepage         = 'https://github.com/catchzeng/InteractiveCircularMenu'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'catchzeng' => '891793848@qq.com' }
  s.source           = { :git => 'https://github.com/catchzeng/InteractiveCircularMenu.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = 'InteractiveCircularMenu/Classes/**/*'
end


