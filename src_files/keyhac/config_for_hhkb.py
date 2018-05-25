import sys
import os
import datetime

import pyauto
from keyhac import *

from abc import *


def configure(keymap):

    # --------------------------------------------------------------------
    # Text editer setting for editting config.py file

    # Setting with program file path (Simple usage)
    if 1:
        keymap.editor = "notepad.exe"

    # Setting with callable object (Advanced usage)
    if 0:
        def editor(path):
            shellExecute( None, "notepad.exe", '"%s"'% path, "" )
        keymap.editor = editor

    # --------------------------------------------------------------------
    # Customizing the display

    # Font
    keymap.setFont( "MS Gothic", 12 )

    # Theme
    keymap.setTheme("black")

    # --------------------------------------------------------------------

    # Simple key replacement
    #keymap.replaceKey( "LWin", 235 )
    #keymap.replaceKey( "RWin", 255 )

    ## User modifier key definition
    #keymap.defineModifier( 235, "User0" )

    ## Global keymap which affects any windows
    if 1:
        keymap_global = keymap.defineWindowKeymap()

    #    # USER0-Up/Down/Left/Right : Move active window by 10 pixel unit
    #    keymap_global[ "U0-Left"  ] = keymap.MoveWindowCommand( -10, 0 )
    #    keymap_global[ "U0-Right" ] = keymap.MoveWindowCommand( +10, 0 )
    #    keymap_global[ "U0-Up"    ] = keymap.MoveWindowCommand( 0, -10 )
    #    keymap_global[ "U0-Down"  ] = keymap.MoveWindowCommand( 0, +10 )

    #    # USER0-Shift-Up/Down/Left/Right : Move active window by 1 pixel unit
    #    keymap_global[ "U0-S-Left"  ] = keymap.MoveWindowCommand( -1, 0 )
    #    keymap_global[ "U0-S-Right" ] = keymap.MoveWindowCommand( +1, 0 )
    #    keymap_global[ "U0-S-Up"    ] = keymap.MoveWindowCommand( 0, -1 )
    #    keymap_global[ "U0-S-Down"  ] = keymap.MoveWindowCommand( 0, +1 )

    #    # USER0-Ctrl-Up/Down/Left/Right : Move active window to screen edges
    #    keymap_global[ "U0-C-Left"  ] = keymap.MoveWindowToMonitorEdgeCommand(0)
    #    keymap_global[ "U0-C-Right" ] = keymap.MoveWindowToMonitorEdgeCommand(2)
    #    keymap_global[ "U0-C-Up"    ] = keymap.MoveWindowToMonitorEdgeCommand(1)
    #    keymap_global[ "U0-C-Down"  ] = keymap.MoveWindowToMonitorEdgeCommand(3)

    #    # Clipboard history related
    #    keymap_global[ "C-S-Z"   ] = keymap.command_ClipboardList     # Open the clipboard history list
    #    keymap_global[ "C-S-X"   ] = keymap.command_ClipboardRotate   # Move the most recent history to tail
    #    keymap_global[ "C-S-A-X" ] = keymap.command_ClipboardRemove   # Remove the most recent history
    #    keymap.quote_mark = "> "                                      # Mark for quote pasting

    #    # Keyboard macro
    #    keymap_global[ "U0-0" ] = keymap.command_RecordToggle
    #    keymap_global[ "U0-1" ] = keymap.command_RecordStart
    #    keymap_global[ "U0-2" ] = keymap.command_RecordStop
    #    keymap_global[ "U0-3" ] = keymap.command_RecordPlay
    #    keymap_global[ "U0-4" ] = keymap.command_RecordClear


    ## USER0-F1 : Test of launching application
    #if 1:
    #    keymap_global[ "U0-F1" ] = keymap.ShellExecuteCommand( None, "notepad.exe", "", "" )


    ## USER0-F2 : Test of sub thread execution using JobQueue/JobItem
    #if 1:
    #    def command_JobTest():

    #        def jobTest(job_item):
    #            shellExecute( None, "notepad.exe", "", "" )

    #        def jobTestFinished(job_item):
    #            print( "Done." )

    #        job_item = JobItem( jobTest, jobTestFinished )
    #        JobQueue.defaultQueue().enqueue(job_item)

    #    keymap_global[ "U0-F2" ] = command_JobTest


    ## Test of Cron (periodic sub thread procedure)
    #if 0:
    #    def cronPing(cron_item):
    #        os.system( "ping -n 3 www.google.com" )

    #    cron_item = CronItem( cronPing, 3.0 )
    #    CronTable.defaultCronTable().add(cron_item)


    ## USER0-F : Activation of specific window
    #if 1:
    #    keymap_global[ "U0-F" ] = keymap.ActivateWindowCommand( "cfiler.exe", "CfilerWindowClass" )


    ## USER0-E : Activate specific window or launch application if the window doesn't exist
    #if 1:
    #    def command_ActivateOrExecuteNotepad():
    #        wnd = Window.find( "Notepad", None )
    #        if wnd:
    #            if wnd.isMinimized():
    #                wnd.restore()
    #            wnd = wnd.getLastActivePopup()
    #            wnd.setForeground()
    #        else:
    #            executeFunc = keymap.ShellExecuteCommand( None, "notepad.exe", "", "" )
    #            executeFunc()

    #    keymap_global[ "U0-E" ] = command_ActivateOrExecuteNotepad


    ## Ctrl-Tab : Switching between console related windows
    #if 1:

    #    def isConsoleWindow(wnd):
    #        if wnd.getClassName() in ("PuTTY","MinTTY","CkwWindowClass"):
    #            return True
    #        return False

    #    keymap_console = keymap.defineWindowKeymap( check_func=isConsoleWindow )

    #    def command_SwitchConsole():

    #        root = pyauto.Window.getDesktop()
    #        last_console = None

    #        wnd = root.getFirstChild()
    #        while wnd:
    #            if isConsoleWindow(wnd):
    #                last_console = wnd
    #            wnd = wnd.getNext()

    #        if last_console:
    #            last_console.setForeground()

    #    keymap_console[ "C-TAB" ] = command_SwitchConsole


    ## USER0-Space : Application launcher using custom list window
    #if 1:
    #    def command_PopApplicationList():

    #        # If the list window is already opened, just close it
    #        if keymap.isListWindowOpened():
    #            keymap.cancelListWindow()
    #            return

    #        def popApplicationList():

    #            applications = [
    #                ( "Notepad", keymap.ShellExecuteCommand( None, "notepad.exe", "", "" ) ),
    #                ( "Paint", keymap.ShellExecuteCommand( None, "mspaint.exe", "", "" ) ),
    #            ]

    #            websites = [
    #                ( "Google", keymap.ShellExecuteCommand( None, "https://www.google.co.jp/", "", "" ) ),
    #                ( "Facebook", keymap.ShellExecuteCommand( None, "https://www.facebook.com/", "", "" ) ),
    #                ( "Twitter", keymap.ShellExecuteCommand( None, "https://twitter.com/", "", "" ) ),
    #            ]

    #            listers = [
    #                ( "App",     cblister_FixedPhrase(applications) ),
    #                ( "WebSite", cblister_FixedPhrase(websites) ),
    #            ]

    #            item, mod = keymap.popListWindow(listers)

    #            if item:
    #                item[1]()

    #        # Because the blocking procedure cannot be executed in the key-hook,
    #        # delayed-execute the procedure by delayedCall().
    #        keymap.delayedCall( popApplicationList, 0 )

    #    keymap_global[ "U0-Space" ] = command_PopApplicationList


    ## USER0-Alt-Up/Down/Left/Right/Space/PageUp/PageDown : Virtul mouse operation by keyboard
    #if 1:
    #    keymap_global[ "U0-A-Left"  ] = keymap.MouseMoveCommand(-10,0)
    #    keymap_global[ "U0-A-Right" ] = keymap.MouseMoveCommand(10,0)
    #    keymap_global[ "U0-A-Up"    ] = keymap.MouseMoveCommand(0,-10)
    #    keymap_global[ "U0-A-Down"  ] = keymap.MouseMoveCommand(0,10)
    #    keymap_global[ "D-U0-A-Space" ] = keymap.MouseButtonDownCommand('left')
    #    keymap_global[ "U-U0-A-Space" ] = keymap.MouseButtonUpCommand('left')
    #    keymap_global[ "U0-A-PageUp" ] = keymap.MouseWheelCommand(1.0)
    #    keymap_global[ "U0-A-PageDown" ] = keymap.MouseWheelCommand(-1.0)
    #    keymap_global[ "U0-A-Home" ] = keymap.MouseHorizontalWheelCommand(-1.0)
    #    keymap_global[ "U0-A-End" ] = keymap.MouseHorizontalWheelCommand(1.0)


    ## Execute the System commands by sendMessage
    #if 1:
    #    def close():
    #        wnd = keymap.getTopLevelWindow()
    #        wnd.sendMessage( WM_SYSCOMMAND, SC_CLOSE )

    #    def screenSaver():
    #        wnd = keymap.getTopLevelWindow()
    #        wnd.sendMessage( WM_SYSCOMMAND, SC_SCREENSAVE )

    #    keymap_global[ "U0-C" ] = close              # Close the window
    #    keymap_global[ "U0-S" ] = screenSaver        # Start the screen-saver


    ## Test of text input
    #if 1:
    #    keymap_global[ "U0-H" ] = keymap.InputTextCommand( "Hello / こんにちは" )


    ## For Edit box, assigning Delete to C-D, etc
    #if 1:
    #    keymap_edit = keymap.defineWindowKeymap( class_name="Edit" )

    #    keymap_edit[ "C-D" ] = "Delete"              # Delete
    #    keymap_edit[ "C-H" ] = "Back"                # Backspace
    #    keymap_edit[ "C-K" ] = "S-End","C-X"         # Removing following text




    ## Customizing clipboard history list
    #if 1:
    #    # Enable clipboard monitoring hook (Default:Enabled)
    #    keymap.clipboard_history.enableHook(True)

    #    # Maximum number of clipboard history (Default:1000)
    #    keymap.clipboard_history.maxnum = 1000

    #    # Total maximum size of clipboard history (Default:10MB)
    #    keymap.clipboard_history.quota = 10*1024*1024

    #    # Fixed phrases
    #    fixed_items = [
    #        ( "name@server.net",     "name@server.net" ),
    #        ( "Address",             "San Francisco, CA 94128" ),
    #        ( "Phone number",        "03-4567-8901" ),
    #    ]

    #    # Return formatted date-time string
    #    def dateAndTime(fmt):
    #        def _dateAndTime():
    #            return datetime.datetime.now().strftime(fmt)
    #        return _dateAndTime

    #    # Date-time
    #    datetime_items = [
    #        ( "YYYY/MM/DD HH:MM:SS",   dateAndTime("%Y/%m/%d %H:%M:%S") ),
    #        ( "YYYY/MM/DD",            dateAndTime("%Y/%m/%d") ),
    #        ( "HH:MM:SS",              dateAndTime("%H:%M:%S") ),
    #        ( "YYYYMMDD_HHMMSS",       dateAndTime("%Y%m%d_%H%M%S") ),
    #        ( "YYYYMMDD",              dateAndTime("%Y%m%d") ),
    #        ( "HHMMSS",                dateAndTime("%H%M%S") ),
    #    ]

    #    # Add quote mark to current clipboard contents
    #    def quoteClipboardText():
    #        s = getClipboardText()
    #        lines = s.splitlines(True)
    #        s = ""
    #        for line in lines:
    #            s += keymap.quote_mark + line
    #        return s

    #    # Indent current clipboard contents
    #    def indentClipboardText():
    #        s = getClipboardText()
    #        lines = s.splitlines(True)
    #        s = ""
    #        for line in lines:
    #            if line.lstrip():
    #                line = " " * 4 + line
    #            s += line
    #        return s

    #    # Unindent current clipboard contents
    #    def unindentClipboardText():
    #        s = getClipboardText()
    #        lines = s.splitlines(True)
    #        s = ""
    #        for line in lines:
    #            for i in range(4+1):
    #                if i>=len(line) : break
    #                if line[i]=='\t':
    #                    i+=1
    #                    break
    #                if line[i]!=' ':
    #                    break
    #            s += line[i:]
    #        return s

    #    full_width_chars = "ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ！”＃＄％＆’（）＊＋，?．／：；＜＝＞？＠［￥］＾＿‘｛｜｝～０１２３４５６７８９　"
    #    half_width_chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!\"#$%&'()*+,-./:;<=>?@[\]^_`{|}～0123456789 "

    #    # Convert to half-with characters
    #    def toHalfWidthClipboardText():
    #        s = getClipboardText()
    #        s = s.translate(str.maketrans(full_width_chars,half_width_chars))
    #        return s

    #    # Convert to full-with characters
    #    def toFullWidthClipboardText():
    #        s = getClipboardText()
    #        s = s.translate(str.maketrans(half_width_chars,full_width_chars))
    #        return s

    #    # Save the clipboard contents as a file in Desktop directory
    #    def command_SaveClipboardToDesktop():

    #        text = getClipboardText()
    #        if not text: return

    #        # Convert to utf-8 / CR-LF
    #        utf8_bom = b"\xEF\xBB\xBF"
    #        text = text.replace("\r\n","\n")
    #        text = text.replace("\r","\n")
    #        text = text.replace("\n","\r\n")
    #        text = text.encode( encoding="utf-8" )

    #        # Save in Desktop directory
    #        fullpath = os.path.join( getDesktopPath(), datetime.datetime.now().strftime("clip_%Y%m%d_%H%M%S.txt") )
    #        fd = open( fullpath, "wb" )
    #        fd.write(utf8_bom)
    #        fd.write(text)
    #        fd.close()

    #        # Open by the text editor
    #        keymap.editTextFile(fullpath)

    #    # Menu item list
    #    other_items = [
    #        ( "Quote clipboard",            quoteClipboardText ),
    #        ( "Indent clipboard",           indentClipboardText ),
    #        ( "Unindent clipboard",         unindentClipboardText ),
    #        ( "",                           None ),
    #        ( "To Half-Width",              toHalfWidthClipboardText ),
    #        ( "To Full-Width",              toFullWidthClipboardText ),
    #        ( "",                           None ),
    #        ( "Save clipboard to Desktop",  command_SaveClipboardToDesktop ),
    #        ( "",                           None ),
    #        ( "Edit config.py",             keymap.command_EditConfig ),
    #        ( "Reload config.py",           keymap.command_ReloadConfig ),
    #    ]

    #    # Clipboard history list extensions
    #    keymap.cblisters += [
    #        ( "Fixed phrase", cblister_FixedPhrase(fixed_items) ),
    #        ( "Date-time", cblister_FixedPhrase(datetime_items) ),
    #        ( "Others", cblister_FixedPhrase(other_items) ),
    #    ]
    #        
        ## My Functions
        #if 1:
        #    class key_op(metaclass=ABCMeta):
        #        def __init__(self, keys):
        #            self.keys = keys

        #        @abstractmethod
        #        def to_list(self, codes):
        #            pass

        #        @abstractmethod
        #        def to_code(self, key):
        #            pass

        #        def print(codes):

        #            def closure(self):
        #                for key in self.to_list(self.keys):
        #                    Input.send([pyauto.KeyDown(to_code(key))])
        #            return closure

        #        def to_list():
        #            pass

        #        def closure():
        #            lists = self.to_list(anythings)
        #            Input.send([pyauto.KeyDown(hoge)
        #        return closure

        #    def put_key(keys):
        #        def closure():
        #            for key in list(keys):
        #                Input.send([pyauto.KeyDown(ord(key) - 32)])
        #        return closure

        #    def put_code(codes):
        #        def closure():
        #            for code in codes:
        #                Input.send([pyauto.KeyDown(code)])
        #        return closure

    # Config For All
    if 1:
        #keymap.defineModifier("Capslock", "User1" )
        #for any in range(ord("A"), ord("Z")):
        #    keymap_global["U1-" + chr(any)] = "C-" + chr(any)
        keymap_global["C-D"] = "A-F4"
        keymap_global["C-Q"] = "C-W"
        keymap_global["C-Tab"] = "Win-F12"
        keymap_global["A-J"] = "A-D"
        keymap_global["A-K"] = "A-S-D"
        keymap_global["A-A"] = "A-S-D"
        keymap_global["LS-LCtrl"] = "S-(240)"

    # Config For Chrome
    if 1:
        keymap_chrome = keymap.defineWindowKeymap(exe_name="chrome.exe")
        #for any in range(ord("A"), ord("Z")):
        #    keymap_chrome["C-" + chr(any)] = "C-" + chr(any)
        keymap_chrome["C-A"] = "Home"
        keymap_chrome["C-E"] = "End"
        keymap_chrome["C-U"] = "S-Home", "Delete"
        keymap_chrome["C-F"] = "Right"
        keymap_chrome["C-B"] = "Left"
        keymap_chrome["A-A"] = "S-Home"
        keymap_chrome["A-E"] = "S-End"
        keymap_chrome["A-F"] = "S-Right"
        keymap_chrome["A-B"] = "S-Left"
        keymap_chrome["C-S-F"] = "C-Right"
        keymap_chrome["C-S-B"] = "C-Left"
        keymap_chrome["C-X"] = "A-Right"
        keymap_chrome["C-Z"] = "A-Left"
        keymap_chrome["C-W"] = "C-Pageup"
        keymap_chrome["C-R"] = "C-Pagedown"
        keymap_chrome["C-Q"] = "C-W"
        keymap_chrome["C-J"] = "Down"
        keymap_chrome["C-K"] = "Up"
        keymap_chrome["C-D"] = "D"
        keymap_chrome["C-Space"] = "Down", "Down", "Down", "Down", "Down"
        keymap_chrome["C-S-Space"] = "Up", "Up", "Up", "Up", "Up"

    # Config For Notepad
    if 1:
        keymap_notepad = keymap.defineWindowKeymap( exe_name="notepad.exe", class_name="Edit" )
        keymap_notepad["C-A"] = "Home"
        keymap_notepad["C-E"] = "End"
        keymap_notepad["C-U"] = "S-Home", "Delete"
        keymap_notepad["C-F"] = "Right"
        keymap_notepad["C-B"] = "Left"
        keymap_notepad["A-A"] = "S-Home"
        keymap_notepad["A-E"] = "S-End"
        keymap_notepad["A-F"] = "S-Right"
        keymap_notepad["A-B"] = "S-Left"
        keymap_notepad["C-S-F"] = "C-Right"
        keymap_notepad["C-H"] = "C-Pageup"
        keymap_notepad["C-L"] = "C-Pagedown"
        keymap_notepad["C-J"] = "Down"
        keymap_notepad["C-K"] = "Up"
        #def hoge():
        #    f = put_keys("hoge")
        #    f()
        #    f = put_keys("fuga")
        #    f()
        #keymap_notepad["C-X"] = hoge

    if 1:
        keymap_teraterm = keymap.defineWindowKeymap(exe_name="ttermpro.exe")
        keymap_teraterm["C-D"] = "C-D"

