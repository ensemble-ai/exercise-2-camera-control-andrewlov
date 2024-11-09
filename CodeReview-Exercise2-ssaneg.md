# Peer-Review for Programming Exercise 2 #

## Description ##

For this assignment, you will be giving feedback on the completeness of assignment two: Obscura. To do so, we will give you a rubric to provide feedback. Please give positive criticism and suggestions on how to fix segments of code.

You only need to review code modified or created by the student you are reviewing. You do not have to check the code and project files that the instructor gave out.

Abusive or hateful language or comments will not be tolerated and will result in a grade penalty or be considered a breach of the UC Davis Code of Academic Conduct.

If there are any questions at any point, please email the TA.   

## Due Date and Submission Information
See the official course schedule for due date.

A successful submission should consist of a copy of this markdown document template that is modified with your peer review. This review document should be placed into the base folder of the repo you are reviewing in the master branch. The file name should be the same as in the template: `CodeReview-Exercise2.md`. You must also include your name and email address in the `Peer-reviewer Information` section below.

If you are in a rare situation where two peer-reviewers are on a single repository, append your UC Davis user name before the extension of your review file. An example: `CodeReview-Exercise2-username.md`. Both reviewers should submit their reviews in the master branch.  

# Solution Assessment #

## Peer-reviewer Information

* *name:* Satyasree Sanegepalli 
* *email:* ssanegepalli@ucdavis.edu

### Description ###

For assessing the solution, you will be choosing ONE choice from: unsatisfactory, satisfactory, good, great, or perfect.

The break down of each of these labels for the solution assessment.

#### Perfect #### 
    Can't find any flaws with the prompt. Perfectly satisfied all stage objectives.

#### Great ####
    Minor flaws in one or two objectives. 

#### Good #####
    Major flaw and some minor flaws.

#### Satisfactory ####
    Couple of major flaws. Heading towards solution, however did not fully realize solution.

#### Unsatisfactory ####
    Partial work, not converging to a solution. Pervasive Major flaws. Objective largely unmet.


___

## Solution Assessment ##

### Stage 1 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The camera stays centered on the vessel during all kinds of movement. When draw_logic is turned on, I can see a 5 unit by 5 unit cross in the center of the screen.

___
### Stage 2 ###

- [ ] Perfect
- [ ] Great
- [x] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The camera autoscrolls in the bottom left direction. The frame border box is properly drawn and changes position as the camera autoscrolls. However, when the player moves to an edge, the box is pushed in that direction. Instead, the player should be restricted by the edges of the box and only be able to move within the box.

___
### Stage 3 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The student correctly calculates the distance between the center of the camera and the player using the distance formula. Then, they check whether the leash distance has been exceeded. If it has been exceeded and the player is moving, they correctly move the camera at the players speed. If the leash distance is not exceeded and the player is moving, the camera moves at the lead speed in the direction of the player. If the player is idle in both cases, the camera moves at the catchup speed.

___
### Stage 4 ###

