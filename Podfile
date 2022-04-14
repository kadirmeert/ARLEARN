# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
source 'https://github.com/CocoaPods/Specs.git'
target 'ARLearn' do
  
  
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ARLearn
  pod 'lottie-ios'
  pod 'NVActivityIndicatorView'
  pod 'NVActivityIndicatorView/Extended'
  pod 'SCLAlertView'
  pod 'CocoaLumberjack'
  pod 'ARCL'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = 'YES'
        end
    end
end
