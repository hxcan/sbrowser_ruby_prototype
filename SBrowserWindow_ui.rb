<<<<<<< local
=begin
** Form generated from reading ui file 'SBrowserWindow_ui.ui'
**
** Created: 周六 2月 22 19:41:48 2014
**      by: Qt User Interface Compiler version 4.8.4
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
=end

require 'Qt4'

class Ui_SBrowserMainWindow
    attr_reader :action_Quit
    attr_reader :centralwidget
    attr_reader :verticalLayout
    attr_reader :pgstabWidget
    attr_reader :menubar
    attr_reader :menu_File
    attr_reader :menu_Navigate
    attr_reader :menu_Setting
    attr_reader :statusbar

    def setupUi(sBrowserMainWindow)
    if sBrowserMainWindow.objectName.nil?
        sBrowserMainWindow.objectName = "sBrowserMainWindow"
    end
    sBrowserMainWindow.resize(800, 600)
    @action_Quit = Qt::Action.new(sBrowserMainWindow)
    @action_Quit.objectName = "action_Quit"
    @centralwidget = Qt::Widget.new(sBrowserMainWindow)
    @centralwidget.objectName = "centralwidget"
    @verticalLayout = Qt::VBoxLayout.new(@centralwidget)
    @verticalLayout.spacing = 1
    @verticalLayout.margin = 1
    @verticalLayout.objectName = "verticalLayout"
    @pgstabWidget = Qt::TabWidget.new(@centralwidget)
    @pgstabWidget.objectName = "pgstabWidget"

    @verticalLayout.addWidget(@pgstabWidget)

    sBrowserMainWindow.centralWidget = @centralwidget
    @menubar = Qt::MenuBar.new(sBrowserMainWindow)
    @menubar.objectName = "menubar"
    @menubar.geometry = Qt::Rect.new(0, 0, 800, 23)
    @menu_File = Qt::Menu.new(@menubar)
    @menu_File.objectName = "menu_File"
    @menu_Navigate = Qt::Menu.new(@menubar)
    @menu_Navigate.objectName = "menu_Navigate"
    @menu_Setting = Qt::Menu.new(@menubar)
    @menu_Setting.objectName = "menu_Setting"
    sBrowserMainWindow.setMenuBar(@menubar)
    @statusbar = Qt::StatusBar.new(sBrowserMainWindow)
    @statusbar.objectName = "statusbar"
    sBrowserMainWindow.statusBar = @statusbar

    @menubar.addAction(@menu_File.menuAction())
    @menubar.addAction(@menu_Navigate.menuAction())
    @menubar.addAction(@menu_Setting.menuAction())
    @menu_File.addAction(@action_Quit)

    retranslateUi(sBrowserMainWindow)
    Qt::Object.connect(@action_Quit, SIGNAL('triggered()'), sBrowserMainWindow, SLOT('close()'))

    Qt::MetaObject.connectSlotsByName(sBrowserMainWindow)
    end # setupUi

    def setup_ui(sBrowserMainWindow)
        setupUi(sBrowserMainWindow)
    end

    def retranslateUi(sBrowserMainWindow)
    sBrowserMainWindow.windowTitle = Qt::Application.translate("SBrowserMainWindow", "StupidBeauty Browser", nil, Qt::Application::UnicodeUTF8)
    @action_Quit.text = Qt::Application.translate("SBrowserMainWindow", "&Quit", nil, Qt::Application::UnicodeUTF8)
    @action_Quit.shortcut = Qt::Application.translate("SBrowserMainWindow", "Ctrl+Q", nil, Qt::Application::UnicodeUTF8)
    @menu_File.title = Qt::Application.translate("SBrowserMainWindow", "&File", nil, Qt::Application::UnicodeUTF8)
    @menu_Navigate.title = Qt::Application.translate("SBrowserMainWindow", "&Navigate", nil, Qt::Application::UnicodeUTF8)
    @menu_Setting.title = Qt::Application.translate("SBrowserMainWindow", "&Setting", nil, Qt::Application::UnicodeUTF8)
    end # retranslateUi

    def retranslate_ui(sBrowserMainWindow)
        retranslateUi(sBrowserMainWindow)
    end

end

module Ui
    class SBrowserMainWindow < Ui_SBrowserMainWindow
    end
end  # module Ui

if $0 == __FILE__
    a = Qt::Application.new(ARGV)
    u = Ui_SBrowserMainWindow.new
    w = Qt::MainWindow.new
    u.setupUi(w)
    w.show
    a.exec
