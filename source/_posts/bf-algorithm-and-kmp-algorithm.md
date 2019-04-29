---
title: BF 算法与 KMP 算法
date: 2019-04-29 18:54:39
tags:
- 数据结构与算法
---

最近温习数据结构与算法，在学习字符串的匹配算法 BM 算法、KMP 算法时，看到了两篇关于 KMP 算法讲解的文章，写的很经典。

- 阮一峰写的 [字符串匹配的KMP算法](http://www.ruanyifeng.com/blog/2013/05/Knuth%E2%80%93Morris%E2%80%93Pratt_algorithm.html) 

- [从头到尾彻底理解KMP](https://blog.csdn.net/v_july_v/article/details/7041827)

BF 算法、KMP 算法匹配过程如下：

主串 S：“BBC ABCDAB ABCDABCDABDE”

模式串 P："ABCDABD"

BM 算法很简单，就是暴力匹配，以主串 S 为基准，模式串 P 从主串 S 的串头单步向后移动匹配到主串 S 的串尾。

<!-- more -->

```
step 1.
BBC ABCDAB ABCDABCDABDE
ABCDABD

step 2.
BBC ABCDAB ABCDABCDABDE
 ABCDABD                 单步移动

step 3.
BBC ABCDAB ABCDABCDABDE
  ABCDABD                单步移动

step 4.
BBC ABCDAB ABCDABCDABDE
    ABCDABD              单步移动
    
...                      单步移动

step 11.
BBC ABCDAB ABCDABCDABDE
           ABCDABD       单步移动
           
...                      单步移动
           
step 16. （经过16个回合匹配成功，模式串 P 相对于主串 S 向后移动了15个位置）
BBC ABCDAB ABCDABCDABDE
               ABCDABD
```

KMP 算法相比 BM 算法高效的原因在于，当模式串 P 的某个字符与主串 S 的字符不匹配时，模式串不是单步向后移动，而是向后跳跃几个位置再与主串 S 匹配。至于跳跃移动的步数，就是 KMP 算法的核心，即求 next。

```
求取 next 的公式：
移动位数 next = 已匹配的字符数 - 对应的部分匹配值

对应的部分匹配值的计算公式：
对应的部分匹配值 = 已匹配的字符数构成的字符串的前缀和后缀的共同字符串的最大长度
```

```
step 1.
BBC ABCDAB ABCDABCDABDE
ABCDABD                  next = 0 - 0 = 0，匹配0个字符，ABCDAB 前缀后缀共同的最长元素 空 的长度为 0

step 2.（向后移动：1）
BBC ABCDAB ABCDABCDABDE
 ABCDABD                 next = 0 - 0 = 0，匹配0个字符，ABCDAB 前缀后缀共同的最长元素 空 的长度为 0

step 3.（向后移动：1）
BBC ABCDAB ABCDABCDABDE
  ABCDABD                next = 0 - 0 = 0，匹配0个字符，ABCDAB 前缀后缀共同的最长元素 空 的长度为 0
  
step 4.（向后移动：1）
BBC ABCDAB ABCDABCDABDE
   ABCDABD               next = 0 - 0 = 0，匹配0个字符，ABCDAB 前缀后缀共同的最长元素 空 的长度为 0

step 5.（向后移动：1）
BBC ABCDAB ABCDABCDABDE
    ABCDABD              next = 6 - 2 = 4，匹配6个字符，ABCDAB 前缀后缀共同的最长元素 AB 的长度为 2
    
step 6.（向后移动：4）
BBC ABCDAB ABCDABCDABDE
        ABCDABD          next = 2 - 0 = 2，匹配2个字符，AB 前缀后缀共同的最长元素 空 的长度为 0

step 7.（向后移动：2）
BBC ABCDAB ABCDABCDABDE
          ABCDABD        next = 0 - 0 = 0，匹配0个字符，ABCDAB 前缀后缀共同的最长元素 空 的长度为 0

step 8.（向后移动：1）
BBC ABCDAB ABCDABCDABDE
           ABCDABD       next = 6 - 2 = 4，匹配6个字符，ABCDAB 前缀后缀共同的最长元素 AB 的长度为 2
           
step 9.（向后移动：4。
          经过9个回合匹配成功，模式串 P 相对于主串 S 向后移动了15个位置）
BBC ABCDAB ABCDABCDABDE
               ABCDABD
```


