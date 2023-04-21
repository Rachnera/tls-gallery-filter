# How to customize the gallery filter
# Without modifying the original file
# So technical updates can still be as easy as replacing the script content entirely

# (also good to "play around" and test small modifications on their own)

# 1. Find in the original script the name of the "constants" defining what you wish to change
# 2. Create a new script below the original in the script editor
# 3. Update partially the "constants" there

# For example, you can copy just the few following lines in a new script and it'll do what's said
# Even if the original was to receive light updates later

# Update the NPC sprite in the filter to depict Towel Succubus
# (file Succubus_Maid_sprite.png, index 3)
TLS_Scenes::CharacterNameToSpriteName.merge!({
  "NPC" => "Succubus_Maid_sprite",
})
TLS_Scenes::CustomSpriteIndex.merge!({
  "NPC" => 3,
})

# Update the icon used to depict a scene is illustrated
# (number is the index showing up in RPGMaker when picking something like an icon for an item)
TLS_Scenes::PictureIcon = 3256
