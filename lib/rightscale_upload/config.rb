require "buff/config/json"

module RightScaleUpload
  class Config < Buff::Config::JSON
    attribute 'fog', type: Hash
    attribute 'container', type: String
  end
end
