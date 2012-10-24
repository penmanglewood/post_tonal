PostTonal
==========

PostTonal is a Ruby library for analyzing sets of musical pitches. It's based on [pitch class set theory](http://en.wikipedia.org/wiki/Set_theory_\(music\) "Pitch class set theory") pioneered by Allen Forte.

#Install

- ```gem install post_tonal --pre```  
- In your Gemfile: ```gem "post_tonal", "~> 0.1.0.pre"```

#Usage

##Setup

```require 'post_tonal'```

##Define a pitch-class set  

```
set = PostTonal::PitchClassSet.new

#Add the set [C, C#, D#, E, G] <-(recognize this collection?)  
set.add_pitch(0) # or set.add_pitch('c')  
set.add_pitch(1) # or set.add_pitch('c#')  
set.add_pitch(3) # or set.add_pitch('d#')  
set.add_pitch(4) # or set.add_pitch('e')  
set.add_pitch(6) # or set.add_pitch('g')  
```

##Transformations

```
#Get the normal form
puts set.normal_form

#Get the prime form
puts set.prime_form

#Get an inversion of the set
puts set.inversion

#Get a transposition of the set
puts set.transpose(4)
```

All transformations return a ```new``` PitchClassSet object, and are thus non-destructive. Transformations can be chained:  
```
set.inversion.transpose(6) #Transpose the inversion of the set by +6  
set.normal_form.inversion #Invert the normal form of the set
```

#License

post_tonal is copyright &copy; 2012 Eric Rubio. It is free software, and may be redistributed under the terms specified in the LICENSE file.