# Lightsaber as selfie stick (customisable)

Use you lightsaber as a selfie stick.

- Open the model in the [customizer](https://www.thingiverse.com/apps/customizer/run?thing_id=6408914), 
- Set your phone dimensions:  phoneHeight, phoneWidth, phoneThickness (in lanscape mode)
- Set the diameter (in inch) of the blade of your light saber: usualy 1 inch, sometimes 7/8 inch = 0.875
- Generate a stl for every parts: `phoneHolder`, `hook`, `screw1`, `screw2`, `serratedWasher` (except `all`)
- Print 1 piece of each part and 2 serratedWasher
- Glue 1 serratedWasher to phoneHolder and 1 serratedWasher to the hook
- Assemble parts as seen in this image [image](photos/saber_selfie_parts.png)

## UPDATE

- v2 smaller hook, thinner phone rack, bigger screw
- v1 1st design

## customizable variables

- `part` : all, phoneHolder, hook, screw1, screw2, serratedWasher
- `saberDiameterInch` : default 1 [0.5:0.025:2] saber blade diameter in inch
- `phoneHeight` : phone height, when in lanscape mode
- `phoneWidth` :  phone width, when in lanscape mode
- `phoneThickness` : phone thickness

other parameter

- `hookLength` : default 40 [10:50] length of the hook (part around the saber)
- `phoneHolderThickness`: default 4; // [1:1:10] Thickness of the phone Holder
- `tolerance` : default 0.5 [0.1:0.1:1]

display

- `displaySaber` default false, show the saber
- `displayPhone` default false, show the phone
- `phoneAngle` default 30 [0:90] phone holder angle

Animation

- `animation_rotation` : default false rotating animation

## Sources

here: https://github.com/yannickbattail/openscad-models/tree/main/selfie_saber

licence GPL

## keywords

star_wars, starwars, lightsaber, selfie_stick, selfie, smartphone_stand, phone_stand, phone_holder, smartphone_holder
