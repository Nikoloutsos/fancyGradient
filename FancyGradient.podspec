Pod::Spec.new do |spec|

  spec.name         = "FancyGradient"
  spec.version      = "1.0.2"
  spec.summary      = "Powerful animated gradientView made simple for iOS"
  spec.description  = <<-DESC
  FancyGradient makes it easy and simple to create animated or static gradient.
                   DESC

  spec.homepage     = "https://github.com/Nikoloutsos/fancyGradient"
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  spec.author             = { "Konstantinos Nikoloutsos" => "konstantinosnikοlouts@gmail.com" }
  spec.social_media_url   = "https://twitter.com/KonstantinosN17"

  spec.ios.deployment_target = "9.0"
  spec.swift_version = "5.0"
  spec.source       = { :git => "https://github.com/Nikoloutsos/fancyGradient.git", :tag => "#{spec.version}" }
  spec.source_files  = "Sources/FancyGradient/**/*.{h,m,swift}"
end
