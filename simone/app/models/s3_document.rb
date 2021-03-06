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
class S3Document < Document

  # Default bucket name and default prefix are used only at initial storage.
  # The bucket at retrieval is determined from the persisted uri.
  DEFAULT_BUCKET_NAME = DotProperties.fetch('simone.default_s3_bucket_name')
  DEFAULT_PREFIX_BASE = "simone/documents"

  def self.s3
    @@s3 ||= AWS::S3.new
  end

  def self.default_expiration
    -> { 1.hour.from_now }.call
  end

  def read_link
    #default expiry time from S3 is one hour
    @read_link ||= s3_object.url_for(:read)
  end

  def file_saved?
    #this will actually make a call and see if an object exists at the key
    s3_object.exists?
  end

  private

  #URI for s3 objects in the format eg:
  # bucket.name.with.dots/simone/documents/<document_id>
  def set_uri
    self.uri ||= "#{DEFAULT_BUCKET_NAME}/#{DEFAULT_PREFIX_BASE}/#{document_id}/#{name}#{file_extension}"
  end

  def bucket_name
    @bucket_name ||= uri.split('/',2)[0]
  end

  #eg "simone/documents/<document_id>"
  def full_key
    @full_key ||= uri.split('/',2)[1]
  end

  def bucket
    @bucket ||= self.class.s3.buckets[bucket_name]
  end

  #can instantiate a ruby <AWS::S3::S3Object> without the file existing on S3 yet
  def s3_object
    @s3_object ||= bucket.objects[full_key]
  end

  def put!
    s3_object.write(file)
  end

end
