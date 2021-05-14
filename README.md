# 2016_super_resolution
[Image Super-Resolution Using Deep Convolutional Networks](https://arxiv.org/abs/1501.00092) ICCV2015

I re-implement this paper and includes my train and test code in this repository. This code uses MIT License.

### Note that:
Thanks for @star4s. I fixed some bugs in the network training code and made the code more clear to use. (2017/4/29)

# Training data
I random selected about 60,000 pic from 2014 ILSVR2014_train (only academic) You can download from (Sorry. My Google Driver is out of storage. So I remove it. )
or [BaiduYun](https://pan.baidu.com/s/1c0TvFyw)


# Result
This code get the better performance than 'bicubic' for enlarging a 2x pic. It can be trained and tested now. 

original pic -> super resolution pic (trained by matconvnet)

![](https://github.com/layumi/2016_super_resolution/blob/master/3_bicubic.jpg) 
![](https://github.com/layumi/2016_super_resolution/blob/master/3_srnet.jpg) 

![](https://github.com/layumi/2016_super_resolution/blob/master/4_bicubic.jpg) 
![](https://github.com/layumi/2016_super_resolution/blob/master/4_srnet.jpg) 

# How to train & test
1.You may compile matconvnet first by running `gpu_compile.m`  (you need to change some setting in it)

For more compile information, you can learn it from www.vlfeat.org/matconvnet/install/#compiling

2.run `testSRnet_result.m` for test result.

3.If you want to train it by yourself, you may download my data and use `prepare_ur_data.m` to produce `imdb.mat` which include every picture path.

4.Use `train_SRnet.m` to have fun~

(I also provide a verson for gray-scale images. But the improvement is limited. You can learn more from `train_SRnet_gray.m` and `testSRnet_gray.m`)
 
# Small Tricks
1.I fix the scale factor 2(than 2+2*rand). It seems to be easy for net to learn more information.

2.How to initial net? (You can learn more from `/matlab/+dagnn/@DagNN/initParam.m`) In this work, the initial weight is important! 

# Citation
We greatly appreciate it if you can cite the website in your publications:
```
@misc{2016_super_resolution,
  title = {{2016_super_resolution}},
  howpublished = "\url{https://github.com/layumi/2016_super_resolution}",
}
```
