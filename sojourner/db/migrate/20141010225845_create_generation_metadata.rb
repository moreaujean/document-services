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
class CreateGenerationMetadata < ActiveRecord::Migration
  def change
    create_table :generation_metadata do |t|
      t.integer :template_id, null: false
      t.string :version_specified, null: false
      t.integer :version_used, null: false
      t.string :request_id, null: false
      t.string :created_by, null: false
      t.string :document_owner
      t.string :document_id, null: false

      t.timestamps
    end
  end
end
