# ram-watch-cheat-engine

The original description of the repository, as well as a tutorial to guide through how it is used, is available on the [original repository](https://github.com/yoshifan/ram-watch-cheat-engine).

## Features added in this fork

### 3D Sonic games specific layouts

There are layouts available for Sonic Adventure DX, Sonic Adventure 2: Battle and Sonic Heroes. Here are the parameters needed to use them:

| Game                      | gameModuleName | gameVersion | layoutName            | Layout Description                                                                                 |
|---------------------------|----------------|-------------|-----------------------|----------------------------------------------------------------------------------------------------|
| Sonic Adventure DX        | sadx           | na          | improved_viewer_2160p | Layout for 4K videos with relevant variables in Kimberley font and with input viewer in Tron Style |
| Sonic Adventure DX        | sadx           | na          | improved_viewer_720p  | Same as above, downscaled to 720p                                                                  |
| Sonic Adventure DX        | sadx           | na          | normal                | Simple layout with important variables for TASing or glitch hunting                                |
| Sonic Adventure DX        | sadx           | na          | youtube               | Simple compacted layout with important variables for visualization                                 |
| Sonic Adventure 2: Battle | sa2b           | na          | improved_viewer_2160p | Layout for 4K videos with relevant variables in Kimberley font and with input viewer in Tron Style |
| Sonic Adventure 2: Battle | sa2b           | na          | improved_viewer_720p  | Same as above, downscaled to 720p                                                                  |
| Sonic Adventure 2: Battle | sa2b           | na          | normal                | Simple layout with important variables for TASing or glitch hunting                                |
| Sonic Adventure 2: Battle | sa2b           | na          | youtube               | Simple compacted layout with important variables for visualization                                 |
| Sonic Heroes              | sheroes        | na          | improved_viewer_2160p | Layout for 4K videos with relevant variables in Kimberley font and with input viewer in Tron Style |
| Sonic Heroes              | sheroes        | na          | normal                | Simple layout with important variables for TASing or glitch hunting                                |
| Sonic Heroes              | sheroes        | na          | youtube               | Simple compacted layout with important variables for visualization                                 |

Other layouts have been implemented as testing purposes and were left in the source code. Feel free to use and tweak them.

### Image based input viewer

The InputDisplay class has been created in `inputviewer.lua` as a tool that works similarly to [NintendoSpy](https://github.com/jaburns/NintendoSpy). Three input skins (OnVarTheme, TronStyleNoDpad720p and TronStyleNoDpad2160p) were created under the `inputs_skin` folder. To use this class, call the `addImage` method in the declaration of the `init` method of your layout and pass the controller variables as parameters: `Layout:addImage(InputDisplay, {'InputSkinName', ControllerData1_Variable, ControllerData2_Variable}, {x=XPos, y=YPos}`, where ControllerData1_Variable contains the controller data for button presses and the main stick, and ControllerData2_Variable contains the controller data for the C stick and the analog triggers. Refer to `games/sa2b_layouts.lua:75` for an example.

To create your own input skin, create a folder in `inputs_skin` with the desired input skin name. In the new folder, create the file `skin.lua`, which describes parameters like the position and sizes of all the images used in the skin. Refer to `inputs_skin/TronStyleNoDpad2160p/skin.lua` for an example.

### Image based fonts

The ImageValueDisplay class has been created in `imagevaluedisplay.lua` as a tool to display text using image based fonts. Fonts are declared in the `fonts` folder and described in the `font.lua` file. Similarly to InputDisplay, this template can be used to declare new fonts. To use this class, call the `addImage` method in the declaration of the `init` method of your layout and pass the desired variable and its size as parameters: `Layout:addImage(ImageValueDisplay, {Variable, VariableSizeInBytes, 'FontName'}, {x=XPos, y=YPos})`. Refer to `games/sa2b_layouts.lua:65` for an example.

### Background images

While static backgrounds could be added using the SimpleElement class, this approach does not allow dynamic changes on it. The `background.lua` file was created to solve this problem, with the classes StaticBackground, SADXBackground, SA2Background and HeroesBackground. The last three ones were implemented to interact specifically with the 3D Sonic games, changing its image file on character selection, although their templates can be used to create other specific background classes.
