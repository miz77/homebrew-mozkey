cask "mozkey" do
  version "2026.09.08.1"
  sha256 "f9fd89f098c35af2d0c76d7d30bf2022de54921c268ea84fb741801c197f8c22"

  url "https://github.com/miz77/mozkey/releases/download/macos-v#{version}/MozKey-macOS-Universal-#{version}.zip"
  name "MozKey"
  desc "Japanese input method with daily dictionary and local Zenz correction"
  homepage "https://github.com/miz77/mozkey"

  depends_on macos: :monterey

  pkg "Mozc_Zenz_Universal_formal_dev.pkg"

  uninstall pkgutil: "^org\\.mozc\\.pkg\\.JapaneseInput$"

  caveats <<~EOS
    Unofficial personal distribution; no Developer ID signing or notarization.
    Replaces existing Mozc. Administrator authentication is required.
    Add Mozc in System Settings > Keyboard > Text Input after installation.
    Log out and back in if needed. Log out after uninstalling to end running processes.
    The upstream installer terminates your processes named llama-server as well
    as Mozc processes. User dictionary, learning and settings are not zapped.
    Installation, basic input, uninstall and reinstall were tested on Apple Silicon.
    Upgrading to a newer version has not yet been tested.
  EOS
end
