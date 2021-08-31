require 'Qt4'
require 'StbWebView.rb'
require 'qtwebkit'

class SWebPageWidget < Qt::Widget
  
  signals 'shouldOpenNewTab()','titleChanged(QString)','iconChanged(QIcon)'
  slots 'gotoUrlBarUrl()','refreshUrl(QUrl)','indicateLoadStart()','indicateLoadProgress(int)','indicateLoadFinished(bool)','indiateIconChanged()','focusWebView()'
  
  def destroyWebPage()
    @wbPg.disconnect() #断开信号连接《。
    
    wbStng=@wbPg.page().settings() #获取设置对象。
    
    wbStng.setAttribute(Qt::WebSettings::PluginsEnabled,false) #禁用插件《。

    @wbPg.stop() #停止网页。
    
    if @wbPg #网页视图存在。
      @wbPg.setHtml('') #设置空白《的《内容《。      
    end #if @wbPg #网页视图存在。
    
    
    @wbPg=nil #标记《为《无用。
  end #def destroyWebPage()
  
  def isFirstTimeLoad()
    return @firstTimeLoad #是否是第一次载入。
  end #def isFirstTimeLoad()
  
  def focusWebView()
    @wbPg.setFocus() #设置焦点。
  end #def focusWebView()
  
  def getWebView()
    return @wbPg #返回网页视图。
  end #def getWebView()
  
  def setBrowserWindow(brsWnd2St)
    @brsrWnd=brsWnd2St #记录。
  end #def setBrowserWindow(brsWnd2St)
  
  def createWindow(wndTp)
    result=@brsrWnd.createWindow(wndTp) #要求浏览器窗口本身创建一个新窗口。
    
    return result #返回结果。
  end #def createWindow(wndTp)
  
  def indiateIconChanged()
    emit iconChanged(@wbPg.icon()) #发射信号。
  end #def indiateIconChanged()
  
  
  def indicateLoadFinished(suc)
    if suc #载入成功。
      crtTtl=@wbPg.title() #获取页面标题。
    else #页面载入出错。
      crtTtl='Page load error' #设置页面标题。
    end
    
    emit titleChanged(crtTtl) #发射信号。
  end #def indicateLoadFinished(suc)
  
  def indicateLoadProgress(crtPrg)
    if (crtPrg) #进度值存在。
    crtTtl='%d%' % crtPrg #获取进度值字符串。
    else #进度值不存在。
          crtTtl='0%' #获取进度值字符串。

    end #if (crtPrg) #进度值存在。
    
    
    if @wbPg.title() #标题存在。
      crtTtl+=@wbPg.title() #接上标题。
    end #if @wbPg.title() #标题存在。
    
    
    emit titleChanged(crtTtl) #显示进度。
  end #def indicateLoadProgress(crtPrg)
  
  def indicateLoadStart()
    emit titleChanged('Loading...') #发射信号。
  end #def indicateLoadStart()
  
  def refreshUrl(nwUrl)
    pp('url changed:'+nwUrl.toString()) #Debug.
    @urlBr.setText(nwUrl.toString()) #显示新的URL。
  end #def refreshUrl(nwUrl)
  
  def gotoUrlBarUrl()
    
    pp('url bar text class:',@urlBr.text().class) #Debug.
    pp('url bar text content:',@urlBr.text()) #Debug.
    
    urlTxt=@urlBr.text() #获取路径条文字内容。
    
    urlTxt=URI.decode(urlTxt) #将百分号编码解码。
    
    @urlBr.setText(urlTxt) #重新显示路径条文字。
    
    raUrl=Qt::Url.new(@urlBr.text()) #构造一个裸的URL对象。
    
    pp('raw url:',raUrl.toString()) #输出原始URL。
    pp('raw url is valid?:',raUrl.isValid()) #是否有效。
    
    raUrlSch=raUrl.scheme() #获取协议。
    
    if !( raUrl.isValid()) #对象未能成功转换成URL。
      raUrl=Qt::Url.new('http://'+@urlBr.text()) #目前能够想到的情况就是，纯数字的主机名加上端口号。因此在这里补上一个协议头。
        @urlBr.setText(raUrl.toString()) #补上HTTP。显示新的URL内容。
    else
      if (raUrlSch.empty?) #协议为空，则默认补上http协议。
        raUrl.setScheme('http') #补上http协议。
        @urlBr.setText(raUrl.toString()) #补上HTTP。显示新的URL内容。
      end
      
    end #if (raUrl==nil) #对象不存在。
    
    
    
    
    @wbPg.load(raUrl) #转到对应的页面。
    
    @wbPg.setFocus() #焦点转移到网页中。
  end #def GotoUrlBarUrl()
  
  def getUrl()
    return @urlBr.text() #返回URL输入条的内容。
  end #def getUrl()
  

  def initialize(parent=nil)
    super()
    
    @firstTimeLoad=true #是第一次载入。
    
    vLyt=Qt::VBoxLayout.new() #竖直布局器。
    setLayout(vLyt) #设置布局器。
    
    @urlBr=Qt::LineEdit.new() #URL输入条。
    connect(@urlBr,SIGNAL('returnPressed()'),self,SLOT('gotoUrlBarUrl()')) #按了回车键，则转到URL输入条所指定的URL。
    
    urlLyt=Qt::HBoxLayout.new() #水平布局器。
    
        nvTlBr=Qt::ToolBar.new() #创建工具条。
    urlLyt.addWidget(nvTlBr) #添加工具条到布局中。

    
    urlLyt.addWidget(@urlBr) #添加URL输入条。
    
    nwTbBtn=Qt::PushButton.new(tr('New Tab')) #新建标签页按钮。
    connect(nwTbBtn,SIGNAL('clicked()'),self,SIGNAL('shouldOpenNewTab()')) #按钮被单击，则发射信号，应当新建空白标签页。
    urlLyt.addWidget(nwTbBtn) #添加新建标签页按钮。
    
    
    
    vLyt.addLayout(urlLyt) #添加URL布局器。
    
    @wbPg=StbWebView.new() #创建网页视图。
    @wbPg.setWebPageWidget(self) #设置自身的指针。
    connect(@wbPg,SIGNAL('titleChanged(QString)'),self,SIGNAL('titleChanged(QString)')) #标题变化，则发射标题变化信号。
    connect(@wbPg,SIGNAL('iconChanged()'),self,SLOT('indiateIconChanged()')) #图标变化，则发射图标变化信号。
    connect(@wbPg,SIGNAL('urlChanged(QUrl)'),self,SLOT('refreshUrl(QUrl)')) #URL变化，则显示新的URL。
    connect(@wbPg,SIGNAL('loadStarted()'),self,SLOT('indicateLoadStart()')) #开始载入，则显示载入中。
    connect(@wbPg,SIGNAL('loadProgress(int)'),self,SLOT('indicateLoadProgress(int)')) #载入进度变化，则显示进度变化。
    connect(@wbPg,SIGNAL('loadFinished(bool)'),self,SLOT('indicateLoadFinished(bool)')) #载入完成，则显示进度变化。
    vLyt.addWidget(@wbPg) #添加网页视图。
    
    #导航工具条：
    bckAct=@wbPg.pageAction(Qt::WebPage::Back) #获取后退按钮。
    nvTlBr.addAction(bckAct) #添加后退按钮。
    rldAct=@wbPg.pageAction(Qt::WebPage::Reload) #获取刷新按钮。
    connect(rldAct,SIGNAL('triggered()'),self,SLOT('focusWebView()')) #重新载入，则给网页赋予焦点。
    nvTlBr.addAction(rldAct) #添加刷新按钮。
    
  end

  def setFirstTimeLoad(ftl2St)
    @firstTimeLoad=ftl2St #记录。
  end #def setFirstTimeLoad(ftl2St)
  
  def setUrl(url2St)
    @urlBr.setText(url2St) #显示URL。
  end
  
  def startLoad()
    @firstTimeLoad=false #不再是第一次载入了。
    
    gotoUrlBarUrl() #载入URL输入栏中的路径。
  end #def startLoad()
  
  
end