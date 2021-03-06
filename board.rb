class Board
attr_reader :size, :players, :spaces

  def initialize(size,players)
    @size = size
    @players = players
    @spaces = Array.new(@size+1)

    count = 0
    while (count < size+1) do
      @spaces[count] = []
      count +=1
    end

    put_players_on_board
    add_a_snake(12,5)
    add_a_snake(25,3)
    add_a_snake(14,2)
    add_a_ladder(4,10)
    add_a_ladder(6,20)
    add_a_ladder(11,18)

  end

  def put_players_on_board
    for player in @players
      @spaces[1].push(player)
    end
  end

  def add_a_snake(location,destination)
    @spaces[location].push( Snake.new(location,destination) )
  end

  def add_a_ladder(location,destination)
    @spaces[location].push( Ladder.new(location,destination) )
  end


  def print
    count = 0
    for space in @spaces
      puts "#{count}, #{@spaces[count].each {|object| object.name} }"
      count +=1
    end
  end



  def update(player,move)
    finished = false

    while finished == false do

      current = player.current_position
      @spaces[current].delete(player)
      new_current = current + move
      @spaces[new_current].push(player)
      player.move_player(move)

      for event in @spaces[new_current]
        puts "&&&&& #{event}"
        if (event.class == Snake) || (event.class == Ladder)
          move = event.destination - new_current
          puts "&&&&& #{move}"
          break
        else
          finished = true
        end
      end

    end
  end

end
