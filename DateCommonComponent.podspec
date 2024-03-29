#
# Be sure to run `pod lib lint DateCommonComponent.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DateCommonComponent'
  s.version          = '1.0.3'
  s.summary          = '对日历控件进行了封装，支持酒店、飞机的日期选择'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://www.jianshu.com/u/7671114a2b6f'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '冯俊武' => '819134700@qq.com' }
  s.source           = { :git => 'https://github.com/fjw4905/DateCommonComponent.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  # s.ios.vendored_frameworks = 'DateCommonComponent/Classes/DateCommonComponent.framework'


  s.source_files = 'DateCommonComponent/Classes/**/*'
    
    
  # s.resource_bundles = {
  #   'DateCommonComponent' => ['DateCommonComponent/Assets/*.png']
  # }

  s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Masonry'
  # s.dependency 'MBProgressHUD', '0.9.2'
end
