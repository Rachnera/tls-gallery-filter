# TODO

module TLS_Scenes
  Categories = ["Simon", "Riala", "Yarra", "Aka", "Qum D'umpe", "NPC", "Hilstara", "Trin", "Megail", "Altina", "Varia", "Carina", "Esthera", "Nalili", "Harem", "Balia", "Lynine", "Orilise", "Iris", "Janine", "Wynn", "Elleani", "Dari", "Uyae", "Robin", "Sarai", "Sabitha", "Tertia", "Ivala", "Mithyn", "Zelica", "Ginasta", "Wendis", "Fheliel", "Neranda"].sort

  # If a scene is given the exact same name as any of the following words, weird issues will happen
  FilterLabel = "Filter"
  SeparatorLabel = "-----"
  ClearLabel = "Clear filter"

  # For non-NPC sprites that don't follow the convention "<character name> emo"
  SpriteNameToCharacterName = {
    "face002b" => "Simon",
    "face002b dark" => "Simon",
    "1 Simon dark" => "Simon",
    "Wendis blond" => "Wendis",
    "Wendis grey" => "Wendis",
    "Monster1" => "Wendis",
    "Z Orcent" => "Orcent",
    "Dari1" => "Dari",
    "Dari2" => "Dari",
    "Robin blond" => "Robin",
    "Robin grey" => "Robin",
    "Sabitha H" => "Sabitha",
  }

  # Dark magic to deduce a scene categories from its sprites
  def self.sprites_to_categories(sprites)
    sprites.map do |sprite_name|
      category = sprite_name.gsub(/\s+emo.*/, '')
      if TLS_Scenes::SpriteNameToCharacterName.has_key?(category)
        category = TLS_Scenes::SpriteNameToCharacterName[category]
      end
      # Group all minor characters within the NPC category
      unless TLS_Scenes::Categories.include?(category)
        category = "NPC"
      end
      category
    end.uniq
  end
end

class Scene_TLS_Replayer < Scene_MenuBase
  # Sorcery to remember the current setting after a scene is run
  @@cursor_position = 0
  @@filter = nil

  def start
    super
    create_select_window
    create_face_window
    create_filter_window

    if @@filter
      set_filter(@@filter)
    end
    @select_window.select(@@cursor_position)
  end
  
  def play_event
    if @select_window.is_filter_button?
      show_filter_window
      return
    end

    if @select_window.is_clear_button?
      reset_filter
      return
    end

    @@cursor_position = @select_window.index
    @@filter = @select_window.filter
    $game_temp.reserve_common_event(@select_window.get_current_event_id)
    Window_Message.lw_set_opaque(true)
    return_scene
  end
  
  def create_filter_window
    @filter_window = TLS_Scene_Filter.new(Graphics.width*1/16, Graphics.height*1/16, Graphics.width*7/8, Graphics.height*7/8)
    @filter_window.remove_empty_categories(@select_window)
    @filter_window.refresh
    @filter_window.set_handler(:cancel, method(:hide_filter_window))
    @filter_window.set_handler(:ok, method(:set_filter_from_ui))
    @filter_window.hide
  end

  def show_filter_window
    @filter_window.show
    @filter_window.activate
    @filter_window.select(0)
  end

  def hide_filter_window
    @filter_window.hide
    @select_window.activate
  end

  def set_filter_from_ui
    filter = @filter_window.get_filter
    set_filter(filter)
  end

  def set_filter(filter)
    @select_window.filter_data(filter)
    @select_window.select(3)
    hide_filter_window
  end

  def reset_filter
    @select_window.reset_data
    hide_filter_window
  end

  def cancel_replay_menu
    $game_switches[7] = false # must match condition for common event 4
    @@cursor_position = 0
    @@filter = nil
    return_scene
  end
end

class TLS_Replay_Select_Window < Window_Selectable
  attr_reader :filter

  def initialize(x, y, width, height)
    super(x, y, width, height)
    @data = get_extended_data
    @filter = nil
  end

  def get_extended_data
    [[TLS_Scenes::FilterLabel], [TLS_Scenes::SeparatorLabel]].concat(get_data)
  end
    
  def draw_item(i)
    if @data[i][0] == TLS_Scenes::FilterLabel
      change_color(text_color(24))
      text = @data[i][0] + (@filter.nil? ? "" : ": " + @filter)
      draw_text(item_rect(i), text)
      return
    end

    if @data[i][0] == TLS_Scenes::ClearLabel
      change_color(text_color(18))
      draw_text(item_rect(i), @data[i][0])
      return
    end

    change_color(normal_color, @data[i][0] != TLS_Scenes::SeparatorLabel)

    rect = item_rect(i)
    draw_text(rect, @data[i][0])
  end
  
  def update
    super

    if is_filter_button? || is_separator? || is_clear_button?
      @face_window.reset
      return
    end

    @face_window.set_faces(@data[index][2], @data[index][3]) if @data[index]
  end

  def is_filter_button?
    @data[index][0] == TLS_Scenes::FilterLabel
  end
  
  def is_separator?
    @data[index][0] == TLS_Scenes::SeparatorLabel
  end

  def is_clear_button?
    @data[index][0] == TLS_Scenes::ClearLabel
  end

  def current_item_enabled?
    !is_separator?
  end

  def reset_data
    @filter = nil
    @data = get_extended_data
    refresh
  end

  def filter_data(filter)
    @filter = filter
    data = get_data.select do |elt|
      TLS_Scenes::sprites_to_categories(elt[2]).include?(filter)
    end
    @data = [[TLS_Scenes::FilterLabel], [TLS_Scenes::ClearLabel], [TLS_Scenes::SeparatorLabel]].concat(data)
    refresh
  end
end

class TLS_Replay_Face_Window < Window_Base
  def reset()
    contents.clear
  end
end

class TLS_Scene_Filter < Window_Selectable
  def initialize(x, y, width, height)
    super
    @data = TLS_Scenes::Categories
    self.z = 999 # Arbitrarily high number to force the window to appear above everything else on the screen
  end

  # FIXME: Work as is, but does far more loops than it would with a different algorithm
  def remove_empty_categories(select_window)
    @data = @data.select do |category|
      TLS_Scenes::Scene_data.any? do |scene|
        select_window.check_scene_visible(scene) and TLS_Scenes::sprites_to_categories(scene[1]).include?(category)
      end
    end
  end

  def col_max
    4
  end

  def item_max
    @data ? @data.size : 0
  end

  def draw_item(index)
    item = @data[index]
    rect = item_rect(index)
    draw_text(rect, item)
  end

  def get_filter
    @data[index]
  end
end
