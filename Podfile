platform :ios, '9.0'
use_frameworks!

def install_pods
  pod 'FMDB'
end

target 'skillup_test_6_objc' do
  install_pods

  target 'skillup_test_6_objcTests' do
    inherit! :search_paths
    install_pods
  end
end
