PostTonal
==========

PostTonal is a Ruby library for analyzing sets of musical pitches. It's based on [pitch class set theory](http://en.wikipedia.org/wiki/Set_theory_\(music\) "Pitch class set theory") pioneered by Allen Forte.

#Setup

-```gem install post_tonal --pre```, OR  
-In your Gemfile: ```gem "post_tonal", "~> 0.1.0.pre"```

#Usage

```
require 'post_tonal'

set = PostTonal::PitchClassSet.new

#Add the set [C, C#, D#, E, G] <-(recognize this collection?)  
set.add_pitch(0) # or set.add_pitch('c')  
set.add_pitch(1) # or set.add_pitch('c#')  
set.add_pitch(3) # or set.add_pitch('d#')  
set.add_pitch(4) # or set.add_pitch('e')  
set.add_pitch(6) # or set.add_pitch('g')  

#Get the normal form
puts set.normal_form

#Get an inversion of the set
puts set.inversion

#Get a transposition of the set
puts set.transpose(4)

```

All transformations return a ```new``` PitchClassSet object, and are thus non-destructive. Transformations can be chained.  
```
set.inversion.transpose(6)  
set.normal_form.inversion
```