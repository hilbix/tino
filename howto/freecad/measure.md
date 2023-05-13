# FreeCad HowTo

## Measurements done right

You are in Sketcher and want to measure the distance between two points.

Step 1: Add some random measurement

- Adding measurements does only work outside of Sketcher
  - for unknown reason "Measure Distance" is greyed out in Sketcher
  - press `ESC` two times to leave Sketcher
- Then you see your object / shape
- Click on the "Measure Distance" tool (AKA `Std_MeasureDistance`)
  - Click anywhere in the object
  - Click a second time anywhere else in the object
  - Both klicks must hit some object, else it does not work
  - We will correctly position the both points later!

Step 2: Fix it to display the real calculated measurement in ComboView

- Now a new measurement shows up
  - Rename it (the Label) to what you want to name it.
  - The default name (the distance string) is misleading, as it is static regardless how big the distance is
  - If you use `f(x)` for the Label, you will be doomed afterwards!
- Now click on the Description field
  - Be sure you are in the Description and not the Label!
  - Click on `f(x)`
  - Enter `.Distance.UserString`
  - Click OK

Step 3: 
