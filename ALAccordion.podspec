Pod::Spec.new do |s|
  s.name             = "ALAccordion"
  s.version          = "0.1.0"
  s.summary          = "An Accordion controller for iOS"
  s.description      = <<-DESC
                       An Accordion controller for iOS, writtien in Swift.
                       DESC
  s.homepage         = "https://github.com/Alliants/ALAccordion"
  s.license          = 'MIT'
  s.authors          = { "Sam Williams" => "sam.williams@alliants.com", "Chris Miller" => "chris.miller@alliants.com" }
  s.source           = { :git => "https://github.com/Alliants/ALAccordion.git", :tag => s.version.to_s }
  s.social_media_url = "http://twitter.com/alliants"

  s.platform         = :ios, '8.0'
  s.requires_arc     = true

  s.source_files     = "ALAccordion/**/*.swift"

  s.framework        = "UIKit"
end
