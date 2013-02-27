# coding: utf-8
# Load the rails application
require File.expand_path('../application', __FILE__)


# Initialize the rails application
Medical::Application.initialize!

gem 'ts-delayed-delta', '1.1.2',
  :require => 'thinking_sphinx/deltas/delayed_delta'


