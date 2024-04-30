# Customizable signet ring

Customize you signet ring with text

Note: the hole for the finger is 20mm, so adjust the scale in your slicer accordingly

see: https://en.wikipedia.org/wiki/Ring_size

## UPDATE

- v2: multiline text, adjust text position and orientation
- v1: 1st design

## customizable variables

- `part`: default "all", part to generate: all, signetRing, signetRingText
- `base_height`: a base between the top of the ring and bottom of the text
- `border_size`: border thickness around the text
- `text_height`: text height
- `ring_text`: text on the top of the ring
- `text_position_x`: adjust text position on X
- `text_position_y`: 0adjust text position on Y

Font details

- `font_size`: The generated text has an ascent (height above the baseline) of approximately the given value.
- `font_type`: The name of the font that should be used
- `font_style`: The font style that should be used: Regular, Bold, Italic, Bold Italic
- `font_halign`: The horizontal alignment for the text: left, center, right
- `font_valign`: The vertical alignment for the text: top, center, baseline, bottom
- `font_spacing`: Factor to increase/decrease the character spacing. The default value of 1 results in the normal spacing for the font, giving a value greater than 1 causes the letters to be spaced further apart.
- `font_direction`: Direction of the text flow. [ltr:left-to-right, rtl:right-to-left, ttb:top-to-bottom, btt:bottom-to-top]
- `font_language`: The language of the text
- `font_script`: The script of the text

Animation
- `animation_rotation` : default false rotating animation

## Sources

here: https://github.com/yannickbattail/openscad-models/tree/main/signetRing

licence GPL

## keywords

jewelry, ring, signet_ring, customizable, customizer, openscad
