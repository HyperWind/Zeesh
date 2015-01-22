<h1>Zeesh</h1>

<b>A bundle based zshell framework for sane people.</b>

This is the <em>dev</em> branch, features coming to zeesh in the future are tested here, use at your own risk!

<big>Currently working on:</big>
<ol>
<li>The bundle unmounting/unloading system.</li>
</ol>

<h2>Installation</h2>

Clone zeesh into .zeesh (or any desired folder, though that requires some extra configuration) or add it as a git submodule.

<pre>
<code>
% git clone https://github.com/HyperWind/Zeesh ~/.zeesh
</code>
</pre>

After that add these following lines into your .zshrc file:

<pre>
<code>
source ~/.zeesh/zeesh.zsh
zbn ~/.zeesh
</code>
</pre>

<h3>Colors</h3>

If you want colors, you should add this line right in the top of your .zshrc:

<pre>
<code>
autoload -U colors && colors
</code>
</pre>

<h2>Plugins, themes and all that jazz</h2>

Zeesh is bundle based, so everything other than the core will be situated in a bundle.

To create a bundle make a new directory in the bundles folder (not name specific), inside add three more folders named <em>themes</em>, <em>configs</em> and <em>plugins</em> and place the respective files into these folders

<pre>
<code>
% mkdir ~/.zeesh/bundles/desired_name
% mkdir ~/.zeesh/bundles/desired_name/themes
% mkdir ~/.zeesh/bundles/desired_name/configs
% mkdir ~/.zeesh/bundles/desired_name/plugins
</code>
</pre>

or make an init.zsh in your bundle and configure everything externally. <a href="https://github.com/HyperWind/oh-my-zeesh">(an example)</a>

To load a bundle use this command:

<pre>
<code>
zbn -b bundle_name -p "plugins" -t theme -c
</code>
</pre>

You can also place this command into autoexec.zsh for it to be executed automatically.

More on the usage of zeesh_bundler can be found using this command:

<pre>
<code>
zbn -h
</code>
</pre>

<h2>autoexec.zsh</h2>

autoexec.zsh is part of zeesh's core, everything in it is executed after loading other components. It's mainly used to load the bundles and other configurations. 
Every autoexec.zsh file is personal, so they shuold remain on your machine.
Also, zeesh doesn't arrive with an autoexec.zsh file, you should make one yourself.

<pre>
<code>
% your_editor_of_choice ~/.zeesh/autoexec.zsh
</code>
</pre>

A simple configuration of an autoexec.zsh file would look like this:

<pre>
<code>
# autoexec.zsh
zbn -b bundle_1 -p "plugin_1 plugin_2" -t theme -c
zbn -b bundle_3 -p "plugin_2 plugin_8" -c

custom_function
other_function
</code>
</pre>

and so on.

<h2>Zeesh Verbosity</h2>

<ul>
<li><b>3</b> - Shows Debugging/Dev logs, advised if you're going to work on this.</li>
<li><b>2</b> - Shows Warnings, Errors and Messages, for every day users who don't want to get into developing.</li>
<li><b>1</b> - Shows only Errors, not advised.</li>
</ul>

<h2>Oh-My-Zsh compatibility</h2>

Zeesh is compatible with Oh-My-Zsh, if you want to use omz's themes/plugins/libs just clone the <a href="https://github.com/HyperWind/oh-my-zeesh">Zeesh omz wrapper (Oh-My-Zeesh)</a> into your bundle folder or add it as a git submodule. 

<pre>
<code>
% git clone https://github.com/HyperWind/oh-my-zeesh ~/.zeesh/bundles/oh-my-zeesh
</code>
</pre>

<h2>Known Bugs</h2>

<ul>
<li>None?</li>
</ul>

<h2>To Be Implamented</h2>

<ul>
<li>A bundle unmounting system.</li>
<li>An expansive default bundle.</li>
</ul>

<h2>Contribution</h2>

Contributors should follow the coding style of set by the surrounding code.
Aligning with spaces, indentation - tabs.

