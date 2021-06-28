platform :ios, '11.0'

inhibit_all_warnings!
use_frameworks!

def default_pods
  # Reactive
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxRelay'
  pod 'RxFlow'
  pod 'RxLocalizer'
  pod 'NSObject+Rx'
  pod 'RxGesture'
  pod 'RxSwiftExt'
  pod 'RxDataSources'
  # Storages
  pod 'KeychainAccess'
  # Firebase
  pod 'Firebase/Auth'
  pod 'Firebase/Crashlytics'
  # RxFirebase
  pod 'RxFirebase/Auth'
  # Utils
  pod 'FieryCrucible'
  # UI
  pod 'SPStorkController'
  pod 'IQKeyboardManagerSwift'
  pod 'Reusable'
end

workspace 'LoginExample'

target 'LoginExample' do
  default_pods
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
          config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
      end
  end
end
