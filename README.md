# Five Dollars (stylized as $5)
A work-in-progress 2D top-down arcade shooter game with roguelite elements, written in **Lua** using the **Love2D** game framework.  

Essentially me experimenting with another language and trying out another game framework while implementing a cool game idea that I previously came up with.

## Overview of Gameplay

The idea of the game is that the player starts off with only `$5` in a `Shop`, and has nothing on them. No items, no weapons, nothing. 

Their task is to go through a door in the shop to the `Arena`, where they will be challenged to battle an infinite number of monsters and beings, until they eventually lose. 

Once they die, they appear back in the `Shop`, with all of their previous items lost, while keeping any `Coins` that they earned through their battles. 

Now, they can go at it again, but this time, with a new random set of items that they can buy, while being able to afford more (and more expensive) items.

Over time, the player should be able to earn even more `Coins`, leading to more fun gameplay possiblities with more items, leading to a longer survival with more kinds of enemies, leading to earning more `Coins`, and spiraling from there into a positive feedback loop (reminiscent of roguelite games). 

However, a typical "run" of the game is meant to be fairly short, as a more "condensed" experience compared to other roguelite games.

## Current Features
- An "Arena" `Level`, with the opportunity to expand this into more of a dungeon crawler with multiple (or perhaps even unlimited) levels with varying enemies
- Spawning enemies, though the only kind of enemy spawned currently is a `Bob`, who directly chases the player
- `Coins`! (enemies drop coins, coins can be used to purchase more items - though that's still a work-in-progress)
- `Item` system, where those items that are meant to be weapons have an `Attack Component` attached to them to allow the player to attack when that is the active item selected
- `Game` management system
