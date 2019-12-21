# I really have no idea

Here is what is set:

- You have `Content-Security-Policy: require-sri-for script style` in place
- You have XSS protection in place, this means `Content-Security-Policy: style-src 'self'; script-src 'self'`, nothing insecure
- The `.css` must be cachable as it is big
- The images must render correctly even if JavaScript is disabled, so it must use HTML+CSS
- You have an image database
- The page displays the result of am image search of this database, with visual effects applied like cropping, zooming etc.
- The images range vom 1x1 to 100000x100000
- The portion viewed on screen range from 10px to 10000px
- The image can be zoomed, mirrored/flipped and rotated 90 degree wise

Example:

With a CSS-file which contains all the possible width/height/position/imagesize values, like

    width10 { width:10px }
    width11 { width:11px }
    width12 { width:12px }
    ..
    width9999 { width:9999px }
    width10000 { width:10000px }

and so on, an image could be rendered like this:

    <img style="width100 height100 imgx1234 imgy2345 imgw200 imgh200 rot90 mirror" src="the-image.png" alt="face zoom"/>

But this needs some very huge static `.css` file.  Is there any way to do it better?

Invalid solutions are:

- Dropping `require-sri-for`.  This is set and a must-have.  So the `.css` must be static for all possible result pages.
- Requiring `style-src 'unsafe`, as this makes the page insecure (XSS), as the name suggest
- Requiring `style-src data:`, as this makes the page insecure as well
- Requiring JavaScript/JQuery/etc.

Allowed is to require an `img` being wrapped into several `div` with several `style` and/or use HTML attributes etc.
