Pod::Spec.new do |s|

  s.name         = "TCTDEVLIB"
  s.version      = "1.0.4"
  s.summary      = "TCTONY's iOS dev lib."

  s.homepage     = "https://github.com/tctony/TCTDEVLIB"

  s.license      = { :type => "MIT", :file => 'LICENSE' }
  s.author       = { "Tony Tang" => "tangchang21@gmail.com" }

  s.platform     = :ios, "5.0"
  s.ios.deployment_target = "5.0"

  s.source       = { :git => "https://github.com/tctony/TCTDEVLIB.git", :tag => s.version.to_s }

  s.source_files = "TCTDEVLIB/*.{h,m,mm}"

  s.libraries    = "c++"

  s.requires_arc = true

end
