# MusicPlayer

Apple Podcast app is among the most used app for me.
One thing that stands out for the app is the audio play interface.
It allows me to pick one of those from the audio track lists and play.
Mini play bar hovers beyond any work flow that exists so that you can easily access to what is playing.
When you tap on it, it opens up for detailed configuration of what is playing.
I wanted to program the same interface with some sample audio files.

On one hand, I wanted to discover nuances of this interface in terms of user experience and implement it on my own.
Given the fact that User Interface factors in designing an app, I wanted to tackle architectural issues to study efficient and scalable design so that it is easy to maintain.

## Some representative requirements
(1) make audio track play from the last play time
(2) button push, release makes you feel like you are pushing a physical real world button
(3) make the thumbnail of the audio track backgrounded by blurred image shadow when playing for visual representation of the play status
(4) make view controller transition as smooth and natural as possible
(5) remaining play time and progress of the audio track is summarized on the audio track list 

## Issues that bothered me so far
(1) Button design issue
If you create a custom button to accomplish (2) to make the button produce push/release effect, what about the button icon changes?
Is it right approach to icon change occurs on its own? Or, let the button owner occur the button icon change?

(2) What is the difference and limits of implementing UIPresentationController and UIViewcontrollerTransitioningDelegate?

(3) How do I create an image-blurred background when CALayer doesn’t support that?

(4) Given an AVAudioPlayer instance is interacted with two different sources(one from the mini play bar, the other from the detailed audio play dashboard) and they must do some common tasks for interaction, how would I design it?

(5) What is the point of making the audio play support key-value observing when AVAudioPlayer doesn’t?
