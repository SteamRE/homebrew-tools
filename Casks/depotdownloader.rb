cask "depotdownloader" do
  arch arm: "arm64", intel: "x64"

  version "2.7.4"
  sha256 arm:   "9d9614c7081beb502f0af69d61c179f6c8f781495b8b6b5046c0f743b59bb284",
         intel: "69c8e50c956adad17356880722f1ff6c04e917b859879a248a4cf346f6a58775"

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
