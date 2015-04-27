# The Climate Corporation licenses this file to you under under the Apache
# License, Version 2.0 (the "License"); you may not use this file except in
# compliance with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# See the NOTICE file distributed with this work for additional information
# regarding copyright ownership.  Unless required by applicable law or agreed
# to in writing, software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
# or implied.  See the License for the specific language governing permissions
# and limitations under the License.
require 'rails_helper'

RSpec.describe NullLocation, :type => :model do
  #null is the default type for the storage_location
  #factory in test env. it's purpose is to not break tests.

  describe "file_saved?" do
    it "should not raise an error" do
      expect {subject.file_saved?}.not_to raise_error
    end
  end

  describe "put!" do
    it "should not raise an error" do
      expect {subject.send(:put!)}.not_to raise_error
    end
  end

  describe "open" do
    it "does not raise an error" do
      expect { subject.open }.not_to raise_error
    end
  end
end
