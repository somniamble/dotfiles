
#!/bin/bash

# Video Quality
# The range of the CRF scale is 0–51, where 0 is lossless, 23 is the default,
# and 51 is worst quality possible. A lower value generally leads to higher
# quality, and a subjectively sane range is 17–28
QUALITY=0

# check if slop command exists
if ! command -v slop &> /dev/null
then
    echo "slop command not found. Please install slop."
    exit 1
fi

# check if an output filename was provided
if [ -z "$1" ]; then
    echo "Usage: $0 <output.mp4>"
    exit 1
fi

# set the output file name
filename="$1"

# get the selection coordinates using slop
echo "Select the desktop area to record."
coords=$(slop -f "%x %y %w %h")

# extract the x, y, width, and height values from the coordinates
x=$(echo $coords | awk '{print $1}')
y=$(echo $coords | awk '{print $2}')
width=$(echo $coords | awk '{print $3}')
height=$(echo $coords | awk '{print $4}')

# ensure that the height and width are divisible by 2
width=$((width / 2 * 2))
height=$((height / 2 * 2))

# display message to user
echo "Recording started. Press 'q' to stop recording."

echo ffmpeg -framerate 60 -f x11grab -s ${width}x${height} -i ${DISPLAY}+$x,$y \
    -vf "fps=10,scale=320:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" \
    -i default -loop 0 $filename
# run the ffmpeg command
ffmpeg -framerate 50 -f x11grab  -ss 10 -s ${width}x${height} -i ${DISPLAY}+$x,$y \
    -vf "fps=50,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" \
    -loop 0 $filename


# display message to user
echo "Recording stopped."
