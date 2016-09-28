## 程序背景

最近觉得学习iOS书籍的时候又一些知识点要写程序验证一下，有利于理解和加深记忆。以前写demo要创建工程，导入第三方库等等，这些工作虽然简单但比较繁琐。还是写一个壳程序，里面导入了常用的第三方库，用tableview按季度分租，点击可以进入某个demo vc 。  这个程序可以很大程度上避免以前为了一个小小的知识验证而创建工程的麻烦，还是很有用的。

## 组织结构

- 整个程序利用pod组织，可以十分方便的引入第三方库
- 规定好以后测试demo代码的位置，十分方便添加、查找、复习
- 以2016年第三季度中scroll view 绘制过程demo为例：
  （1）在TestsTableViewController中的initData中添加一个map｛“名称”：“跳转VC类”｝
  （2）建立一个以数字开头的文件加，初始VC和此demo相关代码都放入其中
  （3）需要注意的是程序中引入了ReactiveCocoa  目前只能下载到4.1版本，这个版本还不支持swift3.0。用xcode8编译到时候要把swift语言版本定为2.3 。方法是在build settings中设置Use legacy Swift Language Version 为Yes。按理说设就设呗，可关键是每次pod install后这个设置总是被置为NO，还没找到解决方法，先备注一下吧。等ReactiveCocoa5.0可以在pod上下载后，这个问题应该迎刃而解了。

## 已有demo

- 001_scrollView

  {@"scroll view绘制过程":[ScrollViewPage class]}​

