require 'json'

NUM = 3

letters = ('a'..'z').to_a
cap_letters = letters.map(&:upcase)
numbers = (0..9).to_a

all = letters + cap_letters + numbers

all_perms = all.permutation(NUM).map(&:join) + all.repeated_permutation(NUM).map(&:join)

json = {
    "params" => {
        "N" => 18,
        "p" => 1,
        "r" => 8,
        "dkLen" => 32,
        "pbkdf2c" => 65536
    }
}
json['vectors'] = all_perms.uniq.shuffle.map do |l|
  {
    :passphrase => l
  }
end

File.open('test/spec.json', 'w') do |f|
  f.write(JSON.pretty_generate(json))
end
