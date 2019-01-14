Pod::Spec.new do |s|

  s.name         = "CRToolBox"
  s.version      = "0.1.0"
  s.swift_version = '4.0'
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
  s.source_files = "CRToolBox/ExtensionTools", "CRToolBox/MoreTools", "CRToolBox/ObjectMapperTools", "CRToolBox/CRImageBrowserTools"
  s.framework    = "UIKit","Foundation"
  s.requires_arc = true
  s.dependency 'ObjectMapper',      '3.3'
  s.dependency 'lottie-ios',        '2.5.2'
  s.dependency 'Kingfisher',        '4.9.0'
  s.dependency 'SKPhotoBrowser',    '6.0.0'
end