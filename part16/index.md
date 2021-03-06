# 作用域和闭包

### 题目
+ this的不同应用场景如何取值?
+ 手写bind函数
```
// bind-demo
Function.prototype.bind1 = function(self, ...args) {
    // 将参数拆解为数组
    // arguments 可以获取一个函数所有的参数，是一个列表不是一个数组
    const args = Array.prototype.slice.call(arguments) // 将一个列表变为数组

    // 获取this (数组第一项)
    const t = args.shift() // 将第一个值取出来，改变原数组

    // 由于这是一个class中一个成员方法的this，指向类的实例，也就是fn1
    // 所以这里的this就是fn1.bind()中的fn1
    const self = this

    // 返回一个函数
    return function() {
        return self.apply(t, args)
    }
}
```
+ 实际开发中闭包的应用场景，举例说明

```
// 1.隐藏数据，只提供API
function createCache() {
    const data = [] // 闭包中的数据，被隐藏，不被外界访问
    return {
        set: function(key, val) {
            data[key] = val
        },
        get: function(key) {
            return data[key]
        }
    }
}

// 2.
```

### 作用域
```
let a = 0; // 全局变量
function fn1() {
    let a1 = 100; // 函数&&块级变量
    function fn2() {
        let a2 = 200; // 函数&&块级变量
        function fn3() {
            let a3 = 300; // 函数&&块级变量
            // 在这个块中，只有a3不是自由变量
            return a + a1 + a2 + a3
        }
        fn3()
    }
    fn2()
}
console.info(fn1())
```

+ 全局作用域
    - 在全局申明的变量，任何位置都可以访问
+ 函数作用域
    - 在函数内部申明的变量，只能在当前函数内部使用
+ 块级作用域
    - 一个大括号就是一个块，超出这个大括号使用就报错
+ 自由变量
    - 一个变量在当前作用域没有定义，但就被使用了
    - 向上级作用域，一层一层依次寻找，直到找到为止
    - 如果全局作用域都没有找到，就报错 xxx is not defined

+ 闭包(作用域应用的特殊情况，有两种表现)
    - 函数作为参数被传递
    - 函数作为返回值被返回

+ 闭包有三个特效:
    + 1.函数嵌套函数;
    + 2.函数内部可以引用外部的参数和变量;
    + 3.参数和变量不会被垃圾回收机制回收。

```
// 函数作为返回值
function create() {
    let a = 100;
    return function() {
        console.info(a)
    }
}
let fn = create()
let a = 200
fn() // 100

// 函数作为参数
function print(fn) {
    let a = 200;
    fn()
}
let a = 100
function fn() {
    console.info(a)
}
print(fn) // 100

// 主要是由于函数寻找自由变量会从定义他自己的作用域开始去寻找
// 而不是在函数执行的时候
```

### this
应用场景
+ 作为普通函数调用
+ 使用call apply bind调用
+ 作为对象方法被调用
+ class方法中被调用
+ 箭头函数中调用

#### this取什么值是在函数执行的时候确认的，而不是函数定义的时候

```
function fn1() {
    console.info(this)
}

fn1() // window

fn1.call({x: 100}) // {x: 100}
const fn2 = fn1.bind({x: 200})
fn2() // {x: 200}

const zhangsan1 = {
    name: '张三',
    sayHi() {
        // this就是当前对象
        console.info(this)
    },
    wait() {
        setTimeout(function() {
            // this指向window
            console.info(this)
        }, 100)
    }
}

const zhangsan2 = {
    name: '张三',
    sayHi() {
        // 普通函数的this，指向调用的位置
        // this就是当前对象
        console.info(this)
    },
    wait() {
        setTimeout(() => {
            // 箭头函数的this永远取它上级作用域的this
            // 因此这里的this指向wait这个函数，所以this指向当前对象
            console.info(this)
        }, 100)
    }
}

class People {
    constructor(name) {
        this.name = name
        this.age = 20
    }
    sayHi() {
        console.info(this)
    }
}
// class中constructor的this代表正在创建的实例，class内部的函数this指向创建的实例
const zhangsan = new People("张三")
zhangsan.sayHi() // zhangsan对象
```