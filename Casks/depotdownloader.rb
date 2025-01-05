cask "depotdownloader" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0"
  sha256 arm:   "1255a2810bdf30ec38bbbcf704a5e1d3c016bed0bcaf9d7548f70bf7ab44ad9d",
         intel: "a6a6f110e9900c77620d8634fe58aea7f227634a64d42bb93a4a1468d8579601"

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
