# audio-fingerprinting
## Authors:
> Gkatsis Vasilis and
> Varsou Penny
-------------------------------------------------------------------------------------------------------------
## Abstract
In this project we use [devaju](https://willdrevo.com/fingerprinting-and-audio-recognition-with-python/) which is an audio fingerprinting and recognition algorithm implemented in Python.
Dejavu can memorize audio by listening to it once and fingerprinting it. Then by playing a song and recording microphone input or reading from disk, Dejavu attempts to match the audio against the fingerprints held in the database, returning the song being played. 

## Introduction
Audio fingerprinting is a music information retrieval technique well known for its capabilities in music identification.
One of the main advantages of an audio fingerprint is its
compactness. A fingerprint compresses perceptual information from an audio file into a numeric sequence that is much
shorter than the original waveform data. With this, the comparison of different audio files becomes more efficient and
effective in the fingerprint domain. Audio fingerprinting
is also known for its robustness to distortions. The extracted
features that are eventually summarised in form of the fingerprint are ”as robust as possible to typical distortions" [2, p. 3], such as those that arise from imperfect
transmission channels or background noise.
Both of these features make audio fingerprinting a suitable
technique for music identification in challenging conditions
and demanding contexts, which is likely the reason why many
popular music identification platforms, such as Shazam [3],
base their algorithms on this technique [2].<br />
This study investigates Dejavu by addressing the following
research questions:<br />
• How does Dejavu perform in identifying songs in 
diffenent databes with different volumn of songs, through diffent time queries?<br />
• How does Dejavu perform in identifing songs throught microphone?<br />
• How does Dejavu perform in diffent time queries with distinct noise level?

------------------------------------------------------------------------------------------------------------------------------
## Methods
Dejavu is an open-source audio fingerprinting framework
written in Python. The following section provides a brief
overview of the framework’s identification pipeline as well
as a more detailed review of its implementation and performance.
The music identification pipeline of Dejavu strongly resembles the basic scenario described in the ’Identification’ usage
model by Cano and Batlle [1].
Specifically, Dejavu first ‘memorises’ songs by extracting their fingerprints and storing them in a database. The
database also contains a table with the songs’ metadata which
is linked to their corresponding fingerprints. After populating
the database, recognition can be done by querying the audio
to be identified. Dejavu first extracts the fingerprints from
the input and then compares them to the database to find the
best-matching set of fingerprints. Finally, it outputs the metadata of songs from the database that was found to have the
best matching fingerprints. As a result, Dejavu returns a list
of songs that were matched. The result contains the match
name and query time, as well as more technical details that
would normally not be of interest to the user. The ranking of
a match among other results is determined by the input confidence. This coefficient represents the percentage of the input
that was matched to the given result. For example, if our input was completely accurately matched to a given result, the
input confidence would be 1.0. The higher this coefficient is,
the higher the particular result ranks. Dejavu also calculates
fingerprinted confidence, which represents the number of the
hashes matched relatively to the entire song in the database.
This means that if we input 10 seconds out of a 20 seconds
long song, and it is matched perfectly, the fingerprinted confidence would be 0.5. Dejavu’s implementation was designed
to always return a match, regardless of the confidence coefficients.
