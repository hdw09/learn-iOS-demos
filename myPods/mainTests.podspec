#
# Be sure to run `pod lib lint mainTests.podspec' to ensure this is a
# valid spec before submitting.
#
#

Pod::Spec.new do |s|
s.name = 'mainTests'
s.version = '0.0.1'
s.license = 'MIT'
s.summary = 'David 主要测试库'
s.platform = :ios, '7.0'

s.homepage = 'http://git.sankuai.com/users/huangdawei/repos/network/browse'
s.authors = { 'huangdawei' => 'huangdawei@meituan.com' }
s.source = { :git => 'ssh://git@git.sankuai.com/~huangdawei/network.git', :tag => s.version.to_s }

s.source_files = 'mainTests/Classes/**/*'
s.frameworks = 'GLKit','OpenGLES'

s.resource_bundles = {
   'mainTestsBundle' => ['mainTests/Resources/**/*.{xib,storyboard,plist,json,jpg,png}']
}

s.prefix_header_contents = '#ifdef __OBJC__', '#import <MainTestMacro.h>', '#endif'
s.dependency 'ReactiveCocoa'
s.dependency 'Masonry'

end