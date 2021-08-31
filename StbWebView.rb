
require 'Qt4'
require 'qtwebkit'

class StbWebView < Qt::WebView
  slots 'selectAll()'
  
  def selectAll()
    triggerPageAction(Qt::WebPage::SelectAll) #触发全选动作。
  end #def selectAll()
  
  def initialize(parent=nil)
    super #构造基类。
    
        Qt::Shortcut.new(Qt::KeySequence.new(Qt::CTRL.to_i+Qt::Key_A.to_i),self,SLOT('selectAll()')) #Ctrl+A，选中全部内容。

  end #def initialize(parent=nil)

  def createWindow(wndTp)
    result=@wbPgWdgt.createWindow(wndTp) #要求当前网页部件创建新窗口。
    
    return result #返回结果。
  end #def createWindow(wndTp)
  
  def setWebPageWidget(wbPgWdgt2St)
    @wbPgWdgt=wbPgWdgt2St #记录。
  end #def setWebPageWidget(wbPgWdgt2St)  
  
  
end