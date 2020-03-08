puts 'hello!'
st = File.read(ENV['GITHUB_EVENT_PATH'])
puts st
