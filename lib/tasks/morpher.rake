# encoding: utf-8

require File.expand_path('../../../config/environment', __FILE__)

namespace :morpher do
    desc ""
    task(:start => :environment) do
        morpher = MorpherConvey.new
        morpher.convey_start
    end
end