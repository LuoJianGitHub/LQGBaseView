#
# Be sure to run `pod lib lint LQGBaseView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    # 名称
    s.name = 'LQGBaseView'
    # 版本
    s.version = '1.0.0'
    # 摘要
    s.summary = '基础视图'
    # 详细说明
    s.description = <<-DESC
    TODO: Add long description of the pod here.
    DESC
    # 维护者
    s.authors = { '罗建' => '362130376@qq.com' }
    # 许可证
    s.license = { :type => 'MIT', :file => 'LICENSE' }
    # 主页
    s.homepage = 'https://github.com/LuoJianGitHub'
    # 检索地址
    s.source = { :git => 'https://github.com/LuoJianGitHub/LQGBaseView.git', :tag => s.version.to_s }
    
    # 部署目标
    s.ios.deployment_target = '10.0'
    
    # 资源文件
    # 当前bundle
    # s.resources = []
    # 子bundle
    # s.resource_bundles = {
    
    # }
    
    # 源文件
    # s.source_files = 'LQGBaseView/Classes/**/*'
    
    s.subspec 'Protocol' do |ss|
        ss.source_files = 'LQGBaseView/Classes/Protocol/**/*'
    end
    
    s.subspec 'BaseView' do |ss|
        ss.source_files = 'LQGBaseView/Classes/BaseView/**/*'
        
        ss.dependency 'LQGBaseView/Protocol'
    end
    
    s.subspec 'BaseController' do |ss|
        ss.source_files = 'LQGBaseView/Classes/BaseController/**/*'
        
        ss.resources = ['LQGBaseView/Assets/LQGBaseView-BaseController.bundle']
        
        ss.dependency 'FDFullscreenPopGesture'
        ss.dependency 'WebViewJavascriptBridge', '~>6.0.3'
        ss.dependency 'LQGMacro'
        ss.dependency 'LQGCategory'
        ss.dependency 'LQGBaseView/Protocol'
    end
    
end
