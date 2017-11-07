见 https://github.com/CodeFalling/wiki/issues/2

我把上面的方案用在系统双拼输入法上没成功，可能是因为上面的方案中使用了一些特殊的方法（系统没有提供切换到前一个输入法的接口），比如模拟快捷键。

而我只有两个输入法，其实不需要切换到前一个输入法，一开一关直接对应到中英两个输入法就好了。参考 http://manpages.ubuntu.com/manpages/xenial/man1/fcitx-remote.1.html

这些方法中 [fcitx.el](https://github.com/cute-jumper/fcitx.el) 也没有都用，于是我就配上 [kawa](https://github.com/utatti/kawa) 的代码用 Swift 写了一个。

执行下面命令编译并安装，

```
xcodebuild clean install -project fcitx-remote-workaround-for-macos.xcodeproj -target fcitx-remote -configuration Release DSTROOT="/"
```

编译后，`fcitx-remote -n` 记下中文输入法的 ID，然后替换代码中的 `com.apple.inputmethod.SCIM.ITABC`，再次编译并安装。

# Credit

* [fcitx-remote OS X](https://github.com/CodeFalling/fcitx-remote-for-osx)

* [kawa](https://github.com/utatti/kawa)
