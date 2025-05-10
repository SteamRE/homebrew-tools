cask "depotdownloader" do
  arch arm: "arm64", intel: "x64"

  version "3.4.0"
  sha256 arm:   "60e80c7c496f3f9a079cd3c62036b35d088c27bc0149baf38f009eb57a52f6a5",
         intel: "3214b689564d73e9342a8a4aef693de6ad3d293801b0f300a4466f60ec75befb"

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
