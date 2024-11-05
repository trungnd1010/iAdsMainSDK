#
# Be sure to run `pod lib lint iAdsMainSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'iAdsMainSDK'
  s.version          = '1.1.0'
  s.summary          = 'A short description of iAdsMainSDK.'
  
  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  
  s.description      = <<-DESC
  TODO: Add long description of the pod here.
  DESC
  
  s.homepage         = 'https://github.com/trungnd1010/iAdsMainSDK'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Trung Nguyen' => 'trungnd@ikameglobal.com' }
  s.source           = { :git => 'https://github.com/trungnd1010/iAdsMainSDK', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  
  s.ios.deployment_target = '14.0'
  s.static_framework = true
  
  s.source_files = 'iAdsMainSDK/Classes/**/*'
  
  s.default_subspecs = ['Core']
  
  s.subspec 'Core' do |core|
    core.dependency 'iAdsSDK'
    core.dependency 'GoogleUserMessagingPlatform'
  end
  
  # Subspec for Ads functionality
  s.subspec 'AdsAdmob' do |adsAdmob|
    adsAdmob.dependency 'iAdsAdmobSDK'
  end
  
  # Subspec for Analytics functionality
  s.subspec 'AdsMax' do |adsMax|
    adsMax.dependency 'iAdsMaxSDK'
  end
end

