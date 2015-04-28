Pod::Spec.new do |s|
  s.name             = "ALAccordion"
  s.version          = "0.1.1"
  s.summary          = "An accordion controller for iOS"
  s.description      = "An accordion style container view for iOS that manages a set of expandable/collapsable content sections."
  s.homepage         = "https://github.com/Alliants/ALAccordion"
  s.license          = 'MIT'
  s.authors          = { "Sam Williams" => "sam.williams@alliants.com", "Chris Miller" => "chris.miller@alliants.com" }
  s.source           = { :git => "https://github.com/Alliants/ALAccordion.git", :tag => "v#{s.version}" }
  s.social_media_url = "http://twitter.com/alliants"

  s.platform         = :ios, '8.0'
  s.requires_arc     = true

  s.source_files     = "ALAccordion/**/*.swift"
end
