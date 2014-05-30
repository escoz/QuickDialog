#
# Be sure to run `pod lib lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = "QuickDialog"
  s.version          = "2.0.0"
  s.summary          = "Quick and easy dialog screens for iOS."
  s.description      = <<-DESC
                       QuickDialog allows you to create HIG-compliant iOS forms for your apps without
                   	   having to directly deal with UITableViews, delegates and data sources. Fast
                   	   and efficient, you can create forms with multiple text fields, or with
                       thousands of items with no sweat!
                       DESC
  s.homepage         = "http://escoz.com/quickdialog"
  #s.screenshots      = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'Apache License, Version 2.0'
  s.author           = { "Eduardo Scoz" => "eduardoscoz@gmail.com" }
  s.source           = { :git => "https://github.com/escoz/QuickDialog.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/escoz'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.default_subspec = "Forms"

  s.subspec "Core" do |sp|
    sp.source_files = "Classes/Core/*.m"
    sp.public_header_files = "Classes/Core/*.h"
    sp.resources = ["Assets/Core/*"]
  end
  
  s.subspec "Forms" do |sp|
    sp.source_files = "Classes/Forms/*.m"
    sp.public_header_files = "Classes/Forms/*.h"
    sp.dependency "QuickDialog/Core"
  end
  
  s.subspec "Extras" do |sp|
    sp.source_files = "Classes/Extras/*.m"
    sp.public_header_files = "Classes/Extras/*.h"
    sp.dependency 'QuickDialog/Forms'
  end

  # s.public_header_files = 'Classes/**/*.h'
  # s.frameworks = 'SomeFramework', 'AnotherFramework'
end
