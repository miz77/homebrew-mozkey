cask "mozkey" do
  version "2026.09.06.1"
  sha256 "dde9f665be3f7d0632e21b9a8b82319aebc0178bd967e03848063f26c4d35b87"

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
    Log out and back in if needed. Switch to ABC before upgrading or uninstalling.
    The upstream installer terminates your processes named llama-server as well
    as Mozc processes. User dictionary, learning and settings are not zapped.
    GUI installation, upgrade and uninstall have not yet been tested.
  EOS
end
