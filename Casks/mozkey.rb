cask "mozkey" do
  version "2026.09.22.1"
  sha256 "82afcfb55b47b0faf4a5dd56ef62557412d2fa706a41b24c2081de873a94d4ba"

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
    Previous releases were tested for installation, input, upgrade and reinstall
    on Apple Silicon. See each release's notes for version-specific validation.
  EOS
end
