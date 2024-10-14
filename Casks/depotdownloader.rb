cask "depotdownloader" do
  arch arm: "arm64", intel: "x64"

  version "2.7.3"
  sha256 arm:   "ca82efb4af7e1b60977acaec09b5e439a495f0689c21b37610f57d1efa32fbb9",
         intel: "4b7aa877a250d90001fef637038d651e0d8e462f82ae32d6ae2f8eeec2d4e16f"

  url "https://github.com/SteamRE/DepotDownloader/releases/download/DepotDownloader_#{version}/DepotDownloader-macos-#{arch}.zip"
  name "DepotDownloader"
  desc "Steam depot downloader utilizing the SteamKit2 library"
  homepage "https://github.com/SteamRE/DepotDownloader"

  livecheck do
    url :stable
    regex(/^DepotDownloader[ _](\d+(?:\.\d+)+)$/i)
    strategy :github_releases do |json, regex|
      json.map do |release|
        next if release["draft"] || release["prerelease"]

        match = release["tag_name"]&.match(regex)
        next if match.blank?

        match[1]
      end
    end
  end

  depends_on macos: ">= :monterey"

  binary "DepotDownloader", target: "depotdownloader"
end
