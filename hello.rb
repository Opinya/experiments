require 'json'

puts 'hello!'
# puts ENV.inspect
path = ENV['GITHUB_EVENT_PATH']
data = JSON.parse(File.read(path))
diff = `git diff --unified=0 --no-color HEAD~#{data['commits'].size}`
patches = GitDiffParser.parse(diff)
p patches
