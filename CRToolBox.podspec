Pod::Spec.new do |s|

  s.name         = "CRToolBox"
  s.version      = "0.0.1"
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
  #这里路径必须正确，因为swift只有一个文件不需要s.public_header_files
  #s.public_header_files = "Classes/*.h"
  s.source_files = "Classes/*.swift"
  s.framework    = "UIKit","Foundation"
  s.requires_arc = true
end