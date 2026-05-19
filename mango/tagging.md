tags as described in (awesomewm)[https://awesomewm.org/apidoc/documentation/07-my-first-awesome.md.html] sound different to me from how nir tags and mangowc tags work.

## Awesome
There is a list of tags, each with distinct configuration. Tags maintain information about their layout mode, name, more(?).

## Niri-tag
niri on it's own uses dynamic workspaces, with the ability to create named worksapces. tiri-tag is an external program that uses the niri ipc to make it act like a tag-based window manager. Windows are given tags which can be toggled on or off. A window can only have one tag but multiple tags can be enabled at once. This works by shifting windows on disabled tags to a different workspace and restricting regular use to a single workspace.

## Mango?
I'm not sure. It's a fork from the wlroots port of the dwm, the suckless window manager, awesome originally forked from. So I assume(?) they all use the same model? I remember seing something about views as an independent concept from tags in dwm

Afaict windows can have multiple tags and multiple tags can be in view. what does this mean when we have two tags with different layouts in view?
It's complicated... the current view is not changed.
