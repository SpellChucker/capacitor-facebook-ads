
  Pod::Spec.new do |s|
    s.name = 'CapacitorFacebookAds'
    s.version = '0.0.1'
    s.summary = 'Implement facebook ads as well as audience network'
    s.license = 'MIT'
    s.homepage = 'https://github.com/SpellChucker/capacitor-facebook-ads'
    s.author = 'Todd Vrba'
    s.source = { :git => 'https://github.com/SpellChucker/capacitor-facebook-ads', :tag => s.version.to_s }
    s.source_files = 'ios/Plugin/**/*.{swift,h,m,c,cc,mm,cpp}'
    s.ios.deployment_target  = '11.0'
    s.dependency 'Capacitor'
    s.dependency 'FBAudienceNetwork'
  end