- [ ] Perfect
- [x] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The center of the camera properly moves ahead by the lead speed in the direction of the player and recenters onto the player after a delay using the catchup speed. When the leash distance is hit, the distance between the player and camera center is maintained. However, when the leash distance is exceeded diagonally, the leash is not immediately activated. This is because the student checks if the distance is exceeded separately in x and z instead of checking the total distance between the player and camera center. [This could be improved by using the distance variable to check if the leash distance has been exceeded instead of x and y.](https://github.com/ensemble-ai/exercise-2-camera-control-andrewlov/blob/a969c538e5dc8cfbfef24c9067ca67f2e92dd1cb/Obscura/scripts/camera_controllers/lerp_smoothing.gd#L34)

___
### Stage 5 ###

- [ ] Perfect
- [x] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
When the player is within the inner box, there is no camera movement. When the player is moving in the speedup zone, the camera movement follows in the same direction. When the player pushes on one of the four corners of the pushbox, the camera moves in both the x and y directions. The camera stays idle when the player is idle in any part of the screen. However, when the player pushes on an edge of the pushbox, the camera only moves in the direction of the touched side of the border box. It should also be moving at the push ratio in the other direction. [In this if condition, only the global_position.x is changed.](https://github.com/ensemble-ai/exercise-2-camera-control-andrewlov/blob/a969c538e5dc8cfbfef24c9067ca67f2e92dd1cb/Obscura/scripts/camera_controllers/four_way_speed_up.gd#L38) The camera should also move in z direction based on the player's current movement in that direction.
___
# Code Style #


### Description ###
Check the scripts to see if the student code adheres to the dotnet style guide.

If sections do not adhere to the style guide, please peramlink the line of code from Github and justify why the line of code has not followed the style guide.

It should look something like this:

* [description of infraction](https://github.com/dr-jam/ECS189L) - this is the justification.

Please refer to the first code review template on how to do a permalink.


#### Style Guide Infractions ####

[This is a big if condition and should be formatted as a multiline statement.](https://github.com/ensemble-ai/exercise-2-camera-control-andrewlov/blob/a969c538e5dc8cfbfef24c9067ca67f2e92dd1cb/Obscura/scripts/camera_controllers/four_way_speed_up.gd#L51)

[Helpful documentation comments should start with a space.](https://github.com/ensemble-ai/exercise-2-camera-control-andrewlov/blob/a969c538e5dc8cfbfef24c9067ca67f2e92dd1cb/Obscura/scripts/camera_controllers/four_way_speed_up.gd#L35)

[Use "not" instead of "!=".](https://github.com/ensemble-ai/exercise-2-camera-control-andrewlov/blob/a969c538e5dc8cfbfef24c9067ca67f2e92dd1cb/Obscura/scripts/camera_controllers/four_way_speed_up.gd#L51) The Godot style guide recommends using plain English for boolean operators.

#### Style Guide Exemplars ####

[The student leaves whitespace around symbols like '+' and '/' and adds parentheses around each condition.](https://github.com/ensemble-ai/exercise-2-camera-control-andrewlov/blob/a969c538e5dc8cfbfef24c9067ca67f2e92dd1cb/Obscura/scripts/camera_controllers/four_way_speed_up.gd#L36) This makes it very easy to understand each individual condition.

[Student uses Pascal case for class names.](https://github.com/ensemble-ai/exercise-2-camera-control-andrewlov/blob/a969c538e5dc8cfbfef24c9067ca67f2e92dd1cb/Obscura/scripts/camera_controllers/four_way_speed_up.gd#L1)

___
#### Put style guide infractures ####

___

# Best Practices #

### Description ###

If the student has followed best practices (Unity coding conventions from the StyleGuides document) then feel free to point at these code segments as examplars. 

If the student has breached the best practices and has done something that should be noted, please add the infraction.


This should be similar to the Code Style justification.

#### Best Practices Infractions ####

[The distance variable is declared in this script but never used.](https://github.com/ensemble-ai/exercise-2-camera-control-andrewlov/blob/a969c538e5dc8cfbfef24c9067ca67f2e92dd1cb/Obscura/scripts/camera_controllers/lerp_smoothing.gd#L30) The student could remove this declaration to allow for easier readability.

[This condition has the same exact code but is repeated twice in this file.](https://github.com/ensemble-ai/exercise-2-camera-control-andrewlov/blob/a969c538e5dc8cfbfef24c9067ca67f2e92dd1cb/Obscura/scripts/camera_controllers/position_lock_lerp.gd#L36) To make the code simpler and less redundant, you could set the outer condition to be "if the player is moving" and the inner condition to be "if leash distance is exceeded". Then, the "else" condition would only have to be written once.

[This if condition would be easier to read if there was a variable "left_edge" defined that was set to "tpos.x - target.WIDTH / 2.0".](https://github.com/ensemble-ai/exercise-2-camera-control-andrewlov/blob/a969c538e5dc8cfbfef24c9067ca67f2e92dd1cb/Obscura/scripts/camera_controllers/four_way_speed_up.gd#L31)

#### Best Practices Exemplars ####

[The student leaves helpful comments in key code areas.](https://github.com/ensemble-ai/exercise-2-camera-control-andrewlov/blob/a969c538e5dc8cfbfef24c9067ca67f2e92dd1cb/Obscura/scripts/camera_controllers/four_way_speed_up.gd#L71) This makes the purpose of this block of code very clear to the reader.

The student has many commits in Github. This portrays a very good use of version control to aid in the coding process.

**All the advice here is just meant to be constructive feedback. Overall great job with the camera controller project!**