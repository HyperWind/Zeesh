<h1>Zeesh</h1>
<b>A bundle based zshell framework.</b>

<h2>Installation</h2>

<pre>
<code>
% git clone https://github.com/HyperWind/Zeesh ~/.zeesh
</code>
</pre>


And add these following lines into your .zshrc file:

<pre>
<code>
source ~/.zeesh/zeesh.zsh
zeesh_init ~/.zeesh
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

To create a bundle make a new directory in the bundles folder (not name specific), inside add three more folders named <em>themes</em>, <em>lib</em> and <em>plugins</em> and place the respective files into these folders.

<pre>
<code>
% mkdir ~/.zeesh/bundles/desired_name
% mkdir ~/.zeesh/bundles/desired_name/themes
% mkdir ~/.zeesh/bundles/desired_name/lib
% mkdir ~/.zeesh/bundles/desired_name/plugins
</code>
</pre>

To load a bundle use this command:

<pre>
<code>
zeesh_bundler -b bundle_name -p "plugins" -t theme -l
</code>
</pre>

You can also place this command into autoexec.zsh for it to be executed automatically.

More on the usage of zeesh_bundler can be found using this command:

<pre>
<code>
zeesh_bundler -h
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
zeesh_bundler -b bundle_1 -p "plugin_1 plugin_2" -t theme -l
zeesh_bundler -b bundle_3 -p "plugin_2 plugin_8" -l

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

Zeesh is compatible with Oh-My-Zsh, if you want to use omz's themes/plugins/libs just clone Oh-My-Zsh into the bundle folder and call it in your autoexec.zsh file or after zeesh has loaded everything in.

<pre>
<code>
% cd ~/.zeesh/bundles
% git clone https://github.com/robbyrussell/oh-my-zsh
</code>
</pre>

<h2>Known Bugs</h2>

<ul>
<li>Fails to load theme upon initialization.</li>
</ul>

<h2>To Be Implamented</h2>

<ul>
<li>Individual optional init.zsh files for every bundle.</li>
<li>An expansive default bundle.</li>
</ul>

<h2>Contribution</h2>

Contributors should follow the coding style of set by the surrounding code.
Aligning with spaces, indentation - tabs.
