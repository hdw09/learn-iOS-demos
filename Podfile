# Uncomment this line to define a global platform for your project
# platform :ios, '7.0'
use_frameworks!

target 'mainProject' do

  pod 'Mantle', '~> 2.0.7'

  pod 'Masonry', '1.0.2'

  pod 'ReactiveCocoa', :podspec => 'https://gist.githubusercontent.com/andrewschreiber/4fd444c08e8c8e876f06bb3a8ae45f2e/raw/72798f6fd81a124b0eaac52c6484725fbe9f5330/ReactiveCocoa.podspec.json' 

  pod 'MMPopupView'

  pod 'mainTests', :path => './myPods/'

  pod 'OpenCV', '3.1.0.1'

end

target 'widgetT' do
    
    pod 'Masonry', '1.0.2'
    
    pod 'ReactiveCocoa', :podspec => 'https://gist.githubusercontent.com/andrewschreiber/4fd444c08e8c8e876f06bb3a8ae45f2e/raw/72798f6fd81a124b0eaac52c6484725fbe9f5330/ReactiveCocoa.podspec.json'
    
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    if "#{target.name}" == "ReactiveCocoa"
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '2.3'
      end
    end
  end
end



