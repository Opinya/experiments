require 'json'
require 'git_diff_parser'

path = ENV['GITHUB_EVENT_PATH']
data = JSON.parse(File.read(path))
diff = `git diff --unified=0 --no-color #{data['pull_request']['base']['sha']}`
patches = GitDiffParser.parse(diff)

relevant_patches = patches #.select { |patch| File.extname(patch.file) == 'rb' }

p patches

regexes = [
  /\bwhere\s*\{/,
  /a/
]

summaries_by_regexes = regexes.map do |regex|
  summary = relevant_patches.each_with_object(added: 0, removed: 0) do |patch, memo|
    memo[:added] += patch.changed_lines.map { |line| line.content.scan(regex).size }.sum
    memo[:removed] += patch.removed_lines.map { |line| line.content.scan(regex).size }.sum
  end
  [regex, summary]
end.to_h

p summaries_by_regexes
added_regexes = summaries_by_regexes.select { |regex, summary| summary[:added] > summary[:removed] }
unless added_regexes.empty?
  puts 'Squeel is deprecated. New code should not use it.'
  exit 1
end

