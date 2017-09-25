require "zip2tz/version"
require "json"

module Zip2Tz
  TZ_NAMES = %w(
    America/New_York
    America/Chicago
    America/Denver
    America/Los_Angeles
    America/Kentucky/Louisville
    America/Indiana/Indianapolis
    America/Detroit
    America/Boise
    America/Phoenix
    America/Anchorage
    Pacific/Honolulu
    America/Indiana/Knox
    America/Indiana/Winamac
    America/Indiana/Vevay
    America/Indiana/Marengo
    America/Indiana/Vincennes
    America/Indiana/Tell_City
    America/Indiana/Petersburg
    America/Menominee
    America/Shiprock
    America/Nome
    America/Juneau
    America/Kentucky/Monticello
    America/North_Dakota/Center
    America/Yakutat
  )

  MAP = JSON.parse(File.read('data/map.json'))

  def self.lookup(zip)
    zip = zip.to_s
    raise '5 digits required' if zip !~ /\A\d{5}/
    fetch(MAP, *zip.chars.first(5).map(&:to_i))
  end

  def self.fetch(ary, *idxn)
    return nil if ary.nil?
    return TZ_NAMES[ary] unless ary.is_a?(Array)
    i = idxn.shift
    fetch(ary[i], *idxn)
  end
end
