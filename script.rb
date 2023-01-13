# Rachnera Gallery Filter
# Partial patch of LoneWolf Scene Replay to add a minimalist search feature to it
# https://github.com/Rachnera/tls-gallery-filter for last version

module TLS_Scenes
  Categories = ["Simon", "Riala", "Yarra", "Aka", "Qum", "NPC", "Hilstara", "Trin", "Megail", "Altina", "Varia", "Carina", "Esthera", "Nalili", "Harem", "Balia", "Lynine", "Orilise", "Iris", "Janine", "Wynn", "Elleani", "Dari", "Uyae", "Robin", "Sarai", "Sabitha", "Tertia", "Ivala", "Mithyn", "Zelica", "Ginasta", "Wendis", "Fheliel", "Neranda"].sort_by { |word| word.downcase }

  # If a scene is given the exact same name as any of the following words, weird issues will happen
  FilterLabel = "Filter"
  SeparatorLabel = "-----"
  ClearLabel = "Clear filter"

  # For non-NPC faces that don't follow the convention "<character name> emo"
  FaceNameToCharacterName = {
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
    "Qum D'umpe" => "Qum",
  }

  # Dark magic to deduce a scene categories from its associated faces
  def self.faces_to_categories(faces)
    faces.map do |name|
      TLS_Scenes::face_to_category(name)
    end.uniq
  end

  def self.face_to_category(name)
    category = name.gsub(/\s+emo.*/, '')
    if TLS_Scenes::FaceNameToCharacterName.has_key?(category)
      category = TLS_Scenes::FaceNameToCharacterName[category]
    end
    # Group all minor characters within the NPC category
    unless TLS_Scenes::Categories.include?(category)
      category = "NPC"
    end
    category
  end

  def self.guess_sprite_name(category)
    ["$" + category + " char", category + " char", category].each do |name|
      if File.file?("Graphics/Characters/" + name + ".png")
        return name
      end
    end

    # Some fallback, to avoid a game crash
    "Ginasta char silhouette"
  end

  # For unusually named sprite sheets
  CharacterNameToSpriteName = {
    "Dari" => "$Dari1 char",
    "NPC" => "z maids char",
    "Harem" => "Monster1blue",
    "Qum" => "$Qum nude",
    "Robin" => "Robin blond",
    "Janine" => "Janine char2",
  }

  Categories.each do |category|
    if not CharacterNameToSpriteName.has_key?(category)
      CharacterNameToSpriteName[category] = TLS_Scenes::guess_sprite_name(category)
    end
  end

  CustomSpriteIndex = {
    "Elleani" => 6,
    "Janine" => 4,
    "Sabitha" => 1,
  }
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
    width = TLS_Scene_Filter::COL_MAX * (TLS_Scene_Filter::SELECTABLE_SIZE + TLS_Scene_Filter::SPACING) - TLS_Scene_Filter::SPACING + TLS_Scene_Filter::STANDARD_PADDING * 2
    height = TLS_Scene_Filter::ROW_MAX * TLS_Scene_Filter::SELECTABLE_SIZE + TLS_Scene_Filter::STANDARD_PADDING * 2

    @filter_window = TLS_Scene_Filter.new((Graphics.width - width) / 2, (Graphics.height - height) / 2, width, height)
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
      TLS_Scenes::faces_to_categories(elt[2]).include?(filter)
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
  COL_MAX = 7
  ROW_MAX = 6
  SELECTABLE_SIZE = 32 + 24 # Sprite height + enough space for a readable text
  SPACING = 8
  STANDARD_PADDING = 12

  def initialize(x, y, width, height)
    super
    @data = TLS_Scenes::Categories
    self.z = 999 # Arbitrarily high number to force the window to appear above everything else on the screen
  end

  # FIXME: Work as is, but does far more loops than it would with a different algorithm
  def remove_empty_categories(select_window)
    @data = @data.select do |category|
      TLS_Scenes::Scene_data.any? do |scene|
        select_window.check_scene_visible(scene) and TLS_Scenes::faces_to_categories(scene[1]).include?(category)
      end
    end
  end

  def col_max
    TLS_Scene_Filter::COL_MAX
  end

  def item_max
    @data ? @data.size : 0
  end

  def spacing
    TLS_Scene_Filter::SPACING
  end

  def item_height
    TLS_Scene_Filter::SELECTABLE_SIZE
  end

  def item_width
    item_height
  end

  def standard_padding
    TLS_Scene_Filter::STANDARD_PADDING
  end

  def draw_item(index)
    reset_font_settings
    make_font_smaller
    font_size = contents.font.size

    sprite_size = 32
    item_top_padding = 4
    item_bottom_padding = 2

    category = @data[index]
    rect = item_rect(index)

    draw_character(
      TLS_Scenes::CharacterNameToSpriteName[category],
      TLS_Scenes::CustomSpriteIndex[category] || 0,
      rect.x + item_width / 2,
      rect.y + sprite_size + item_top_padding,
    )
    draw_text(rect.x, rect.y + rect.height - font_size - item_bottom_padding, rect.width, font_size, category, 1)
  end

  def get_filter
    @data[index]
  end

  def refresh
    create_contents
    draw_all_items
  end
end
