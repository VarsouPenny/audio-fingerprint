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
### Dejavu
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
Considering this pipeline, the framework’s capabilities
can be roughly classified into two main tasks: remembering a song by fingerprinting it and storing its metadata and
analysing a queried song by fingerprinting it and comparing
these fingerprints to the database to retrieve the best match.
Both of these tasks make use of the same audio fingerprinting
procedure.
#### Fingerprinting
The purpose of audio fingerprinting is to reduce the dimensionality of audio files such that they can be stored and compared more efficiently. However, to allow for these benefits,
unique perceptual features must be preserved as well as possible. Dejavu’s fingerprinting mechanism operates under this
requirement, as it gradually decomposes the signal until a
compact fingerprint of such nature can be formed.
To ready the audio for preprocessing, it is first discretised by
sampling. By default, Dejavu samples the signal with a frequency of 44.1 kHz, meaning that 44,100 samples of the signal are extracted per second. This choice of this frequency
is justified using the Nyquist-Shannon sampling theorem, according to which the signal should be sampled at double the
maximum frequency we aim to capture. Since humans generally cannot hear frequencies above 20,000 Hz, the maximum
frequency was established at 22,050 Hz, such that no humanaudible frequencies would be missed when sampling. Using
the theorem, Dejavu’s default sampling frequency is double
the maximum frequency, or numerically, 2 * 22,050 = 44100
Hz. <br />
After preprocessing, Dejavu generates a frequency domain
representation of the given audio file by applying Fast Fourier
Transform (FFT) to overlapping windows across the signal [9]. This approach is identical to the extraction technique
described by Haitsma and Kalker [4], where they motivate
this choice by reasoning that the most perceptually significant audio qualities are present in the frequency domain. The
transformed windows are combined such that they form a frequency spectrogram of the entire audio file.
The X-axis of the spectrogram represents time relative to
the audio file, and the Y-axis represents the frequency values. With that, each pixel within the spectrogram image corresponds to a given time-frequency pair. The colour of this
pixel indicates the amplitude of a given frequency at the corresponding time. These spectrograms are then used to extract
the features that will constitute the fingerprint.<br />
The peak finding algorithm chooses the time-frequency pair
coordinate corresponding to an amplitude value that is greater
than the amplitudes of its local neighbouring points. This
strategy is based on the fact that these high amplitude frequencies are more likely to survive distortion than the low
amplitude frequencies around them. Dejavu uses the image
of the spectrogram and analyses its pixels to find these peaks. <br />
Specifically, it first applies a high pass filter that emphasises
the high amplitude points, and then it extracts the local maxima, which ultimately become the noise-resistant peaks.
Depending on the frequency composition, the number of
peaks can range between thousands to tens of thousands per
song. However, despite this amount of data, peak extraction
stores only a subset of information unique to the song. The
rest of the information is discarded, which directly increases
the likelihood of peaks of different songs being similar or
even identical. If the framework was to match tracks based
on the extracted peaks, there would likely be many collisions
and incorrect matches. To avoid these collisions as much as
possible, Dejavu encapsulates the peaks in the fingerprint using a hash function.
The peaks are combined into a fingerprint using a hash function. The hash functions used here take a number as input and
return a number as output. A good hash function will always
return the same output for a given input. In addition, it should
also ensure that only a few distinct inputs will be hashed into
the same output.
Given a set of peaks and the time differences between
them, Dejavu creates several hashes, which constitute the
unique fingerprints for the particular track [10].
#### Configurable parameters
Based on the manual written for Dejavu, several parameters
can be configured. The overview of parameters and their effects is available in Table 3.
Most of the configurable parameters present similar tradeoffs. If they are set such that more information is stored, the
fingerprints take up more storage space and the matching will
be more computationally expensive. The upside to such configuration, however, would be better accuracy in matching, as
there will likely be fewer collisions of different songs in terms
of identical or similar fingerprints.
Knowing the parameters and their trade-offs, it may be possible to configure these parameters to improve the benchmark
score based on its results.
#### Performance
##### Recall
The developer of Dejavu has tested the framework in different
experimental setups. Perhaps the experiment most significant
for this research was the one testing microphone-recorded
queries that were captured in the presence of humming and
talking. The results showed that with only 1 second of a random part of the song, Dejavu can identify it correctly in 60%
of the cases. Queries with lengths between 2 and 4 seconds
were identified with recall above 95%. In the last two test
categories of 5 and 6 seconds, all queries were identified correctly [10].
Given that these queries were noisy and still identified correctly by Dejavu, there is a reason to expect the framework
to provide satisfactory performance when tested against the
noise categories in the benchmark.
##### Implementation speed
In terms of fingerprinting, the performance bottleneck is the
peak finding stage. However, according to the developer, the
matching time that resulted from an experiment on one song
with different query lengths was linear. The equation of the
linear regression showed that matching time takes approximately 3-times as long as reading the song, with a small constant overhead [10].
Generally, it is advised to make use of a local database, as
this decreases latency in the total time of querying as opposed
to using remote storage.
## Results
In this project we set up locally 3 distict databases:
-  1st database has 100 songs
-  2nd database has 1000 songs
-  3rd database has 5900 songs
