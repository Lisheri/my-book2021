# 箭头函数和普通函数的区别

### 箭头函数没有自己的this, 内部的this继承自父级作用域, 他的指向永远不变, 永远指向创建时的父级作用域, 普通函数的this指向调用者
### 箭头函数没有自己的arguments, 同样继承自父级作用域
### 箭头函数不能作为构造函数
### call/apply/bind无法改变箭头函数内部this指向
### 箭头函数写法简单
### 箭头函数没有prototype
### 箭头函数当做generator使用, 没有yield关键字

### 箭头函数和类普通函数的 constructor 里bind的函数有什么区别

+ 普通函数: 在 babel 编译后，会被放在函数的 prototype 上
+ constructor 里 bind 的函数: 在编译后，它不仅会被放在函数的 prototype 里，而且每一次实例化，都会产生一个绑定当前实例上下文的变量(this.b = this.b.bind(this))。
+ 箭头函数：在 babel 编译后，每一次实例化的时候，都会调用 defineProperty 将箭头函数内容绑定在当前实例上下文上。