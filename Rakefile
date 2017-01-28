require 'rake'
require 'rspec/core/rake_task'
require 'puppet-lint/tasks/puppet-lint'
require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-syntax/tasks/puppet-syntax'

exclude_paths = [
  "pkg/**/*",
  "vendor/**/*",
  "spec/**/*",
  "modules/**/*",
]

PuppetSyntax.exclude_paths = exclude_paths

Rake::Task[:lint].clear
PuppetLint::RakeTask.new :lint do |config|
  config.ignore_paths = exclude_paths
  config.disable_checks = [ '80chars', 'autoloader_layout', 'class_inherits_from_params_class' ]
  config.fail_on_warnings = true
  config.with_context = true
  config.log_format = "%{path}:%{check}:%{KIND}:%{message}"
end

desc "Run lint and spec tests"
task :test => [
  :lint,
  :syntax,
  :spec_prep,
  :spec,
]

