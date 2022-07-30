#
# Be sure to run `pod lib lint QUIAlertController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'QUIAlertController'
  s.version          = '1.0'
  s.summary          = 'Custom alertController.It can be in place of UIAlertController'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Make your custom alert ui more convenient, support view and viewcontroller.It can be in place of UIAlertController
                       DESC

  s.homepage         = 'https://github.com/QDong415/QUIAlertController'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'd19890415' => '285275534@qq.com' }
  s.source           = { :git => 'https://github.com/QDong415/QUIAlertController.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'QUIAlertController/Classes/**/*'
  
  # s.resource_bundles = {
  #   'QUIAlertController' => ['QUIAlertController/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
