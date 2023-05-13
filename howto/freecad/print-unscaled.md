> FreeCad 0.20.2

# FreeCad HowTo

## Print your Sketch 1:1

Perhaps you want to check if the sketch fits reality, before you start to extrude it and print it in 3D.
For this you want to print it 1:1 on paper with your laser printer, cut it out and look if everything fits.

This is straight forward in FreeCad, but only if you know how to.

> Following assumes you want to print Din A4

- Open Workbench "Drawing" (there where you select "Sketcher" or "Part Design")
- Click on the down-arrow of the icon "Insert new drawing"
  - Select "A4 Landscape (plain)" or "A4 Portrait (plain)"
- In the ComboView a new "Page" shows up
- Now select the objects you want to print
  - This is your Sketch
  - Or can be an entire Body
  - Or even multiple bodies.
  - If in doubt, select the Body, excpt when you only want to print parts
- Click the icon "Insert view in drawing" (it is just right from the icon before)
  - If you do not see the icon, you probably dropped out of "Drawing" workbench.
- Doubleclick the "Page" in ComboView
  - The output opens

**If you do not see anything on the paper, don't worry!**  This is because the view (object) is **placed outside of the page**.
The pages origin (left, top) is "0,0", going left to positive x and downwards to the negative y axis!

> In school we usually used the "top right quadrant" normally, so if you used that, too, you won't see it first.
> Instead the "lower right quadrant" of the XY plane can be seen on the page.

To see something, you must "move" the "view" to the right place:

- Click on a "View" which is in the "Page"
- In the properties of the view under "Drawing view" you can see:
  - `X`: If you increase this, the Object moves to the right
  - `Y`: If you increase this, the Object moves down.  **This is usually the axis you want to change!**
  - `Scale`: This should be automatically be set to `1.0` which means, you get a 1:1 print

Notes:

- Unfortunately this is WYGIWYS, not WYSIWYG, because to move a "view" (object) you must switch what you see.
  - I did not find out how to move things on the page with the mouse or keyboard etc.
- The 1:1 print is only 1:1 if your printer is printing at the real scale.
  - Some printers allow to put more than 1 page on a page, in that case things are printer smaller, of course
  - You can print A3 onto A4, too, in which case the scale is not kept as well
- If you are really lost, set following on the "view":
  - `X`: 100
  - `Y`: 100
  - `Scale`: 0.01
  - Your should now see some "dirt" on the page.  This is your model
- Slartibartfast from Magrathea probably needs Scales of 0.000001 or even less to print a planet overview on a page, but the allowed minimum scale is 0.01
