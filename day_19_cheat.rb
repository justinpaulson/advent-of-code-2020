r, messages = File
  .read(ARGV[0] || '../input/19.txt')
  .split("\n\n")
  .map { |chunk| chunk.lines.map(&:chomp) }

rules =
  r.map { |line|
    line
      .gsub(': ', '=>[[').then { |a| a + ']]' }
      .gsub(' | ', '],[')
      .gsub(' ', ',')
  }
  .join(',')
  .then { |a| ?{ + a + ?} }
  .then { |a| eval a }

def create_solver(rules)
  Hash.new do |h,k|
    rule = rules[k].map { |subrule|
      subrule.map { |subsubrule|
        String === subsubrule ? subsubrule : h[subsubrule]
      }.join
    }.then { |res| res.length == 1 ? res.first : "(#{res.join('|')})" }

    h[k] = rule
  end
end

# Part 1
solver = create_solver(rules)
puts solver[0]
# puts solver[8]
# puts solver[42]
inital_rule = Regexp.new(?^+solver[0]+?$)

p messages.grep(inital_rule).count