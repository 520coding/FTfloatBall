#
# Be sure to run `pod lib lint FTfloatBall.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FTfloatBall'
  s.version          = '0.1.1'
  s.summary          = 'ios 悬浮球 floatBall'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
ios悬浮球，可拖动的悬浮球，自动吸附边缘，类似ios的辅助触控，floatBall，floatWindow，suspension
                       DESC

  s.homepage         = 'https://github.com/520coding/FTfloatBall'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '520coding' => '1085192695@qq.com,794751446@qq.com' }
  s.source           = { :git => 'https://github.com/520coding/FTfloatBall.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'FTfloatBall/Classes/**/*'
  
  # s.resource_bundles = {
  #   'FTfloatBall' => ['FTfloatBall/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
