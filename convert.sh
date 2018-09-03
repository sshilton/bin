#! /bin/sh
set -x
my_input=$1
my_wav=`echo "$1" | sed 's/.flv/.wav/g'`
my_artist=$2
my_song=$3
my_mp3=`echo "$1" | sed 's/.flv/.mp3/g'`

if [ "$1" = "" ]; then
	echo "Usage: $0 <input_file> <artist (optional)> <song title (optional)>\n"
	exit 1
fi
# do stuff
ffmpeg -y -i "$my_input" -vn -acodec pcm_s16le "$my_wav"
lame "$my_wav" "$my_mp3"
id3tag -a "$my_artist" -s "$my_song" "$my_mp3"


