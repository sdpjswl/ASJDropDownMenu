Pod::Spec.new do |s|
  s.name          = 'ASJDropDownMenu'
  s.version       = '1.2'
  s.platform      = :ios, '9.0'
  s.license       = { :type => 'MIT' }
  s.homepage      = 'https://github.com/sdpjswl/ASJDropDownMenu'
  s.authors       = { 'Sudeep' => 'sdpjswl1@gmail.com' }
  s.summary       = 'A drop down menu with embedded UITableView to list options'
  s.source        = { :git => 'https://github.com/sdpjswl/ASJDropDownMenu.git', :tag => s.version }
  s.source_files  = 'ASJDropDownMenu/*.{h,m}'
  s.requires_arc  = true
end