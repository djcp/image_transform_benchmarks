#!/bin/sh
PATH="./bin/:$PATH"

benchmark_command(){
  tool_to_benchmark=$@
  echo "Benchmarking $tool_to_benchmark"
  date
  (find images -type f -name '*.jpg' -print0 | parallel -0 -I '{}' $tool_to_benchmark) 2> /dev/null
  date
}

rm -f converted_ffmpeg_images/*
FFMPEG="ffmpeg -i {} -vf 'scale=640:-1 [in], movie=watermark.png [watermark]; [in][watermark] overlay=main_w-overlay_w-10:main_h-overlay_h-10 [out]' converted_ffmpeg_{}"
benchmark_command $FFMPEG

rm -f converted_imagemagick_images/*
IMAGEMAGICK="convert {} -resize 640 converted_imagemagick_{}"
benchmark_command $IMAGEMAGICK
