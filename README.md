eagledroppings
==============

Useful utilities from Landon Cox / Inhale3D.com to use with CadSoft Eagle PCB Design Software.
CadSoft's EAGLE is a very useful and affordable tool for makers and pros alike, but lets
face it, there are some gaping holes in its functionality.  These utilities aim to fill 
those gaps until such a time as CadSoft does it better.

Please see http://www.inhale3d.com for further explanation and demonstration videos.

Landon Cox, elandon at esawdust.com


Apache Open Source License
--------------------------
Copyright 2013 Landon Cox

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.

eagleclone
----------
To start things off, I'm introducing, eagleclone, a utility that lets you clone or replicate a 
board and schematic such that it can be imported multiple times into a design without
having to tediously fix-up all the nets, component names, and everything else to create
a new instance of the module within your design.  

This is similar to but a little different than panelizing a design. eagleclone is really 
for taking a fragment of a design, say an amplifier design and creating multiple channels
each with its own amplifier instance.  What is missing is the ability to simply copy and
paste a selected portion of a design in a way that pulls through all the components, nets,
pins, and board layout for that part of the design.

You can import a design into Eagle but if it's the second instance of the design, you're
forced to rename all the components and nets to not conflict with those already there.  This is 
obviously a very tedious and error-prone process and is what eagleclone alleviates.

In short, eagleclone, creates multiple instances of a particular layout so you don't 
have to re-layout the same module multiple times or fuss with renaming through the EAGLE
import dialog box.

Since version 6 of EAGLE, the board (.brd) and schematic (.sch) files have been stored in
XML format.  This utility assumes you have EAGLE 6 XML design files.

Prerequisites are: 
1) Ruby 2.0.0 
2) EAGLE 6.x .brd and .sch EAGLE file of the design you want to replicate.  
3) Nokogiri

Example usage
-------------

```bash
$ ./eagleclone.rb --help

Usage: eagleclone -d design_to_clone -p clone_postfix
    -d, --design DESIGN              specify design file without file extension
    -p, --postfix POSTFIX            specify the postfix to append to all parts, signals, etc
    -h, --help                       Show this message

```
Assume you have an EAGLE design called 'test' and the two EAGLE files are 'test.brd' and 'test.sch'
for PCB board and schematic, respectively.  You can create new instances of this design as follows:

```bash
$ ./eagleclone.rb -d test -p A
$ ./eagleclone.rb -d test -p B
$ ./eagleclone.rb -d test -p C
```
This creates three new instances of the test design that are 'A', 'B', and 'C' instances as follows:
```bash
testA.brd
testA.sch
testB.brd
testB.sch
testC.brd
testC.sch
```
To use these replicated designs:

1) In EAGLE, you would load up the master design into which you want to import these instances, then
switch to the board layout view of that design. 

2) File->Import each of the .brd files above for A, B, and C respectively
2a) When you import a design it lets you place it somewhere on your board layout much as if 
you were placing a component on the board, but you can place the entire imported design instead.
2b) Notice that when you import the .brd clone, its schematic comes right along with it as a 
new sheet in your design which is nice to keep the instances all separated and easy to manage 
within EAGLE.

3) Route your board normally from there.  It's useful to provide some connection points on 
your sub-module in the board layout before you clone it - just makes it somewhat easier to 
treat each module like a self-contained layout you just need to hook up to the rest of your design.

Installation
------------

Prerequisites are simply Ruby 2.0 and the Gems specified in the gemfile.

The easiest way to install ruby is to use RVM:  https://rvm.io
```bash
$ \curl -L https://get.rvm.io | bash -s stable
$ source ~/.profile
$ rvm install 2.0.0
```

Then from the directory in which you installed eagleclone, install the requisite gems
for eagleclone:

```bash
eagleclone $ bundle install
```
to install the prerequisite gems.

RSpec tests have been provided if you want to run those to insure you have everything 
installed correctly and the eagleclone utility is working properly.

Run rspec by itself on the command line and the tests will run.  If you see '0 failures'
you know you're good to go.

```bash
eagleclone $ rspec
................

Finished in 0.15284 seconds
16 examples, 0 failures
eagleclone $
```

TODO: Make eagleclone itself a gem.


