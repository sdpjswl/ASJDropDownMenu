Pod::Spec.new do |s|
  s.name         = 'ASJDropDownMenu'
  s.version      = '0.0.2'
  s.platform	 = :ios, '7.0'
  s.license      = { :type => 'MIT' }
  s.homepage     = 'https://github.com/sudeepjaiswal/ASJDropDownMenu'
  s.authors      = { 'Sudeep Jaiswal' => 'sudeepjaiswal87@gmail.com' }
  s.summary      = 'A drop down menu with embedded TableView to list options'
  s.source       = { :git => 'https://github.com/sudeepjaiswal/ASJDropDownMenu.git', :tag => '0.0.2' }
  s.source_files = 'ASJDropDownMenu/ASJDropDownMenu.{h,m}'
  s.requires_arc = true
end