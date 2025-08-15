# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'World2One' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for World2One

pod 'SDWebImage'
pod 'JVFloatLabeledTextField'
pod 'Alamofire'
pod 'KMPlaceholderTextView', '~> 1.4.0'
pod 'Kingfisher', '~> 7.0'
  pod 'Firebase/Core'
  pod 'Firebase/Analytics'
  pod 'Firebase/Auth'
  pod 'Firebase/Firestore'
  pod 'Firebase/Database'
  pod 'Firebase/Messaging'
  pod 'Firebase/Storage'
  pod 'Firebase/Crashlytics'
  pod 'Firebase/RemoteConfig'

  target 'World2OneTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'World2OneUITests' do
    # Pods for testing
  end



post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64'
  end
end
end
