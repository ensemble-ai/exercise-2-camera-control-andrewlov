# Code Review for Programming Exercise 2 #

## Peer-reviewer Information

* *name:* Chengyuan, Liu
* *email:* cgyliu@ucdavis.edu

## Solution Assessment ##

### Stage 1 ###

- [X] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification ##### 

For the stage requirement, the camera needs to stay at the middle of our screen whenever our target (ball) move, and it perform perferctly.

### Stage 2 ###

- [ ] Perfect
- [X] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification ##### 

The target is moving with the push-box speed and direction once lagging behind and touching the left edge, which meets the requirement. 
However, in my opinion, I might remove the feature that the ball could push the box into whichever direction the balls moving base on "Scramble". Since from my understanding, the game should work like the camera is constantly pushing the player, no? I'm not 100% sure from the gameplay recording on youtube, so I'm giving a 'great' instead of 'perfect' for this particular stage.

### Stage 3 ###

- [X] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### justification ##### 

For the stage, the player moves prior to the camera, which meet the requirement. 
It works well with hyperspeed as well, camera does never exceed leash distance, which I think is perfectly implemented, furthermore, the author choose to make follow speed a propotion to the player's velocity (0.6 in this case), which I think is a brilliant idea.

### Stage 4 ###

- [X] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### justification ##### 

For this stage, I check pretty much the same stuff as previous : 1. the camera move before player 2. leash distance 3. hyperspeed. 
It does match all these requirments, and also use a propotion to target's velocity as lead speed (1.2), very good implementation.

### Stage 5 ###

- [ ] Perfect
- [X] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### justification ##### 

For the very last stage of the exercise, I check if it meets the requirement by some criterions : 
 1. will the pushbox move with player once touch the border of pushbox. 
 2. does it stay static when players moving inside the speedup zone.
 3. does the box move as player speed * push ratio once between pushbox and speedup zone.
In this case, it meets all the requirement, it also works well with hyperspeed, however, when the player is touching one side of the pushbox and moving in another way (say touching top border and moving left) simultaneously, the box didn't move to the left by speed * push ratio, hence, im giving a 'great' instead of 'perfect'

## Code Style ##

From my point of view, there's no significant infraction for Code Style, variables were properly typed, class and variable names were in correct cases, lines were of reasonable length, but just some minor issues.

#### Style Guide Infractions ####

https://github.com/ensemble-ai/exercise-2-camera-control-andrewlov/blob/9192bbab9346668f00e2510c8cf07fe04eb132df/Obscura/scripts/camera_controllers/framing_horizontal_auto_scroll.gd#L7   -- Should be at seperate line from variable declaration.

https://github.com/ensemble-ai/exercise-2-camera-control-andrewlov/blob/9192bbab9346668f00e2510c8cf07fe04eb132df/Obscura/scripts/camera_controllers/lerp_smoothing.gd#L39                  -- Should have space between '#' and actual comment.

https://github.com/ensemble-ai/exercise-2-camera-control-andrewlov/blob/9192bbab9346668f00e2510c8cf07fe04eb132df/Obscura/scripts/camera_controllers/lerp_smoothing.gd#L84
https://github.com/ensemble-ai/exercise-2-camera-control-andrewlov/blob/9192bbab9346668f00e2510c8cf07fe04eb132df/Obscura/scripts/camera_controllers/framing_horizontal_auto_scroll.gd#L31  -- All of these 'bounday checks', 'left', etc. But, I'm pretty sure this came from handout itself.

https://github.com/ensemble-ai/exercise-2-camera-control-andrewlov/blob/9192bbab9346668f00e2510c8cf07fe04eb132df/Obscura/scripts/camera_controllers/four_way_speed_up.gd#L33               -- Should put comment at a separate line from code, first letter should be capitalize.

https://github.com/ensemble-ai/exercise-2-camera-control-andrewlov/blob/a969c538e5dc8cfbfef24c9067ca67f2e92dd1cb/Obscura/scripts/camera_controllers/four_way_speed_up.gd#L51               -- Should use 'not' instead of '!=', different condition.

## Best Practices ##

### Best Practices Review ###

### Best Practices Exemplars ###

I didn't really see bunch of codes violate the Styleguide documentation, there's little comments in the scripts, almost all of the codes are easily understandable, well-organized and clean, hence, I think this is a well written code overall. Moreover, there's multiple commits, representing great development practices.

### Best Practices Infractions ###

https://github.com/ensemble-ai/exercise-2-camera-control-andrewlov/blob/a969c538e5dc8cfbfef24c9067ca67f2e92dd1cb/Obscura/scripts/camera_controllers/position_lock_lerp.gd#L36             -- This if statement could be cleaner.

The way the author put little to no comments make the code more concise, but from my perspective, I think add some comments will be better for reviewers like me and debugging process.



