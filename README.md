# Grid RP

Grid RP is my homemade response to various digital tabletop RPG systems. There's
all kinds of things like [Roll20](https://roll20.net/) and 
[FantasyGrounds](https://www.fantasygrounds.com/home/home.php) and Board Games Simulator or
whatever the Steam one is called. Anyways, while these are cool (I've mostly
looked into Roll20 since it seems popular), they always have far too much going
on for me. Roll20 offers high resolution backgrounds, quantum dice rolls, char
sheet management and more. That's more than I need and it makes the learning curve
far too steep for my liking. So, I could either sit down and learn Roll20, or I 
could make this. Guess which one I chose.

# Installing and Running
Install [Lua](https://www.lua.org/) and [LÖVE2D](https://love2d.org), then run
```
git clone https://github.com/KaliumPuceon/GridRP.git
cd GridRP
love .
```
to run the program. Once this is up to scratch I'll also put down executables
you can download, but right now this is firmly in dev-land.

# Controls

Use the arrow keys to navigate the field

Use - and = to zoom out and in

Click a block to change it to void. (that's all it does right now)

Use r to reload the tiles to blank

Yes, it's limited. This isn't even in alpha. This is in cuneiform or something.

# Basic Idea and Intention
Grid RP is supposed to be a light, tile-based virtual tabletop. I play 3.5e, so
this is built around the traditional one-inch square grids. The idea is to make
a relatively simple but expandable tiling map system that makes drawing new maps
on the fly easy. I often have to throw my players into random encounters and I 
like being able to scratch together a rough surrounding for them to enjoy. I use
a quad whiteboard IRL for this, but that's not easy to carry around and it's 
useless online. Grid RP is intended to have a texture pack system that makes it
easy to create new tiles and add them to a game.

Grid RP is also intended to have a few light tools. That means things like tile 
radius calculations, both taxicab and absolute, simple GM tools like hidden 
sprites, and maybe some stuff to help handle revealing parts of the map.

In short, this is supposed to more or less replicate what a paper system can do,
instead of providing a ton of extra cool tricks, it'll still rely on players 
actually keeping track of what is happening on the board, and giving the GM a lot
of flexibility to do what they want.

# Engine
Grid RP is written in [Lua](https://www.lua.org/) using the [LÖVE2D](https://love2d.org/) 
framework. This is cool because it's good for cross-platform distribution and 
it's also inherently open source, because the executable is just a zip of the folder. 

# Disclaimer
I am not a very good programmer, and there's probably some wild errors in bits of
this. Please let me know, I guess?
