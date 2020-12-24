source 'https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git'
platform :ios, '10.0'
inhibit_all_warnings!   #关闭Pod工程的所有⚠️

def common_pods
    pod 'SwifterSwift',       '~> 5.2.0'  # Swifter懒人代码
    pod 'SwiftyJSON',         '~> 4.3.0'  # JSON解析工具
    pod 'SwiftDate',          '~> 6.3.0'  # 日期管理
    pod 'Kingfisher',         '~> 5.15.7' # 喵神之作 Image https://github.com/onevcat/Kingfisher
end

use_frameworks!

target 'CRToolBox' do
    common_pods
end

target 'CRToolBoxTests' do
	inherit! :search_paths
end

target 'CRToolBoxUITests' do
    inherit! :search_paths
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 10.0
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '10.0'
        end
      end
  end
end
