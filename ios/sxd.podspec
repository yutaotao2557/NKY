#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint sxd.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'sxd'
  s.version          = '0.0.2'
  s.summary          = '硕欣达设备配网插件'
  s.description      = <<-DESC
硕欣达设备配网插件
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

  # framework文件路径
  s.vendored_frameworks = 'Framework/AECC_Setnet_SDK.framework'
  # a文件路径
  s.vendored_libraries = 'Framework/*.a'
  # bundle资源文件路径
  s.resource ='Framework/*.bundle'
  s.public_header_files = 'Classes/**/*.h'
end
