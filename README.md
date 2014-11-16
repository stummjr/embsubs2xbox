embsubs2xbox
============

Script to convert video files into XBox 360 DLNA player compatible video files.

##Usage

Download and embed english (`-l en`) subtitles for the input file (`-i The.Office.S04E11.xvid.avi`), transcode it into a file called `The.Office.S04E11.subs.en.avi` (`-o` option):

    embsubs2xbox -i The.Office.S04E11.xvid.avi -l en -o The.Office.S04E11.subs.en.avi


##Available options

- `-i` | `--input`: the path to the input file.
- `-o` | `--output`: the path to the output file.
- `-l` | `--lang`: the language for the subtitles to be downloaded ([ISO 639-1](http://en.wikipedia.org/wiki/ISO_639-1) format)
- `-s` | `--subtitles`: if you want to provide your own subtitles file, you can pass it with this option.
