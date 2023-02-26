# Uncomment the next line to define a global platform for your project
platform :ios, '15.0'
inhibit_all_warnings!
workspace 'Pokemon TGC.xcworkspace'
use_frameworks! :linkage => :static
source 'https://github.com/CocoaPods/Specs.git'
install! 'cocoapods', generate_multiple_pod_projects: true, incremental_installation: true

def networking_pods
  pod 'Alamofire', '~> 5.6'
  pod 'AlamofireImage', '~> 4.2'
end

def pokemon_tgc_pods
  pod 'RxSwift', '~> 6.5'
  pod 'RxCocoa', '~> 6.5'
end

target 'Pokemon TGC' do
  pokemon_tgc_pods
  
  target 'Pokemon TGCTests' do
    pod 'Quick', '5.0.1'
    pod 'Nimble', '10.0.0'
  end

  target 'Pokemon TGCUITests' do
    # Pods for testing
  end
end

target 'NetworkModule' do
  project 'Module/NetworkModule/NetworkModule.xcodeproj'
  networking_pods
end