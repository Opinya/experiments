require 'json'

puts 'hello!'
# puts ENV.inspect
puts ENV['GITHUB_EVENT_PATH']
data = JSON.parse(ENV['GITHUB_EVENT_PATH'])
p data
diff = `git diff --unified=0 --no-color HEAD~2`
patches = GitDiffParser.parse(diff)
p patches
