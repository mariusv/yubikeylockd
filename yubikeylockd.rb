class Yubikeylockd < Formula
  desc 'Simple daemon for locking and unlocking macOS with Yubikey.'
  homepage 'https://github.com/shtirlic/yubikeylockd'
  url 'https://github.com/shtirlic/yubikeylockd/archive/v1.1.zip'
  head 'https://github.com/shtirlic/yubikeylockd.git'
  sha256 '44ba63cb286c29fa653d2307f053162bb600a7138e6f6766d40144a504a376b7'

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    system 'make', 'yubikeylockd'
    # system  "install" # if this fails, try separate make/make install steps
    bin.install 'yubikeylockd'
  end

  plist_options startup: true

  def plist
    <<-PLIST
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{bin}/yubikeylockd</string>
        </array>
        <key>LaunchEvents</key>
        <dict>
          <key>com.apple.iokit.matching</key>
          <dict>
            <key>com.apple.device-attach</key>
            <dict>
                <key>idProduct</key>
                <string>*</string>
                <key>idVendor</key>
                <integer>4176</integer>
                <key>IOProviderClass</key>
                <string>IOUSBDevice</string>
                <key>IOMatchLaunchStream</key>
                <true/>
            </dict>
          </dict>
        </dict>
      </dict>
    </plist>
    PLIST
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test yubikeylockd`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system 'true'
  end
end
