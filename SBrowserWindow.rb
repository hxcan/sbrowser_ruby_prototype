
$:.unshift File.dirname($0)

require 'Qt4'
require 'qtwebkit'
require 'json' #json解析库。
require 'pp'
require 'oj' #optimized json
require 'uri' #URI

require 'SWebPageWidget.rb' #SWebPageWidget
require 'SBrowserWindow_ui.rb' #Ui_SBrowserMainWindow

class SBrowserWindow < Qt::MainWindow
  
  slots 'startLoad()','saveGeometry()','saveSessionStore()','openNewTab()','changeTabText(QString)','refreshWindowTitle(int)','closeTab(int)','changeTabIcon(QIcon)','maybe1stTimeLoadPage(int)'
  
  def maybe1stTimeLoadPage(nwTbIdx)
    crtTbWdgt=@pgTbs.widget(nwTbIdx) #获取对应的页面部件。
    
    if (crtTbWdgt.isFirstTimeLoad()) #这是第一次载入。
      crtTbWdgt.startLoad() #开始载入页面。
    end #if (crtTbWdgt.isFirstTimeLoad()) #这是第一次载入。
  end #def maybe1stTimeLoadPage(nwTbIdx)
  
  def createWindow(wndTp)
                  crtTbWdgt=SWebPageWidget.new() #创建一个页面部件。
                  crtTbWdgt.setFirstTimeLoad(false) #这种标签页一创建就要开始载入。
                                          crtTbWdgt.setBrowserWindow(self) #设置窗口的指针。

          connect(crtTbWdgt,SIGNAL('shouldOpenNewTab()'),self,SLOT('openNewTab()')) #要求打开空白标签页，则打开一个。
          connect(crtTbWdgt,SIGNAL('titleChanged(QString)'),self,SLOT('changeTabText(QString)')) #标题变化，则修改对应标签页的标题。
          @pgTbs.addTab(crtTbWdgt,'') #添加标签页。
          
          @pgTbs.setCurrentWidget(crtTbWdgt) #切换到新的标签页。

    result=crtTbWdgt.getWebView() #获取新标签页中的网页视图。
    
    return result #返回结果。
  end #def createWindow(wndTp)
  
  def changeTabIcon(nwIcon)
        sndr=sender() #获取信号的发送者。
    
    
    tbIdx=@pgTbs.indexOf(sndr) #获取信号发送者所在的标签页索引。
    
    
    @pgTbs.setTabIcon(tbIdx,nwIcon) #修改标签页图标。
    
    

  end #def changeTabIcon(nwIcon)
  
  def closeTab(tbIdx)
    
    crtTb=@pgTbs.widget(tbIdx) #获取对应的标签页《。
    
    crtTb.destroyWebPage() #销毁网页《。
    
    crtTb=nil #标记为无用。
    
    @pgTbs.removeTab(tbIdx) #删除对应的标签页。
    
    if (@pgTbs.count()<=1) #已经只剩下一个标签页了。
      @pgTbs.setTabsClosable(false) #不可关闭标签页。
    end #if (@pgTbs.count()<=1) #已经只剩下一个标签页了。
  end #def closeTab(tbIdx)
  
  def refreshWindowTitle(nwTbIdx)
    txt2Chg=@pgTbs.tabText(nwTbIdx) #获取对应页面的标题。
    
    if txt2Chg #标题内容存在。
      setWindowTitle(txt2Chg+'-StupidBeauty Browser') #修改窗口标题。
    end #if txt2Chg #标题内容存在。
  end #def refreshWindowTitle(nwTbIdx)
  
  def changeTabText(txt2Chg)
    sndr=sender() #获取信号的发送者。
    
    
    tbIdx=@pgTbs.indexOf(sndr) #获取信号发送者所在的标签页索引。
    
    
    @pgTbs.setTabText(tbIdx,txt2Chg) #修改标签页标题。
    @pgTbs.setTabToolTip(tbIdx,txt2Chg) #设置标签页的悬停提示。

    
    
    if txt2Chg #标题存在。
      if sndr==@pgTbs.currentWidget() #改变标题的是当前标签页，则修改窗口标题。
        setWindowTitle(txt2Chg+'-StupidBeauty Browser') #修改窗口标题。
      end #if sndr==@pgTbs.currentWidget() #改变标题的是当前标签页，则修改窗口标题。
    end #if txt2Chg #标题存在。
    
  end #def changeTabText(txt2Chg)
  
  def openNewTab()
              crtTbWdgt=SWebPageWidget.new() #创建一个页面部件。
              crtTbWdgt.setFirstTimeLoad(false) #这种标签页一创建就要开始载入。
                        crtTbWdgt.setBrowserWindow(self) #设置窗口的指针。

          connect(crtTbWdgt,SIGNAL('shouldOpenNewTab()'),self,SLOT('openNewTab()')) #要求打开空白标签页，则打开一个。
          connect(crtTbWdgt,SIGNAL('titleChanged(QString)'),self,SLOT('changeTabText(QString)')) #标题变化，则修改对应标签页的标题。
          @pgTbs.addTab(crtTbWdgt,'') #添加标签页。
          
          @pgTbs.setCurrentWidget(crtTbWdgt) #切换到新的标签页。
          
          
          if (@pgTbs.count()>1) #不止一个标签页。
              @pgTbs.setTabsClosable(true) #可关闭标签页。
          end #if (@pgTbs.count()>1) #不止一个标签页。

  end #def openNewTab()
  
  def saveSessionStore()
    ssnObj={} #会话信息对象。
    
    wndsVl=[] #窗口数组。
    ssnObj['windows']=wndsVl #加入窗口信息。
    
    crtWnd={} #当前窗口对象。
    wndsVl[0]=crtWnd #加入当前窗口对象。
    
    tbsVl=[] #标签页数组。
    crtWnd['tabs']=tbsVl #加入标签页数组。
    
    #一个个地加入标签页：
    tbsAmt=@pgTbs.count() #获取当前显示的标签页数量。
    
    pp('Start adding tabs.Tabs amount:',tbsAmt) #Debug.
    
    for tbsCtr in 0..(tbsAmt-1) #一个个地保存标签页信息。
      crtTb={} #当前标签页的信息。
      tbsVl[tbsCtr]=crtTb #加入当前标签页。
      
      tbEtrs=[] #当前标签页中的条目数组。
      
      crtTb['entries']=tbEtrs #条目数组。
      
      crtEntr={} #当前条目。
      
      tbEtrs[0]=crtEntr #加入当前条目。
      
      crtWbPgWdgt=@pgTbs.widget(tbsCtr) #获取当前标签页。
      
      
      crtUrl=crtWbPgWdgt.getUrl() #获取当前标签页的URL。
      crtTtlRaw=@pgTbs.tabText(tbsCtr) #获取当前标签页的标题。
      if crtTtlRaw #标题存在。
        crtTtl=crtTtlRaw.force_encoding('utf-8') #获取当前标签页的标题。
      else #标题不存在。
        crtTtl='' #空白标题。
      end
      
      crtEntr['url']=crtUrl #记录URL。
      crtEntr['title']=crtTtl #记录页面标题。
      
      crtTb['index']=1 #索引。
    end #for tbsCtr in 0..tbsAmt #一个个地保存标签页信息。
    
    #pp('session object:',ssnObj) #debug.
    jsnWhlStr=Oj.dump(ssnObj) #格式化成JSON。
    
    #保存到文件中：
    ssnStrJs=Qt::Dir::homePath()+'/.sbrowser/sessionstore.json' #会话记录的JSON文件名。
    ssnStrDir=Qt::Dir::homePath()+'/.sbrowser/' #会话记录的JSON文件目录。
    
    ssnStrDirObj=Qt::Dir.new(ssnStrDir) #构造目录对象。
    if (ssnStrDirObj.exists()) #该目录存在。
    else #该目录不存在。
      hmDir=Qt::Dir::home() #获取家目录。
      hmDir.mkdir('.sbrowser') #创建子目录。
    end
    
    ssnStrFl=Qt::File.new(ssnStrJs) #JSON文件。
    ssnStrFl.open(Qt::IODevice::WriteOnly) #打开文件。
    
    ssnStrStrm=Qt::TextStream.new(ssnStrFl) #文本流。
    
    ssnStrStrm << jsnWhlStr #输出内容。
    
    ssnStrFl.close() #关闭文件。
  end #def saveSessionStore()
  
  def enableOfflineStorage()
    #检查"~/.sbrowser"目录是否存在：
        ssnStrDir=Qt::Dir::homePath()+'/.sbrowser/' #会话记录的JSON文件目录。
    
    ssnStrDirObj=Qt::Dir.new(ssnStrDir) #构造目录对象。
    if (ssnStrDirObj.exists()) #该目录存在。
    else #该目录不存在。
      hmDir=Qt::Dir::home() #获取家目录。
      hmDir.mkdir('.sbrowser') #创建子目录。
    end
    
    #检查"~/.sbrowser/offlinestorage"目录是否存在：
    oflnStogDir=Qt::Dir::homePath()+'/.sbrowser/offlinestorage/' #会话记录的JSON文件目录。
    oflnStogDirObj=Qt::Dir.new(oflnStogDir) #构造目录对象。
    
    if (oflnStogDirObj.exists()) #目录存在。
    else #目录不存在。
      ssnStrDirObj.mkdir('offlinestorage') #创建子目录，离线存储目录。
    end #if (oflnStogDirObj.exists()) #目录存在。
    

     glbWbStng=Qt::WebSettings::globalSettings() #获取全局的网页设置对象。
     glbWbStng.setAttribute(Qt::WebSettings::OfflineStorageDatabaseEnabled,true) #启用离线存储。
     Qt::WebSettings::setOfflineStoragePath(oflnStogDir) #设置离线存储路径。
  end #def enableOfflineStorage()
  
  def initialize(parent=nil)
    super
    
        u = Ui_SBrowserMainWindow.new #创建界面对象。
        u.setupUi(self) #构造界面。

    
    glbWbStng=Qt::WebSettings::globalSettings() #获取全局的网页设置对象。
    glbWbStng.setAttribute(Qt::WebSettings::PluginsEnabled,true) #启用插件。
    
    glbWbStng.setAttribute(Qt::WebSettings::DnsPrefetchEnabled,true) #启用DNS预取。
    glbWbStng.setAttribute(Qt::WebSettings::DeveloperExtrasEnabled,true) #启用开发者工具。
    
    glbWbStng.setFontFamily(Qt::WebSettings::StandardFont,'WenQuanYi Zen Hei Mono') #设置默认字体为文泉驿正黑等宽。
    glbWbStng.setFontFamily(Qt::WebSettings::SansSerifFont,'WenQuanYi Zen Hei Mono') #设置默认字体为文泉驿正黑等宽。
    glbWbStng.setFontFamily(Qt::WebSettings::SerifFont,'WenQuanYi Zen Hei Mono') #设置默认字体为文泉驿正黑等宽。
    glbWbStng.setFontFamily(Qt::WebSettings::FixedFont,'WenQuanYi Zen Hei Mono') #设置默认字体为文泉驿正黑等宽。
    glbWbStng.setFontFamily(Qt::WebSettings::CursiveFont,'WenQuanYi Zen Hei Mono') #设置默认字体为文泉驿正黑等宽。
    glbWbStng.setFontFamily(Qt::WebSettings::FantasyFont,'WenQuanYi Zen Hei Mono') #设置默认字体为文泉驿正黑等宽。
    
    pp('font family:',glbWbStng.fontFamily(Qt::WebSettings::StandardFont),glbWbStng.fontFamily(Qt::WebSettings::SansSerifFont)) #Debug.
    
    
    enableOfflineStorage() #启用HTML5的离线存储。
    
    
    @pgTbs=u.pgstabWidget #网页标签页部件。
    @pgTbs.setTabsClosable(true) #标签页可以关闭。
    @pgTbs.setStyleSheet('QTabBar::tab{max-width:150px;text-align:left}') #设置样式单，限制标签页的最大宽度。
    @pgTbs.setContentsMargins(1,1,1,1) #不要边距。
    connect(@pgTbs,SIGNAL('currentChanged(int)'),self,SLOT('refreshWindowTitle(int)')) #当前标签页改变，则相应地刷新窗口标题。
    connect(@pgTbs,SIGNAL('currentChanged(int)'),self,SLOT('maybe1stTimeLoadPage(int)')) #当前标签页改变，则检查对应的页面是不是第一次载入。
    connect(@pgTbs,SIGNAL('tabCloseRequested(int)'),self,SLOT('closeTab(int)')) #某个标签页该关闭了，则关闭该标签页。


    
    
    
    
    @ldTimer=Qt::Timer.new() #定时器。
    
    connect(@ldTimer,SIGNAL('timeout()'),self,SLOT('startLoad()')) #定时器超时，则开始载入。
    
    @ldTimer.setInterval(0) #0秒超时。
    @ldTimer.setSingleShot(true) #单发。
    
    @ldTimer.start() #启动定时器。
    
    
    @svSsnTmr=Qt::Timer.new() #创建定时器。用于定时保存会话信息的定时器。
    @svSsnTmr.setInterval(15*1000) #15秒超时。
    @svSsnTmr.setSingleShot(false) #连发。
    
    connect(@svSsnTmr,SIGNAL('timeout()'),self,SLOT('saveSessionStore()')) #定时保存会话信息。
    
    
    loadGeometry() #载入几何属性。

  end
  
  def loadGeometry()
     settings=Qt::Settings.new() #设置信息。s

     settings.beginGroup("SBrowserWindow") #主要窗口。
     
     
     dftSzVrt=Qt::Variant.new(Qt::Size.new(400, 400)) #默许窗口尺寸。
     
     crtSzVrt=settings.value("size",dftSzVrt ) #读取窗口尺寸。
     crtSz=crtSzVrt.toSize() #读取窗口尺寸。转换成尺寸对象。
     
     
     
     resize(crtSz) #重置窗口大小。
     move(settings.value("pos",Qt::Variant.new(  Qt::Point.new(200, 200) )  ).toPoint()) #重置窗口位置。
     settings.endGroup() #关闭分组。
  end
  
  def saveGeometry()
    settings=Qt::Settings.new() #设置信息储存对象。

     settings.beginGroup("SBrowserWindow") #开始分组。
     
     crtSz=Qt::Variant.new(size()) #窗口尺寸。
     
     settings.setValue("size", crtSz) #记录窗口尺寸。
     
     
     crtPos=Qt::Variant.new(pos()) #窗口位置。
     
     settings.setValue("pos", crtPos) #记录窗口位置。
     
     settings.endGroup() #关闭分组。
     
     settings.sync() #同步。
  end
  
  def loadSessionStore(ssnStrJs)
        #从里面解析出当前打开的标签页列表：
    json=File.read(ssnStrJs) #读取JSON文件。
    obj=JSON.parse(json) #解析JSON。
    
    
    pp('session store size:',obj.size()) #Debug.
    
    pp('Keys:',obj.keys()) #Debug.
    
    wndsVl=obj['windows'] #windows键的值。
    
    #一个个窗口地处理：
    pp('windows size:',wndsVl.size()) #Debug.
    
    tbCtr=0 #已经载入的标签页数量计数。
    
    wndsVl.each do |crtWnd|
      crtTbs=crtWnd['tabs'] #获取标签页元素的值。
      
      #一个个标签页地处理：
      pp('tabs size:',crtTbs.size()) #Debug.
      crtTbs.each do |crtTb|
        crtEtrs=crtTb['entries'] #获取条目列表。
        
        crtIdx=crtTb['index'] #获取下标。
        
        if crtIdx #存在index元素。
          crtEnt=crtEtrs[crtIdx-1] #获取当前条目。
          
          crtUrl=crtEnt['url'] #获取URL。
          
          
          crtUrl=URI.decode(crtUrl) #将百分号编码解码。
          
          crtTtl=crtEnt['title'] #获取标题。
          
        else #不存在index元素，则表示该标签页是一个空标签页。
          crtUrl='' #空白URL。
          crtTtl='' #空白标题。
          
        end
        
                  #打开相应的标签页：
          crtTbWdgt=SWebPageWidget.new() #创建一个页面部件。
          crtTbWdgt.setBrowserWindow(self) #设置窗口的指针。
          connect(crtTbWdgt,SIGNAL('shouldOpenNewTab()'),self,SLOT('openNewTab()')) #要求打开空白标签页，则打开一个。
          connect(crtTbWdgt,SIGNAL('titleChanged(QString)'),self,SLOT('changeTabText(QString)')) #标题变化，则修改对应标签页的标题。
          connect(crtTbWdgt,SIGNAL('iconChanged(QIcon)'),self,SLOT('changeTabIcon(QIcon)')) #图标变化，则修改对应标签页的图标。
          @pgTbs.addTab(crtTbWdgt,crtTtl) #添加标签页。
          @pgTbs.setTabToolTip(tbCtr,crtTtl) #设置标签页的悬停提示。
          crtTbWdgt.setUrl(crtUrl) #设置URL。

        
          tbCtr+=1 #已经载入的标签页数计数。     
          
      end #crtTbs.each do |crtTb|
    end #wndsVl.each do |crtWnd|
    
    if (tbCtr==0) #未载入任何标签页。
      openNewTab() #打开新标签页。      
    end #if (tbCtr==0) #未载入任何标签页。
    
              if (@pgTbs.count()>1) #不止一个标签页。
              @pgTbs.setTabsClosable(true) #可关闭标签页。
              else #只有一个标签页。
                @pgTbs.setTabsClosable(false) #不可关闭标签页。
          end #if (@pgTbs.count()>1) #不止一个标签页。


  end #def loadSessionStore()
    
  def loadFromFirefoxSessionStore()
                #解析火狐配置目录下的profiles.ini文件，获取到配置文件目录名字：
            
    prflsIni=Qt::Dir::homePath()+'/.mozilla/firefox/profiles.ini' #配置文件索引。
    
    
    
    prflsStng=Qt::Settings.new(prflsIni,Qt::Settings::IniFormat) #profiles.ini文件的设置信息。
    
    pp prflsStng.allKeys() #Debug.
    
    prflPath=prflsStng.value('Profile0/Path').toString() #读取当前活跃配置信息的路径。
    
    pp prflPath #Debug.
    
    ssnStrJs=Qt::Dir::homePath()+'/.mozilla/firefox/'+prflPath+'/sessionstore.js' #会话记录的json文件。
    
    loadSessionStore(ssnStrJs) #从指定的JSON文件中读取会话信息。
    

  end #def loadFromFirefoxSessionStore()
  
  def loadFromOwnSessionStore()
    ssnStrJs=Qt::Dir::homePath()+'/.sbrowser/sessionstore.json' #会话记录的JSON文件名。
    
    loadSessionStore(ssnStrJs) #从指定的JSON文件中读取会话信息。
  end #def loadFromOwnSessionStore()
  
  def startLoad()
            # @wbPg.load(Qt::Url.new('http://www.eoeandroid.com/thread-10946-1-1.html')) #载入网页。
            
            
                 settings=Qt::Settings.new() #设置信息。s

     settings.beginGroup("SBrowserWindow") #主要窗口。
     
     
     f1stTmRun=settings.value("firstTimeRun",Qt::Variant.new(  true )  ).toBool() #读取配置信息，是否是第一次运行。
     
     flS=Qt::Variant.new(false) #假。
     if f1stTmRun #是第一次运行。
       settings.setValue("firstTimeRun",flS) #不再是第一次运行了。
       
       loadFromFirefoxSessionStore() #从火狐的会话中读取当前的各个标签页。
     else #不是第一次运行。
       loadFromOwnSessionStore() #从自己的会话中读取当前的各个标签页。
     end
     
     settings.endGroup() #关闭分组。
     settings.sync() #同步设置信息。
     
     
     @svSsnTmr.start() #启动保存会话信息的定时器。

            
  end #def startLoad()
end
