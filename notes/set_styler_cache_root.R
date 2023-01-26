Output created: README.md
Warning message:
  The R option `styler.cache_root` is not set, which means the cache will get
cleaned up after 6 days (and repeated styling will be slower). 
To keep cache files longer, set the option to location within the {R.cache} 
cache where you want to store the cache, e.g. `"styler-perm"`.

options(styler.cache_root = "styler-perm")

in your .Rprofile. Note that the cache literally takes zero space on your disk, 
only the inode, and you can always manually clean up with `styler::cache_clear()`, 
and if you update the {styler} package, the cache is removed in any case. 
To ignore this message in the future, set the default explictly to "styler" with

options(styler.cache_root = "styler")

in your `.Rprofile`. This message will only be displayed once in a while.
