Pod::Spec.new do |s|

  s.name         = "CRToolBox"
  s.version      = "0.2.1"
  s.swift_version = '5.0'
  #主要标题
  s.summary      = "Swift开发者的工具箱"
  #详细描述
  s.description  = <<-DESC
       CR开发iOS项目中所用到的懒人用法分享给大家
                   DESC
  #仓库主页
  s.homepage     = "https://github.com/ChaoRenYuan/CRToolBox.git"
  s.license      = "MIT"
  s.author       = { "chaorenyuan" => "chaoren@crios.cn" }
  s.platform     = :ios,'10.0'
  #仓库地址
  s.source       = { :git => "https://github.com/ChaoRenYuan/CRToolBox.git", :tag => "#{s.version}" }
  #s.public_header_files = "CRToolBox/ExtensionTools/*.h"
  s.source_files = "CRToolBox/Basic", "CRToolBox/Extensions/Foundation", "CRToolBox/Extensions/UIKit"
  s.framework    = "UIKit","Foundation"
  s.requires_arc = true

 s.dependency 'Kingfisher',         '5.15.7'
 s.dependency 'SKPhotoBrowser',     '6.1.0'
 s.dependency 'ZLPhotoBrowser',     '4.0.9'
 s.dependency 'EmptyDataSet-Swift', '5.0.0'
 s.dependency 'SwifterSwift',       '5.2.0'
 s.dependency 'Presentr',           '1.9'
 s.dependency 'BottomPopup',        '0.6.0'
 s.dependency 'SwiftyJSON',         '4.3.0'
 s.dependency 'SwiftDate',          '6.3.0'
end