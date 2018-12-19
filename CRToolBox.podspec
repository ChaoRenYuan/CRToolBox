Pod::Spec.new do |s|

  s.name         = "CRToolBox"
  s.version      = "0.0.1"
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
  s.source_files = "CRToolBox/ExtensionTools/*.swift"
  s.framework    = "UIKit","Foundation"
  s.requires_arc = true
end