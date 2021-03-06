# 原型和原型链
在ES2019中，用了一句短短的话，介绍了一下原型链--prototype chain
a prototype may have a non-null implicit reference to its prototype, and so on; this is called the prototype chain

其实每个 JS 对象都有 __proto__ 属性，这个属性指向了原型。这个属性在现在来说已经不推荐直接去使用它了，这只是浏览器在早期为了让我们访问到内部属性 [[prototype]] 来实现的一个东西。早期的__proto__是浏览器厂商私自开的, 目的就是为了操作`prototype`。只有函数才有`prototype`

原型也是一个对象，并且这个对象中包含了很多函数，所以我们可以得出一个结论：对于`obj`来说，可以通过 `__proto__` 找到一个原型对象，在该对象中定义了很多函数让我们来使用。

打开`constructor`属性又可以发现其中还有一个 `prototype` 属性，并且这个属性对应的值和先前我们在 `__proto__` 中看到的一模一样。所以我们又可以得出一个结论：原型的 `constructor` 属性指向构造函数，构造函数又通过 `prototype` 属性指回原型，但是并不是所有函数都具有这个属性，`Function.prototype.bind()` 就没有这个属性。

### 原型对象和构造函数有什么关系
在JS中, 每当定义一个函数数据类型, 就带有一个prototype(除了Function.prototype.bind()), 而当执行new操作的时候, 这个函数就成了构造函数, 在他的实例上就会存在一个__proto__, 指向这个函数的prototype

换句话说, 每一个函数都有原型(prototype), 每一个对象都有__proto__

### 原型链
实际上就是JS通过prototype的__proto__属性指向父类对象的prototype, 直到指向Object为止

### 最简单的继承(寄生组合继承)

```
function Father() {

}
function Son() {
    Father.call(this)
}
Son.prototype = Object.create(Father.prototype)
Son.prototype.constructor = Son
```

### 面向对象的设计一定是最好的设计吗
其实并不, 比如Car这个类, 有一个加油的属性, 一般来说着实是所有的车都要加油, 但是新能源汽车的出现，如果也继承Car, 那么他这个属性就是多余的。

这就是说的父类无法完全描述清楚子类的需要, 但是子类会将父类的成员都继承下来

一旦子类发生变化, 父类又要跟着变化, 这样维护起来并不好(代码耦合性高)

#### 类似于golang
使用面向组合编程, 无疑是一个比较优秀的解决方案

先设计一系列零件， 然后使用他们进行拼装, 形成不同的实例或者类, 这样代码干净, 也容易复用, 维护起来只需要维护基本的零件就可以了