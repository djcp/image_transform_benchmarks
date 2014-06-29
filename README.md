Example benchmarks:

for 49 images totalling 212M in size:

```
$ ./benchmark_transforms.sh                                                                                                                    -- INSERT --
Benchmarking ffmpeg -i {} -vf scale=640:-1 converted_ffmpeg_{}
Sun Jun 29 18:12:08 EDT 2014
Sun Jun 29 18:12:13 EDT 2014
Benchmarking convert {} -resize 640 converted_imagemagick_{}
Sun Jun 29 18:12:13 EDT 2014
Sun Jun 29 18:12:29 EDT 2014

$ du --max-depth=1 -h

2.0M   ./converted_ffmpeg_images
212M   ./images
8.6M   ./converted_imagemagick_images
```

so ffmpeg is ~ 4 times faster and creates images 1/4 the size (but that could
be quality setting mismatches). It can also do overlays as an inline filter,
and has 32 and 64-bit static compiles available.