end
=======
=begin
** Form generated from reading ui file 'SBrowserWindow_ui.ui'
**
** Created: 周三 2月 19 14:08:52 2014
**      by: Qt User Interface Compiler version 4.8.4
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
=end

require 'Qt4'

class Ui_SBrowserMainWindow
    attr_reader :action_Quit
    attr_reader :centralwidget
    attr_reader :verticalLayout
    attr_reader :pgstabWidget
    attr_reader :menubar
    attr_reader :menu_File
    attr_reader :menu_Navigate
    attr_reader :menu_Setting
    attr_reader :statusbar

    def setupUi(sBrowserMainWindow)
    if sBrowserMainWindow.objectName.nil?
        sBrowserMainWindow.objectName = "sBrowserMainWindow"
    end
    sBrowserMainWindow.resize(800, 600)
    @action_Quit = Qt::Action.new(sBrowserMainWindow)
    @action_Quit.objectName = "action_Quit"
    @centralwidget = Qt::Widget.new(sBrowserMainWindow)
    @centralwidget.objectName = "centralwidget"
    @verticalLayout = Qt::VBoxLayout.new(@centralwidget)
    @verticalLayout.spacing = 1
    @verticalLayout.margin = 1
    @verticalLayout.objectName = "verticalLayout"
    @pgstabWidget = Qt::TabWidget.new(@centralwidget)
    @pgstabWidget.objectName = "pgstabWidget"

    @verticalLayout.addWidget(@pgstabWidget)

    sBrowserMainWindow.centralWidget = @centralwidget
    @menubar = Qt::MenuBar.new(sBrowserMainWindow)
    @menubar.objectName = "menubar"
    @menubar.geometry = Qt::Rect.new(0, 0, 800, 23)
    @menu_File = Qt::Menu.new(@menubar)
    @menu_File.objectName = "menu_File"
    @menu_Navigate = Qt::Menu.new(@menubar)
    @menu_Navigate.objectName = "menu_Navigate"
    @menu_Setting = Qt::Menu.new(@menubar)
    @menu_Setting.objectName = "menu_Setting"
    sBrowserMainWindow.setMenuBar(@menubar)
    @statusbar = Qt::StatusBar.new(sBrowserMainWindow)
    @statusbar.objectName = "statusbar"
    sBrowserMainWindow.statusBar = @statusbar

    @menubar.addAction(@menu_File.menuAction())
    @menubar.addAction(@menu_Navigate.menuAction())
    @menubar.addAction(@menu_Setting.menuAction())
    @menu_File.addAction(@action_Quit)

    retranslateUi(sBrowserMainWindow)
    Qt::Object.connect(@action_Quit, SIGNAL('triggered()'), sBrowserMainWindow, SLOT('close()'))

    Qt::MetaObject.connectSlotsByName(sBrowserMainWindow)
    end # setupUi

    def setup_ui(sBrowserMainWindow)
        setupUi(sBrowserMainWindow)
    end

    def retranslateUi(sBrowserMainWindow)
    sBrowserMainWindow.windowTitle = Qt::Application.translate("SBrowserMainWindow", "StupidBeauty Browser", nil, Qt::Application::UnicodeUTF8)
    @action_Quit.text = Qt::Application.translate("SBrowserMainWindow", "&Quit", nil, Qt::Application::UnicodeUTF8)
    @action_Quit.shortcut = Qt::Application.translate("SBrowserMainWindow", "Ctrl+Q", nil, Qt::Application::UnicodeUTF8)
    @menu_File.title = Qt::Application.translate("SBrowserMainWindow", "&File", nil, Qt::Application::UnicodeUTF8)
    @menu_Navigate.title = Qt::Application.translate("SBrowserMainWindow", "&Navigate", nil, Qt::Application::UnicodeUTF8)
    @menu_Setting.title = Qt::Application.translate("SBrowserMainWindow", "&Setting", nil, Qt::Application::UnicodeUTF8)
    end # retranslateUi

    def retranslate_ui(sBrowserMainWindow)
        retranslateUi(sBrowserMainWindow)
    end

end

module Ui
    class SBrowserMainWindow < Ui_SBrowserMainWindow
    end
end  # module Ui

if $0 == __FILE__
    a = Qt::Application.new(ARGV)
    u = Ui_SBrowserMainWindow.new
    w = Qt::MainWindow.new
    u.setupUi(w)
    w.show
    a.exec
end
>>>>>>> other
