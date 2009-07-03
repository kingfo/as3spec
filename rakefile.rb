require 'sprout'

# Optionally load gems from a server other than rubyforge:
# set_sources 'http://gems.projectsprouts.org'
sprout 'as3'

require 'tasks/flashplayer_redgreen_task'

############################################
# Configure your Project Model
model = project_model :model do |m|
  m.project_name            = 'as3spec'
  m.language                = 'as3'
  m.background_color        = '#FFFFFF'
  m.width                   = 970
  m.height                  = 550
  m.test_output							= "#{m.bin_dir}/as3specRunner.swf"
  # m.use_fdb               = true
  # m.use_fcsh              = true
  # m.preprocessor          = 'cpp -D__DEBUG=false -P - - | tail -c +3'
  # m.preprocessed_path     = '.preprocessed'
  # m.src_dir               = 'src'
  # m.lib_dir               = 'lib'
  # m.swc_dir               = 'lib'
  # m.bin_dir               = 'bin'
  # m.test_dir              = 'test'
  # m.doc_dir               = 'doc'
  # m.asset_dir             = 'assets'
  # m.compiler_gem_name     = 'sprout-flex4sdk-tool'
  # m.compiler_gem_version  = '>= 4.0.0'
  # m.source_path           << "#{m.lib_dir}/as3spec"
  # m.libraries             << :corelib
end

desc 'Compile and debug the application'
debug :debug

desc 'Compile run the test harness'
flashplayer :test => model.test_output
mxmlc model.test_output => :model do |t|
	t.debug				 = true
	t.input				 = "#{model.src_dir}/as3specRunner.mxml"
	t.source_path << model.test_dir
  t.source_path << "#{model.lib_dir}/as3spec"
end

desc 'Compile the optimized deployment'
deploy :deploy

desc 'Create documentation'
document :doc

desc 'Compile a SWC file'
swc :swc

# set up the default rake task
task :default => :debug
