require './Robot'


def main
  puts "Welcome to the robot simulation."
  puts "Please Enter a command to begin"

  r = Robot.new(5,5)

  loop do
    input = gets.downcase.split.map(&:downcase)
    command = input[0].to_sym rescue nil

    if Robot::COMMANDS.include?(command) 
    out= (
        if command == :place
            args = input[1].split(',') rescue nil
            x, y = args[0..1].map(&:to_i) rescue nil
            o = args[2].to_sym rescue nil
            r.send(command, x, y, o)
        else
            r.send(command)
        end)
      puts "Output: "+out if command == :report
    else
      puts "Please Enter Valid Command"
    end
  end  
end

main
