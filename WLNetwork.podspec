Pod::Spec.new do |s|
  s.name            = "WLNetwork"
  s.version         = "0.0.1"
  s.swift_version   = "5.0.0"
  s.summary         = "Network"
  s.description     = <<-DESC
                      Network
                      DESC

  s.homepage        = "https://github.com/wayne90040/WLNetwork.git"
  s.license         = "MIT"
  s.author          = { "WEILUN" => "wayne90040@gmail.com" }
  s.platform        = :ios, "11.0"
  s.source          = { :git => "https://github.com/wayne90040/WLNetwork.git", :tag => s.version }
  s.source_files    = "Sources/**/*.{h,m,swift}"
end
