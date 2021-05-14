# EE800SuperResolution

Introduction

Picture Quality Enhancing, which is a very important topic, especially in the video processing. 
Meanwhile, the high-definition processing of pictures is the key step of high-definition video. 
Super resolution technology is totally used to build a framework of high-definition images, 
and finally complete the processing of high-definition image. 



How to train & test
1.You may compile matconvnet first by running gpu_compile.m (you need to change some setting in it)

2.run testSRnet_result.m for test result.

3.If you want to train it by yourself, you may download my data and use prepare_ur_data.m to produce imdb.mat which include every picture path.

4.Use train_SRnet.m to have fun~
