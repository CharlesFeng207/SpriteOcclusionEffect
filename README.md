# SpriteOcclusionEffect
Unity半透明阻挡物体的遮挡效果

先回顾一下不透明物体的遮挡效果实现：
在不透明队列，Unity会先渲染离摄像机距离近的物体，先渲染阻碍物时写入Z缓冲，然后人物渲染有两个Pass，一遍为深度测试成功的显示，另一遍为深度测试失败的显示
如下图：

![pic](https://github.com/CharlesFeng207/SpriteOcclusionEffect/blob/master/Pic/1.png)



但以Sprite为代表的半透明阻碍物，则需要采用另外的方式：

1.先渲染不透明材质人物时写入stencil值。
2.然后Sprite渲染有两个Pass，一遍为模版测试成功的显示，另一遍为模版测试失败的显示。
如下图：

![pic](https://github.com/CharlesFeng207/SpriteOcclusionEffect/blob/master/Pic/2.gif)


这个效果在3d角色，2d场景的游戏里会比较常用。
