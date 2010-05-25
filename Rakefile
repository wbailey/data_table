require 'rubygems'
require 'spec'
require 'spec/rake/spectask'

Spec::Rake::SpecTask.new do |t|
  t.spec_opts = %w( -cfn )
  t.spec_files = FileList[ 'test/**/*_spec.rb' ]
end
