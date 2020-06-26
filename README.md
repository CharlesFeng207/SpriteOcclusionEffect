# SpriteOcclusionEffect
Unity半透明物体的遮挡效果

先回顾一下不透明物体的遮挡效果实现：
在不透明队列，Unity会先渲染离摄像机距离近的物体，渲染阻碍物时写入Z缓冲，人物渲染两遍，一遍为深度测试成功的显示，另一遍为深度测试失败的显示。
如下图：
![pic](https://github.com/CharlesFeng207/SpriteOcclusionEffect/blob/master/Pic/1.png)



但以Sprite为代表的半透明物体，则需要采用另外的方式：
1.渲染人物时写入stencil。
2.Sprite渲染两遍，一遍为模版测试成功的显示，另一遍为模版测试失败的显示。
如下图：
![pic](https://github.com/CharlesFeng207/SpriteOcclusionEffect/blob/master/Pic/2.gif)
