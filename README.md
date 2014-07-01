Example benchmarks:

for 49 images totalling 212M in size:

```
$ ./benchmark_transforms.sh                                                                                                                    -- INSERT --
Benchmarking ffmpeg -i {} -vf 'scale=640:-1' converted_ffmpeg_{}

real	0m5.967s
user	0m17.863s
sys	0m2.398s
Benchmarking convert {} -resize 640 converted_imagemagick_{}

real	0m20.663s
user	1m7.222s
sys	0m5.610s
Benchmarking sips -Z 640 {} --out converted_sips_{}

real	0m3.132s
user	0m9.136s
sys	0m1.196s

$ du -d1 -h

2.0M	./converted_ffmpeg_images
8.6M	./converted_imagemagick_images
4.2M	./converted_sips_images
212M   ./images
```
