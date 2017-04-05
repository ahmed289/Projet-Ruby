class Ruby
  attr_reader :x, :y
WindowWidth = 1024
attr_reader :type
  def initialize(type)
    @type = type
    @image = if type == :ruby_up
#On a deux sortes de ruby : les noirs et les classics. 
               Gosu::Image.new('images/ruby2.png')
             elsif type == :ruby_down
               Gosu::Image.new('images/ruby.png')
             end
# La vitesse de deplacement des ruby est variable 
    @velocity = Gosu::random(0.8, 3.3)

    #On s'assure que les ruby restent bien dans la fenêtre
    @x = rand * (WindowWidth - @image.width)
    # Les ruby apparraissent aléatoirement dans la fenêtre
    @y = rand * (768 - @image.width)  
  end

  def update
    @y += @velocity
  end

  def draw
    @image.draw(@x, @y, 1)
  end

end

# Gestion de l'affichage du score
class UI
  def initialize
    @font = Gosu::Font.new(35, name: "front/orange juice 2.0.ttf")
  end

  def draw(score:)
    @font.draw("Score: #{score}", 10, 10, 3, 1.0, 1.0, 0xff_ffff00)
  end
end

#initialisation de mon jeu avec la gem hosu


# Grosse cochone
class GameWindow < Hasu::Window
  SPRITE_SIZE = 128
  WINDOW_X = 1024
  WINDOW_Y = 768
attr_reader :score
  def initialize
    @score = 0
    super(WINDOW_X, WINDOW_Y, false)
    @ui = UI.new
    @background_sprite = Gosu::Image.new(self, 'images/background.png', true)
    @koala_sprite = Gosu::Image.new(self, 'images/koala.png', true)
    @enemy_sprite = Gosu::Image.new(self, 'images/enemy.png', true)
    @flag_sprite = Gosu::Image.new(self, 'images/flag.png', true)
    @font = Gosu::Font.new(self, Gosu::default_font_name, 30)
    @flag = {x: WINDOW_X - SPRITE_SIZE, y: WINDOW_Y - SPRITE_SIZE}
    @sound_collect = Gosu::Sample.new("musics/GetRuby2.wav")
    @sound_Nocollect = Gosu::Sample.new("musics/NoGetRuby.wav")
    @music = Gosu::Song.new(self, "musics/koala.wav")
    @lose_sprite = Gosu::Image.new(self, 'images/flag.png', true)
    @items = []
    reset
  end