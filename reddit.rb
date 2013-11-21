require 'mechanize'
require 'byebug'
require 'json'

agent = Mechanize.new

set = File.open('test/names.txt').read.split("\n")
tested_names = File.open('./test_names.txt').read.split("\n")

# File.open('test/names.txt', 'w+') do |f|

#   page = agent.get('http://www.reddit.com/r/Bitcoin')

#   400.times do
#     authors = page.search('a.author').map(&:text)
#     authors.each(&set.method(:add))

#     nex = page.links.detect{|a| a.text =~ /next/ }
#     page = nex.click
#   end
#   set = set.to_a

#   f.puts(set)
# end

perms = set.to_a.permutation(2).to_a
perms = perms.map{|a| a.join(" ") }


json = {
    "params" => {
        "N" => 18,
        "p" => 1,
        "r" => 8,
        "dkLen" => 32,
        "pbkdf2c" => 65536
    }
}
json['vectors'] = (perms.shuffle - tested_names).map do |l|
  {
    :passphrase => l
  }
end

File.open('test/spec.json', 'w') do |f|
  f.write(JSON.pretty_generate(json))
end
