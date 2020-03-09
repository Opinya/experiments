puts 'hello!'
# puts ENV.inspect

diff = `git diff --unified=0 --no-color HEAD~2`
patches = GitDiffParser.parse(diff)
p patches
