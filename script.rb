# Rachnera Gallery Filter
# Add a basic filtering feature to LoneWolf Scene Replay script
# How to use:
#   - Add as any other script, through  Tools > Script Editor
#   - Need to be put below both Lone Wolf: Scene Replay and Decanter: Return to Replay Menu to work properly
# Version: 1.1
# https://github.com/Rachnera/tls-gallery-filter for last version

module TLS_Scenes
  Categories = ["Simon", "Riala", "Yarra", "Aka", "Qum", "NPC", "Hilstara", "Trin", "Megail", "Altina", "Varia", "Carina", "Esthera", "Nalili", "Harem", "Balia", "Lynine", "Orilise", "Iris", "Janine", "Wynn", "Elleani", "Dari", "Uyae", "Robin", "Sarai", "Sabitha", "Tertia", "Ivala", "Mithyn", "Zelica", "Ginasta", "Wendis", "Fheliel", "Neranda", "Lilith"].sort_by { |word| word.downcase }

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

  # For unusually named sprite sheets
  CharacterNameToSpriteName = {
    "NPC" => "z maids char",
    "Harem" => "Monster1blue",
    "Qum" => "$Qum nude",
    "Robin" => "Robin blond",
    "Janine" => "Janine char2",
    "Ivala" => "Spiritual",
  }

  CustomSpriteIndex = {
    "Elleani" => 6,
    "Janine" => 4,
    "Sabitha" => 1,
    "Ivala" => 6,
  }

  ShowIfHasPicture = true
  PictureIcon = 1258
  BugIcon = 2064
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
    width = TLS_Scene_Filter::COL_MAX * (TLS_Scene_Filter::SELECTABLE_WIDTH + TLS_Scene_Filter::SPACING) - TLS_Scene_Filter::SPACING + TLS_Scene_Filter::STANDARD_PADDING * 2
    height = TLS_Scene_Filter::ROW_MAX * TLS_Scene_Filter::SELECTABLE_HEIGHT + TLS_Scene_Filter::STANDARD_PADDING * 2

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
    if @select_window.filter
        reset_filter
        return
    end

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
      text = TLS_Scenes::FilterLabel + (@filter.nil? ? "" : ": " + @filter)
      draw_text(item_rect(i), text)
      return
    end

    if @data[i][0] == TLS_Scenes::ClearLabel
      change_color(text_color(18))
      draw_text(item_rect(i), TLS_Scenes::ClearLabel)
      return
    end

    if @data[i][0] ==  TLS_Scenes::SeparatorLabel
      change_color(normal_color, false)
      draw_text(item_rect(i), TLS_Scenes::SeparatorLabel)
      return
    end

    event_id = clean_event_id(i)

    change_color(normal_color, !!event_id)
    rect = item_rect(i)
    draw_text(rect, @data[i][0])

    if TLS_Scenes::ShowIfHasPicture
      if !event_id
        draw_icon(
          TLS_Scenes::BugIcon,
          rect.x + rect.width - 24,
          rect.y + (rect.height - 24) / 2,
          false
        )
      else if has_picture?(event_id)
        draw_icon(
            TLS_Scenes::PictureIcon,
            rect.x + rect.width - 24,
            rect.y + (rect.height - 24) / 2,
            false
          )
        end
      end
    end
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
    if is_filter_button? || is_clear_button?
      return true
    end

    if is_separator?
      return false
    end

    !!clean_event_id(index)
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

  def clean_event_id(i)
    event_id = get_event_id_for_name(@data[i][0])

    # Due to the way get_event_id_for_name is coded
    # It returns an int if the event is found
    # ... And the list of every common event in the game if not
    # The later is not ideal, so forcing nil instead

    event_id.is_a?(Integer) ? event_id : nil
  end

  def has_picture?(event_id)
    if !event_id
      return false
    end

    $data_common_events[event_id].list.any? do |event_command|
      event_command.parameters.any? do |parameter|
        parameter.is_a?(String) && parameter.include?("show_nsfw")
      end
    end
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
  SELECTABLE_HEIGHT = 32 + 24 # Sprite height + enough vertical space for text
  SELECTABLE_WIDTH = 58 # Enough horizontal space for nice looking long names (ex: Hilstara)
  SPACING = 8
  STANDARD_PADDING = 12

  @@sprite_names = TLS_Scenes::CharacterNameToSpriteName

  def initialize(x, y, width, height)
    super
    @data = TLS_Scenes::Categories
    self.z = 999 # Arbitrarily high number to force the window to appear above everything else on the screen
  end

  def remove_empty_categories(select_window)
    visible_categories = []
    TLS_Scenes::Scene_data.each do |scene|
      if select_window.check_scene_visible(scene)
        TLS_Scenes::faces_to_categories(scene[1]).each do |category|
          if not visible_categories.include?(category)
            visible_categories.push(category)
          end
        end
      end
    end

    @data = @data.select do |category|
      visible_categories.include?(category)
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
    TLS_Scene_Filter::SELECTABLE_HEIGHT
  end

  def item_width
    TLS_Scene_Filter::SELECTABLE_WIDTH
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
      sprite_name(category),
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

  def sprite_name(category)
    # Dari special case
    # Willingly not "cached" so it updates properly when switching saves
    if category == "Dari"
      return $game_switches[2369] ? "$Dari2 char" : "$Dari1 char"
    end

    if not @@sprite_names.has_key?(category)
      @@sprite_names[category] = guess_sprite_name(category)
    end

    @@sprite_names[category]
  end

  def guess_sprite_name(category)
    ["$" + category + " char", category + " char", category].each do |name|
      begin
        Cache.character(name)
        return name
      rescue
        # Expected exception. Should just mean that wasn't the right guess and no file with that name exists
      end
    end

    # Some fallback, to avoid a game crash
    "Ginasta char silhouette"
  end
end
