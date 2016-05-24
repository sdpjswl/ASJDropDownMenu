Pod::Spec.new do |s|
  s.name         = 'ASJDropDownMenu'
  s.version      = '0.2'
  s.platform	   = :ios, '7.0'
  s.license      = { :type => 'MIT' }
  s.homepage     = 'https://github.com/sudeepjaiswal/ASJDropDownMenu'
  s.authors      = { 'Sudeep Jaiswal' => 'sudeepjaiswal87@gmail.com' }
  s.summary      = 'A drop down menu with embedded UITableView to list options'
  s.source       = { :git => 'https://github.com/sudeepjaiswal/ASJDropDownMenu.git', :tag => s.version }
  s.source_files = 'ASJDropDownMenu/*.{h,m}'
  s.requires_arc = true
end