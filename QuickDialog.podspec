Pod::Spec.new do |s|
  s.name     = 'QuickDialog'
  s.version  = '0.9.1'
  s.platform = :ios, '5.0'
  s.license  = 'Apache License, Version 2.0'
  s.summary  = 'Quick and easy dialog screens for iOS.'
  s.homepage = 'http://escoz.com/quickdialog'
  s.author   = { 'Eduardo Scoz' => 'contact@escoz.com' }
  s.source   = { :git => 'https://github.com/escoz/QuickDialog.git', :tag => "#{s.version}" }

  s.description  = 'QuickDialog allows you to create HIG-compliant iOS forms for your apps without ' \
                   'having to directly deal with UITableViews, delegates and data sources. Fast ' \
                   'and efficient, you can create forms with multiple text fields, or with ' \
                   'thousands of items with no sweat!'

  s.source_files = 'quickdialog', '*.{h,m}'
  s.exclude_files = 'quickdialog/NSStringMask.{h,m}'
  s.requires_arc = true

  s.subspec "Extras" do |sp|
    sp.source_files = 'extras', '*.{h,m}'
  end

  s.subspec "NSStringMask" do |sp|
    sp.source_files = 'quickdialog/NSStringMask.{h,m}'
	sp.requires_arc = false
  end

  s.prefix_header_contents = <<-EOS
#ifdef __OBJC__
    #import "QuickDialog.h"
#endif
EOS
end
