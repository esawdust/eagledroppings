eagledroppings
==============

Useful utilities from Landon Cox / Inhale3D.com to use with CadSoft Eagle PCB Design Software.
CadSoft's EAGLE is a very useful and affordable tool for makers and pros alike, but lets
face it, there are some gaping holes in its functionality.  These utilities aim to fill 
those gaps until such a time as CadSoft does it better.

Please see http://www.inhale3d.com for further information

eagleclone
----------
To start things off, I'm introducing, eagleclone, a utility that lets you clone or replicate a 
board and schematic such that it can be imported multiple times into a design without
having to tediously fix-up all the nets, component names, and everything else to create
a new instance of the module within your design.  

In short, eagleclone, creates multiple instances of a particular layout so you don't 
have to re-layout the same module multiple times or fuss with renaming through the EAGLE
import dialog box.

Prerequisites are an installed version of Ruby 2.0.0 and a .brd and .sch EAGLE file of 
the design you want to replicate.  

Example usage
-------------

```bash
$ ./eagleclone.rb --help

Usage: eagleclone -d design_to_clone -p clone_postfix
    -d, --design DESIGN              specify design file without file extension
    -p, --postfix POSTFIX            specify the postfix to append to all parts, signals, etc
    -h, --help                       Show this message

exit
must supply a design file with the -d option
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

1) In EAGLE, you would load up the design into which you want to import these instances, then
switch to the board layout view of that design. 

2) File->Import each of the .brd files above for A, B, and C respectively
2a) When you import a design it lets you place it somewhere on your board layout much as if 
you were placing a component on the board, but you can place the entire imported design instead.
2b) Notice that when you import the .brd clone, its schematic comes right along with it as a 
new sheet in your design which is nice to keep the instances all separated and easy to manage 
within EAGLE.

3) Route your board normally from there.  It's useful to provide some connection points on 
your sub-module in the board layout before you clone it - just makes it someone easier to 
treat each module like a self-contained layout you just need to hook up to the rest of your design.

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
