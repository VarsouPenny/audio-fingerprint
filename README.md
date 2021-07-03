# audio-fingerprinting
## Authors:
> Gkatsis Vasilis and
> Varsou Penny
-------------------------------------------------------------------------------------------------------------
## Abstract
In this project we use [devaju](https://willdrevo.com/fingerprinting-and-audio-recognition-with-python/) which is an audio fingerprinting and recognition algorithm implemented in Python.
Dejavu can memorize audio by listening to it once and fingerprinting it. Then by playing a song and recording microphone input or reading from disk, Dejavu attempts to match the audio against the fingerprints held in the database, returning the song being played. 
This project tests the performance of Dejavu audio fingerprinting framework in diffenent databases, either on Disk and through a microphone.

## Introduction

Audio fingerprinting is a music information retrieval technique well known for its capabilities in music identification.
One of the main advantages of an audio fingerprint is its
compactness. A fingerprint compresses perceptual information from an audio file into a numeric sequence that is much
shorter than the original waveform data. With this, the comparison of different audio files becomes more efficient and
effective in the fingerprint domain. Audio fingerprinting
is also known for its robustness to distortions. The extracted
features that are eventually summarised in form of the fingerprint are ”as robust as possible to typical distortions to typical
distortions” [2, p. 3], such as those that arise from imperfect
transmission channels or background noise.
Both of these features make audio fingerprinting a suitable
technique for music identification in challenging conditions
and demanding contexts, which is likely the reason why many
popular music identification platforms, such as Shazam [3],
base their algorithms on this technique [2].
This study investigates Dejavu by addressing the following
research questions:
• How does Dejavu perform in identifying songs in 
diffenent databes with different volumn of songs, through diffent time queries.<br />
• How can Dejavu identify songs throught microphone?<br />
• How does Dejavu perform in diffent time queries with distinct noise level?<br />
