  
platform :ios, '10.0'
inhibit_all_warnings!   #关闭Pod工程的所有⚠️

def common_pods
    pod 'ObjectMapper',  '3.3'
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
