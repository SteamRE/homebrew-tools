cask "depotdownloader" do
  version "2.6.0"

  arch arm: "arm64", intel: "x64"

  sha256 arm:   "18c62c2c4911bf06f83a463bd151af6ad077f2becf907d02a23e6ed083f570e9",
          intel: "cecc92245e31bbe411bb3120d1ccdae1dcc0f4a186e2da42a6c14fe26f91871c"

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
