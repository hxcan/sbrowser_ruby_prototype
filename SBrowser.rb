#!/usr/bin/ruby

$:.unshift File.dirname($0)

require 'Qt4'
require 'SBrowserWindow.rb' #浏览器主窗口。

#Qt.debug_level = Qt::DebugLevel::High #开启调试功能。

app=Qt::Application.new(ARGV)


Qt::CoreApplication::setOrganizationName("StupidBeauty") #设置组织名字。
Qt::CoreApplication::setOrganizationDomain("stupidbeauty.com") #设置组织域名。
Qt::CoreApplication::setApplicationName("SBrowser") #设置程序名字。

gb=SBrowserWindow.new()

Qt::Object::connect(app,SIGNAL('aboutToQuit()'),gb,SLOT('saveGeometry()')) #程序要退出了，则保存窗口的几何属性。
Qt::Object::connect(app,SIGNAL('aboutToQuit()'),gb,SLOT('saveSessionStore()')) #程序要退出了，则保存会话数据。


gb.show()

# gb.startLoad()
app.exec()
