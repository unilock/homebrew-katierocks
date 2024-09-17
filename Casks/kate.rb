cask "kate" do
  version :latest
  sha256 :no_check

  url do
    require "open-uri"
    base_url = "https://cdn.kde.org/ci-builds/utilities/kate/master/macos-arm64/"
    version = URI(base_url.to_s)
              .open
              .read
              .scan(/href="kate-(.*?)-macos-clang-arm64\.dmg"/i)
              .flatten
              .first # should only be one match
    file = "kate-#{version}-macos-clang-arm64.dmg"
    "#{base_url}#{file}"
  end
  name "Kate"
  desc "Get an Edge in Editing"
  homepage "https://kate-editor.org"

  app "kate.app", target: "kate.app"
  binary "#{appdir}/kate.app/Contents/MacOS/kate",
         target: "kate"

  uninstall quit: "org.kde.kate"

  zap trash: [
    "~/Library/Application Support/kate",
    "~/Library/Application Support/kateproject",
    "~/Library/Application Support/katexmltools",
    "~/Library/Preferences/kate",
    "~/Library/Preferences/katerc",
    "~/Library/Preferences/org.kde.UserFeedback.org.kde.kate.plist",
    "~/Library/Saved Application State/org.kde.Kate.savedState",
  ]
end
