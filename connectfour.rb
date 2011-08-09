class ConnectFourGameBoard

	
	
	attr_accessor = :rows, :columns
	
	# Set up
	def initialize(rows, columns, to_win)
		@rows = rows #number of rows on connect 4 board
		@columns = columns #number of columns
		@to_win = to_win #number in a line to win
	end
	
	# Make a move, add a peice to the board
	def do_move(player, column)
		colmn = get_column(column)
		colmn << Piece.new(player)
	end
	
	# Check if a peice is in a slot
	def position(row, column)
		colmn = get_column(column)
		return colmn[row] unless colmn.nil?
	end
	
	# Reset the board
	def reset
		@board = nil
	end
	
	# Check for victory
	def check_win?(player)
		vertical_win?(player) || horizontal_win?(player) || diagonal_win?(player) || other_diagonal_win?(player)
	end
	
	
	
	def max_row
		max_row = @rows-1 #7 rows, index at 6
	end
	
	#set the board
	def board
		@board ||= Array.new(@columns)
	end
	
	def get_column(col)
		board[col] ||= []
	end
	
	#vertical win check
	def vertical_win?(player)
		win =false
		board.each do |column|
			unless column.nil?
				counter = 0
				column.each do |position|
					counter = increment(position, player, counter)
					win ||= win?(counter)
				end
			end
		end
		win
	end
	
	#horizontal win check
	def horizontal_win?(player)
		win = false
		(0..@rows).each do |row|
			counter  = 0
			board.each_with_index do |column, column_index|
				counter = 0 if column.nil?
				position = position(row, column_index)
				counter = increment(position, player, counter)
				win ||= win?(counter)
			end
		end
		win
	end
	
	def diagonal_win?(player)
		win = false
		(0..@columns-@to_win).each do |i|
			counter = 0;
			rowlimit = max_row - i
			(0..rowlimit).each do |j|
				position = position(j, i+j)
				counter = increment(position, player, counter)
				wind ||= win?(counter)
			end
		end
		win
	end
	
	def other_diagonal_win?(player)
		win = false
		(@to_win-1...@columns).each do |i|
			counter = 0
			rowlimit = max_row > i ? i : max_row
			(0..rowlimit).each do |j|
				position = position(j, i-j)
				counter = increment(position, player, counter)
				win ||= win?(counter)
			end
		end
		win
	end
	
	def increment(position, player, counter)
		if position && position.player == player
			return counter.next
		else
			return 0
		end
	end
	
	def win?(counter)
		counter >= @to_win
	end
	
	def display_board
		(0...@rows).each do |row|
			board.each_with_index do |column, index|
				position = position(@rows-row-1, index)
				if position
								
					printf("#{position.player.id}")
				else
					printf(" ")
				end
			end
			printf("\n")
		end
	end
end
	
	class Piece
		def initialize(player)
			@player = player
		end
		
		def player
			@player
		end
	end
	
	
	