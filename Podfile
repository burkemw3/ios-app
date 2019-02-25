source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!
inhibit_all_warnings!

target 'wallabag' do
    pod 'Alamofire', '~> 4.7'
    pod 'AlamofireImage', '~> 3.4'
    pod 'AlamofireNetworkActivityIndicator', '~> 2.2'
    pod 'TUSafariActivity', '~> 1.0'
    pod 'SideMenu'
    pod 'RealmSwift'
    
    target 'wallabagUITests' do
        inherit! :search_paths
        pod 'Swifter', '~> 1.3.3'
    end

    target 'wallabagTests' do
        inherit! :search_paths
        pod 'Mockingjay'
    end
end

target 'bagit' do
    pod 'Alamofire', '~> 4.7'
end

target 'wallabagKit' do
    pod 'Alamofire', '~> 4.7'
end

post_install do |installer|
    myTargets = ['SideMenu', 'Swifter']

    installer.pods_project.targets.each do |target|
        if myTargets.include? target.name
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '4.2'
            end
        else
            target.build_configurations.each do |config|
              config.build_settings['SWIFT_VERSION'] = '4.1'
            end
        end
    end
end
