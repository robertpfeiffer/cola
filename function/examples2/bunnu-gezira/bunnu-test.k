(define libstdc++ (dlopen "libstdc++.6"))

(send '_import: Object "libgezira-pixmap-pepsi" "__id__init__libgezira-pixmap-pepsi")
(send '_import: Object "Window" "__id__init__Window")

{ bunnu-program }

println "; running";

// Gezira binding

import Parent;
import Translation;
import Composite;
import Lines;
import Window;
import Rotation;
import Background;
import ColorOver;
import Scale;
import PixmapPainter;

Parent.add		   = function(child)	#[self , child];;
PixmapPainter.paint	   = function(pixmap)	#[self paint: pixmap];;
Lines.setLines		   = function(xs, ys)	#[self xs: xs ys: ys];;
PixmapPainter.setPixmap	   = function(pixmap)	#[self pixmap: pixmap];;
Translation.setTranslation = function(x, y)	#[self x: x y: y];;
Window.setExtent	   = function(x, y)	#[self width: x height: y];;
Rotation.setAngle	   = function(a)	#[self angle: a];;
Scale.setScale		   = function(x, y)	#[self x: x y: y];;
ColorOver.setRGB	   = function(r, g, b)	#[self red: r green: g blue: b];;
Background.setRGB	   = function(r, g, b)	#[self red: r green: g blue: b];;

// spinning star

var example = function()
{
  var xs	= [250.00000,  69.09830,  69.09830, 180.90169, 180.90169, 180.90169, 180.90169, 69.09830, 69.09830, 250.00000];
  var ys	= [150.00000, 208.77852, 208.77852,  54.89434,	54.89434, 245.10565, 245.10565, 91.22147, 91.22147, 150.00000];
  var rotation	= Rotation.new().setAngle(0);
  var star	= Translation.new().setTranslation(-150, -150).add(
		    Composite.new().add(
		      Lines.new().setLines(xs, ys)));
  var scene	= Background.new().setRGB(1, 1, 1).add(
		    ColorOver.new().setRGB(1, 0, 0).add(
		      Translation.new().setTranslation(150, 150).add(
		        Scale.new().setScale(1, 1).add(
			  rotation.add(star)))));
  var window	= Window.new().setExtent(300, 300);
  var painter	= PixmapPainter.new().setPixmap(window.pixmap());
  while (1)
  {
    painter.paint(scene);
    window.show();
    rotation.setAngle(rotation.angle() + 0.03);
  }
};

example();
