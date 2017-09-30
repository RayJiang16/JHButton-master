# JHButton-master

效果展示
-------
![](https://github.com/RayJiang16/JHButton-master/blob/master/1.gif) 

使用方法
-------

1.通过代码创建
-------
```
JHButton *codeButton = [[JHButton alloc] initWithFrame:CGRectMake(15, 100, 120, 35)];
codeButton.normalText = @"Code button";
[codeButton addTarget:self action:@selector(clickCodeButton:) forControlEvents:UIControlEventTouchUpInside];
[self.view addSubview:codeButton];
```

2.通过Storyboard创建
-------
设置Button继承JHButton，接下来把JHButton当做普通Button使用即可。
