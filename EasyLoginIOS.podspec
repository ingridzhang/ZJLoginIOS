#
# Be sure to run `pod lib lint EasyLoginIOS.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "EasyLoginIOS"
  s.version          = "0.1.1"
  s.summary          = "EasyLoginIOS for login and weixin login."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
EasyLoginIOS for login and weixin login.EasyLoginIOS for login and weixin login.
                       DESC

  s.homepage         = "http://zhangjing@123.57.37.167:8089"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "zhangjing" => "zhangjing@ezjie.cn" }
  # s.prefix_header_file = 'EasyLoginIOS-prefix.pch'
  s.source           = { :git => "http://123.57.37.167:8089/r/EasyLoginIOS.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.libraries = "stdc++", "sqlite3", "c++", "sqlite3.0", "z"
  s.vendored_libraries = "Pod/Classes/**/*.{a}"

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'EasyLoginIOS' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
    s.dependency 'AFNetworking'
    s.dependency 'SVProgressHUD'
    s.dependency 'ReactiveCocoa'
    s.dependency 'Aspects'
    s.dependency 'ChameleonFramework'
    s.dependency 'Masonry'
    s.dependency 'EZFramework'

end
