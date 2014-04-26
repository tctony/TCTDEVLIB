Pod::Spec.new do |s|

  s.name         = "TCTDEVLIB"
  s.version      = "1.0.3d"
  s.summary      = "TCTONY's iOS dev lib."

  s.homepage     = "https://github.com/tctony/TCTDEVLIB"

  s.license      = { :type => "MIT", :file => 'LICENSE' }
  s.author       = { "Tony Tang" => "tangchang21@gmail.com" }

  s.platform     = :ios

  s.source       = { :git => "https://github.com/tctony/TCTDEVLIB.git", :tag => "1.0.2" }

  s.source_files = "TCTDEVLIB/*.{h,m,mm}"

  s.libraries    = "c++"

  s.requires_arc = true

end
