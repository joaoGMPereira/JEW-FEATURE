#
# Be sure to run `pod lib lint JewFeatures.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'JewFeatures'
    s.version          = '1.0.0'
    s.summary          = 'A module with a handful of things, such as Connectors with Alamofire, UIComponents, Extensions and Loggers'
    
    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!
    
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
    DESC
    
    s.homepage         = 'https://github.com/joaoGMPereira/JEW-FEATURE'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Joao Gabriel de Medeiros Pereira' => 'gah.mp1@gmail.com' }
    s.source           = { :git => 'https://github.com/joaoGMPereira/JEW-FEATURE.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
    
    
    s.ios.deployment_target = '11.0'
    s.swift_version   = '5.0'
    
    s.resource_bundles = {
        'JewFeatures' => ['JewFeatures/Assets/*.json', 'JewFeatures/Assets/*']
    }
    
    s.default_subspec = "JEWKit"
    s.subspec "JEWKit" do |jewKit|
        jewKit.dependency "JewFeatures/ConnectionKit"
        jewKit.dependency "JewFeatures/UIKit"
        jewKit.dependency "JewFeatures/SessionKit"
    end
    
    
    s.subspec "CommonKit" do |commonKit|
        commonKit.source_files = "JewFeatures/Classes/CommonKit/**/*"
    end
    
    s.subspec "LoggerKit" do |loggerKit|
        loggerKit.source_files = "JewFeatures/Classes/LoggerKit/**/*"
    end
    
    s.subspec "SessionKit" do |sessionKit|
        sessionKit.source_files = "JewFeatures/Classes/SessionKit/**/*"
    end
    
    s.subspec "ConnectionKit" do |connectionKit|
        connectionKit.source_files = "JewFeatures/Classes/ConnectionKit/**/*"
        connectionKit.dependency 'SwiftKeychainWrapper'
        connectionKit.dependency 'Alamofire'
        connectionKit.dependency 'SwiftyRSA'
        connectionKit.dependency 'CryptoSwift'
        connectionKit.dependency "JewFeatures/LoggerKit"
        connectionKit.dependency "JewFeatures/CommonKit"
    end
    
    s.subspec "UIKit" do |uiKit|
        uiKit.source_files = "JewFeatures/Classes/UIKit/**/*"
        uiKit.dependency "Alamofire"
        uiKit.dependency 'lottie-ios'
        uiKit.dependency 'SkeletonView'
        uiKit.dependency 'PodAsset'
        uiKit.dependency 'CollectionKit'
        uiKit.dependency "JewFeatures/CommonKit"
    end
end
