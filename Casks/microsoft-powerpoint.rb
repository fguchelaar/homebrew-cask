cask "microsoft-powerpoint" do
  version "16.40.20081000"
  sha256 "f84864b3f2deca700c16c8632626ebbedfa5c3f90f14a5e9239d4af6498a127c"

  # officecdn-microsoft-com.akamaized.net/pr/C1297A47-86C4-4C1F-97FA-950631F94777/MacAutoupdate/ was verified as official when first introduced to the cask
  url "https://officecdn-microsoft-com.akamaized.net/pr/C1297A47-86C4-4C1F-97FA-950631F94777/MacAutoupdate/Microsoft_PowerPoint_#{version}_Installer.pkg"
  appcast "https://docs.microsoft.com/en-us/officeupdates/update-history-office-for-mac"
  name "Microsoft PowerPoint"
  homepage "https://products.office.com/en-US/powerpoint"

  auto_updates true
  conflicts_with cask: "microsoft-office"
  depends_on cask: "microsoft-auto-update"
  depends_on macos: ">= :sierra"

  pkg "Microsoft_PowerPoint_#{version}_Installer.pkg",
      choices: [
        {
          "choiceIdentifier" => "com.microsoft.autoupdate", # Office16_all_autoupdate.pkg
          "choiceAttribute"  => "selected",
          "attributeSetting" => 0,
        },
      ]

  uninstall pkgutil:   [
    "com.microsoft.package.Microsoft_PowerPoint.app",
    "com.microsoft.pkg.licensing",
  ],
            launchctl: "com.microsoft.office.licensingV2.helper"

  zap trash: [
    "~/Library/Application Scripts/com.microsoft.Powerpoint",
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/com.microsoft.powerpoint.sfl*",
    "~/Library/Containers/com.microsoft.Powerpoint",
    "~/Library/Preferences/com.microsoft.Powerpoint.plist",
  ]
end
