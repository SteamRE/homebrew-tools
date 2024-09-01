cask "depotdownloader" do
  arch arm: "arm64", intel: "x64"

  version "2.7.1"
  sha256 arm:   "65dc5cec48f7b1cce37d5d336318004f2a2a303276b26bc33ea492d558bc05d1",
         intel: "a5c345e3c10284a3083655cea7f7b038ee96d683feeb13be57e30a7e24266400"

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
