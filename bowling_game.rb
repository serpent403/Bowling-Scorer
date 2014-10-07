# Bowling Game Scorer

class PlayerStat    
  attr_reader :points
  
  def initialize(points)
      @points = points.split("\s").map { |s| s.to_i }
  end
  
  def generate_scores
      frame_scores = [] # frame by frame aggr. scores
      total_score  = 0  # final score of the player
      frame = 0         # values {0...9}
      ball  = 0         # values {0,1}
            
      printf("%-4s %4s \n", "Frame", "Score")
      printf("%-4s %4s \n", "-----", "-----")
           
      points.each_with_index do |point, i|
          break if frame > 9
              
          frame_score = 0
              
          if ball == 0
              if point == 10 # strike
                frame_score = point + points[i+1] + points[i+2]
                  
              else # go to next ball of this frame
                ball += 1
                next
              end
                
          else # ball == 1
              window_score = points[i-1] + point
                  
              if window_score == 10 # spare
                frame_score = window_score + points[i+1]
                    
              else # open frame
                frame_score = window_score
              end
                
              ball = 0 
          end
                
          frame += 1
          total_score  += frame_score
          frame_scores << total_score
              
          printf("%-4d %4d \n", frame, total_score)
            
      end
      puts "\n\n-----------------------------------------"
  end
end

class BowlingGame
  def initialize
      @player_stats = []
  end

  def game_stats
      read()
      
      @player_stats.each do |player_stat|
          player_stat.generate_scores
      end
  end
  
  private
  
  def read
      puts "Enter scores of players:\neg:"
      puts "9 1   0 10   10   10   6 2   7 3   8 2   10   9 0   9 1   10"
      puts "10   10   10   10   10   10  10   10   10   10   10  10\n"
      puts "Press 'Enter' twice when done.\n\n"
      
      while(true) do
          input = gets.chomp.strip
          break if input.length < 3
          puts input
          @player_stats << PlayerStat.new(input)
      end
  end
  
end

bs = BowlingGame.new
bs.game_stats
