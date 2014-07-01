#!/bin/sh
PATH="./bin/:$PATH"

benchmark_command(){
  tool_to_benchmark=$@
  echo "Benchmarking $tool_to_benchmark"
  (find images -type f -name '*.jpg' -print0 | parallel -0 -I '{}' $tool_to_benchmark) &> /dev/null
}

if command -v ffmpeg; then
	rm -f converted_ffmpeg_images/*
	#FFMPEG="ffmpeg -i {} -vf 'scale=640:-1 [in], movie=watermark.png [watermark]; [in][watermark] overlay=main_w-overlay_w-10:main_h-overlay_h-10 [out]' converted_ffmpeg_{}"
	FFMPEG="ffmpeg -i {} -vf 'scale=640:-1' converted_ffmpeg_{}"
	time benchmark_command $FFMPEG
else
	echo 'ffmpeg not installed, skipping'
fi

if command -v convert; then
	rm -f converted_imagemagick_images/*
	IMAGEMAGICK="convert {} -resize 640 converted_imagemagick_{}"
	time benchmark_command $IMAGEMAGICK
else
	echo 'convert not installed, skipping'
fi

if command -v sips; then
	rm -f converted_sips_images/*
	SIPS="sips -Z 640 {} --out converted_sips_{}"
	time benchmark_command $SIPS
else
	echo 'sips not installed, skipping'
fi
