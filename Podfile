source 'https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git'
platform :ios, '10.0'
inhibit_all_warnings!   #关闭Pod工程的所有⚠️

def common_pods
    pod 'Kingfisher',         '~> 5.15.7'# 喵神的杰作
    pod 'SKPhotoBrowser',     '~> 6.1.0' # 图片预览
    pod 'ZLPhotoBrowser',     '~> 4.0.9' # 选择照片
    pod 'EmptyDataSet-Swift', '~> 5.0.0' # 空白数据页
    pod 'SwifterSwift',       '~> 5.2.0' # Swifter懒人代码
    pod 'Presentr',           '~> 1.9'   # 优雅的present
    pod 'BottomPopup',        '~> 0.6.0' # 优雅的底部popup
    pod 'SwiftyJSON',         '~> 4.3.0' # JSON解析工具
    pod 'SwiftDate',          '~> 6.3.0' # 日期管理
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
