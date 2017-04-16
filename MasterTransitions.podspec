#
# Be sure to run `pod lib lint MasterTransitions.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MasterTransitions'
  s.version          = '0.1.0'
  s.summary          = 'Interactive transition library for tabbar, navigation and modal view controller. iOS only.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Interactive transition library for tabbar, navigation and modal view controller. By using a few lines of code you can get an elegant transition.
                       DESC

  s.homepage         = 'https://github.com/frgallah/MasterTransitions'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Mohammed Frgallah' => 'frgallah@outlook.com' }
  s.source           = { :git => 'https://github.com/frgallah/MasterTransitions.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'Sources/**/*.swift'
  
#s.resource_bundles = {
#     'Resources' => ['Resources/*']
#   }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
