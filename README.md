<h1>Zeesh</h1>
A bundle based zshell framework.

<h2>Installation</h2>

<pre>
<code>
% git clone https://github.com/HyperWind/Zeesh ~/.zeesh
% mkdir ~/.zeesh/bundles
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

To create a bundle make a new directory in the bundles folder (not name spcific), inside add three more folders named <em>themes</em>, <em>lib</em> and <em>plugins</em> and place the respective files into these folders.

<pre>
<code>
% mkdir ~/.zeesh/bundles/*desired name*
% mkdir ~/.zeesh/bundles/*desired name*/themes
% mkdir ~/.zeesh/bundles/*desired name*/lib
% mkdir ~/.zeesh/bundles/*desired name*/plugins
</code>
</pre>



<h2>Zeesh Verbosity</h2>

<ul>
<li><b>3</b> - Shows Debugging/Dev logs, advised if you're going to work on this.</li>
<li><b>2</b> - Shows Warnings, Errors and Messages, for every day users who don't want to get into developing.</li>
<li><b>1</b> - Shows only Errors, not advised.</li>
</ul>

<h2>Oh-My-Zsh compatibility</h2>

Zeesh is compatible with Oh-My-Zsh, if you want to use omz's themes/plugins/libs just clone it into the bundle folder.

<pre>
<code>
% cd ~/.zeesh/bundles
% git clone https://github.com/robbyrussell/oh-my-zsh
</code>
</pre>
