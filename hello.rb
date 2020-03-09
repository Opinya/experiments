require 'json'
require 'git_diff_parser'

puts 'hello!'
# puts ENV.inspect
path = ENV['GITHUB_EVENT_PATH']
data = JSON.parse(File.read(path))
diff = `git diff --unified=0 --no-color base_version pr_version`
p diff
#patches = GitDiffParser.parse(diff)
#p patches
#p `git branch --all`
