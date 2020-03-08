#
# Be sure to run `pod lib lint JewFeatures.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JewFeatures'
  s.version          = '0.0.3'
  s.summary          = 'A short description of JewFeatures.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/joaoGMPereira/JewFeatures'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'joaoGMPereira' => 'joao.perei@itau-unibanco.com.br' }
  s.source           = { :git => 'https://github.com/joaoGMPereira/JewFeatures.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'

  s.source_files = 'JewFeatures/Classes/**/*'
  
  s.resource_bundles = {
      'JewFeatures' => ['JewFeatures/Assets/*.json', 'JewFeatures/Assets/*']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
   s.dependency 'SwiftKeychainWrapper'
   s.dependency 'lottie-ios'
   s.dependency 'Alamofire'
   s.dependency 'SkeletonView'
   s.dependency 'PodAsset'
   s.dependency 'CollectionKit'
   s.dependency 'SwiftyRSA'
   s.dependency 'CryptoSwift'
end
