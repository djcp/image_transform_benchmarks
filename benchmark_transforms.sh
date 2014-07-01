#!/bin/sh
PATH="./bin/:$PATH"

benchmark_command(){
  tool_to_benchmark=$@
  echo "Benchmarking $tool_to_benchmark"
  (find images -type f -name '*.jpg' -print0 | parallel -0 -I '{}' $tool_to_benchmark) &> /dev/null
}

rm -f converted_ffmpeg_images/*
#FFMPEG="ffmpeg -i {} -vf 'scale=640:-1 [in], movie=watermark.png [watermark]; [in][watermark] overlay=main_w-overlay_w-10:main_h-overlay_h-10 [out]' converted_ffmpeg_{}"
FFMPEG="ffmpeg -i {} -vf 'scale=640:-1' converted_ffmpeg_{}"
time benchmark_command $FFMPEG

rm -f converted_imagemagick_images/*
IMAGEMAGICK="convert {} -resize 640 converted_imagemagick_{}"
time benchmark_command $IMAGEMAGICK

rm -f converted_sips_images/*
SIPS="sips -Z 640 {} --out converted_sips_{}"
time benchmark_command $SIPS
