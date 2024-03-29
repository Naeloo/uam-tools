# Preparation

## Hollowing

The Object modifier "Solidify" is used to hollow out the solid airway mesh. Make sure that object mode
is selected on the top left of the interface. Then, select the airway mesh and switch to the
modifiers by clicking the little blue wrench icon on the vertical row of items on the lower right pane. Select "Add Modifier",
then "Solidify". 

![Hollowed Airway](img/preparation_solidify.png)

!!! info
    In order to best see the results, it is advised to switch to Wireframe view mode.  
    (Standard Key: ++z++ + Click on "Wireframe")

Select an appropriate (TODO: What is appropriate?) thickness for the model and printing method. For further steps,
it is recommended to apply the modifier, which makes its changes to the model permanent. You can choose File->Save Copy before
doing that to create a backup vanilla state of the model.

The result should look something like this:

![Hollowed Airway](img/preparation_hollowing.png)

## Cutting

For easier handling and printing, the airway geometry is best split up into multiple parts that are printed separately
and later connected again. This is accomplished using Blender's "Bisect" tool.

To start with, the airway geometry needs to be selected and Blender needs to be in "Edit Mode". Select the model on the top right or by clicking on it in the scene and then switching to "Edit Mode" on the top left.

![Edit Mode](img/edit_mode.png)

Clear any existing mesh selections by hitting ++alt+a++. Move the camera to the area you want cut and select all of the geometry around the cutting area. Hit "C" to enable a selection brush. You can adjust its size by using the mousewheel, select using the left mouse button and undo selections with the middle mouse button. You can cancel the mode by hitting the right mouse button. Move around the geometry multiple times and make sure all nooks and crannies are selected. 

!!! info
    If you want, you can enable "X-Ray" mode on the top right to allow selecting through solid geometry, but be careful with this as you might easily hit geometry you did not intend to. ![X-Ray](img/x_ray.png)

![Bisect Selection](img/bisect_selecting.png)

!!!warning
    Since Bisect cuts by using an infinite plane, make sure you do not accidentally select any geometry areas you do not want modified, but make sure to not forget to select any hidden spots.

With the geometry selected, click Mesh -> Bisect on the top left.

![Bisect Menu](img/bisect_menu.png)

Drag the cutting plane over the selected geometry as desired.

![Bisecting](img/bisect_doing.png)

Pop up the little "Bisect" window on the bottom left to adjust the parameters. Make sure "Fill", "Clear Inner" and "Clear Outer" are deselected. You can play with the Plane Point and Normal if you're not quite happy with the way the cut is
oriented.

!!!info
    If you're cutting off an airway end and not through a point in the middle of the airway, you can select either "Clear Inner" or "Clear Outer" to discard the lower geometry. In that case, the cutting guide ends here. Refer to [adding a connector]() to add a connector to the open end.

![Bisecting](img/bisect_adjusting.png)

Now hit ++v++ ("Rip") and click the right mouse button to tear the geometry apart. Then, hit ++ctrl+l++ ("Select Linked") in Vertex Mode to select one of the meshes. Move the geometry away a little bit to give yourself more room to work with.

!!!attention
    Sometimes, the mesh isn't entirely linked and "Select Linked" won't select everything - in that case use the selection cursor with X-ray mode as described previously to select the entire segment.

Now press ++p++ and click "Selection" to turn the selected segment into a separate object. Always handling all separate segments as separate object is greatly beneficial to performance and usability, so don't skip this step.

![After Bisect, Rip and Grab](img/bisect_after.png)

After you made a cut, you will probably want to add connectors to the segment ends so they can be connected. To do this, continue with ["Adding - Airway End"](../connectors/#adding-airway-end).