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
            shellxecute( None, "notepad.exe", '"%s"'% path, "" )
        keymap.editor = editor

    # --------------------------------------------------------------------
    # Customizing the display

    # ont
    keymap.setont( "MS Gothic", 12 )

    # Theme
    keymap.setTheme("black")

    # --------------------------------------------------------------------

    # Simple key replacement
    #keymap.replaceKey( "LWin", 235 )
    #keymap.replaceKey( "RWin", 255 )

    ## ser modifier key definition
    #keymap.defineModifier( 235, "ser0" )

    ## Global keymap which affects any windows
    if 1:
        keymap_global = keymap.defineWindowKeymap()

    #    # SR0-p/Down/Left/Right : Move active window by 10 pixel unit
    #    keymap_global[ "0-Left"  ] = keymap.MoveWindowCommand( -10, 0 )
    #    keymap_global[ "0-Right" ] = keymap.MoveWindowCommand( 10, 0 )
    #    keymap_global[ "0-p"    ] = keymap.MoveWindowCommand( 0, -10 )
    #    keymap_global[ "0-Down"  ] = keymap.MoveWindowCommand( 0, 10 )

    #    # SR0-Shift-p/Down/Left/Right : Move active window by 1 pixel unit
    #    keymap_global[ "0-S-Left"  ] = keymap.MoveWindowCommand( -1, 0 )
    #    keymap_global[ "0-S-Right" ] = keymap.MoveWindowCommand( 1, 0 )
    #    keymap_global[ "0-S-p"    ] = keymap.MoveWindowCommand( 0, -1 )
    #    keymap_global[ "0-S-Down"  ] = keymap.MoveWindowCommand( 0, 1 )

    #    # SR0-Ctrl-p/Down/Left/Right : Move active window to screen edges
    #    keymap_global[ "0-C-Left"  ] = keymap.MoveWindowToMonitordgeCommand(0)
    #    keymap_global[ "0-C-Right" ] = keymap.MoveWindowToMonitordgeCommand(2)
    #    keymap_global[ "0-C-p"    ] = keymap.MoveWindowToMonitordgeCommand(1)
    #    keymap_global[ "0-C-Down"  ] = keymap.MoveWindowToMonitordgeCommand(3)

    #    # Clipboard history related
    #    keymap_global[ "C-S-Z"   ] = keymap.command_ClipboardList     # Open the clipboard history list
    #    keymap_global[ "C-S-X"   ] = keymap.command_ClipboardRotate   # Move the most recent history to tail
    #    keymap_global[ "C-S-A-X" ] = keymap.command_ClipboardRemove   # Remove the most recent history
    #    keymap.quote_mark = " "                                      # Mark for quote pasting

    #    # Keyboard macro
    #    keymap_global[ "0-0" ] = keymap.command_RecordToggle
    #    keymap_global[ "0-1" ] = keymap.command_RecordStart
    #    keymap_global[ "0-2" ] = keymap.command_RecordStop
    #    keymap_global[ "0-3" ] = keymap.command_RecordPlay
    #    keymap_global[ "0-4" ] = keymap.command_RecordClear


    ## SR0-1 : Test of launching application
    #if 1:
    #    keymap_global[ "0-1" ] = keymap.ShellxecuteCommand( None, "notepad.exe", "", "" )


    ## SR0-2 : Test of sub thread execution using JobQueue/JobItem
    #if 1:
    #    def command_JobTest():

    #        def jobTest(job_item):
    #            shellxecute( None, "notepad.exe", "", "" )

    #        def jobTestinished(job_item):
    #            print( "Done." )

    #        job_item = JobItem( jobTest, jobTestinished )
    #        JobQueue.defaultQueue().enqueue(job_item)

    #    keymap_global[ "0-2" ] = command_JobTest


    ## Test of Cron (periodic sub thread procedure)
    #if 0:
    #    def cronPing(cron_item):
    #        os.system( "ping -n 3 www.google.com" )

    #    cron_item = CronItem( cronPing, 3.0 )
    #    CronTable.defaultCronTable().add(cron_item)


    ## SR0- : Activation of specific window
    #if 1:
    #    keymap_global[ "0-" ] = keymap.ActivateWindowCommand( "cfiler.exe", "CfilerWindowClass" )


    ## SR0- : Activate specific window or launch application if the window doesn't exist
    #if 1:
    #    def command_ActivateOrxecuteNotepad():
    #        wnd = Window.find( "Notepad", None )
    #        if wnd:
    #            if wnd.isMinimized():
    #                wnd.restore()
    #            wnd = wnd.getLastActivePopup()
    #            wnd.setoreground()
    #        else:
    #            executeunc = keymap.ShellxecuteCommand( None, "notepad.exe", "", "" )
    #            executeunc()

    #    keymap_global[ "0-" ] = command_ActivateOrxecuteNotepad


    ## Ctrl-Tab : Switching between console related windows
    #if 1:

    #    def isConsoleWindow(wnd):
    #        if wnd.getClassName() in ("PuTTY","MinTTY","CkwWindowClass"):
    #            return True
    #        return alse

    #    keymap_console = keymap.defineWindowKeymap( check_func=isConsoleWindow )

    #    def command_SwitchConsole():

    #        root = pyauto.Window.getDesktop()
    #        last_console = None

    #        wnd = root.getirstChild()
    #        while wnd:
    #            if isConsoleWindow(wnd):
    #                last_console = wnd
    #            wnd = wnd.getNext()

    #        if last_console:
    #            last_console.setoreground()

    #    keymap_console[ "C-TAB" ] = command_SwitchConsole


    ## SR0-Space : Application launcher using custom list window
    #if 1:
    #    def command_PopApplicationList():

    #        # If the list window is already opened, just close it
    #        if keymap.isListWindowOpened():
    #            keymap.cancelListWindow()
    #            return

    #        def popApplicationList():

    #            applications = [
    #                ( "Notepad", keymap.ShellxecuteCommand( None, "notepad.exe", "", "" ) ),
    #                ( "Paint", keymap.ShellxecuteCommand( None, "mspaint.exe", "", "" ) ),
    #            ]

    #            websites = [
    #                ( "Google", keymap.ShellxecuteCommand( None, "https://www.google.co.jp/", "", "" ) ),
    #                ( "acebook", keymap.ShellxecuteCommand( None, "https://www.facebook.com/", "", "" ) ),
    #                ( "Twitter", keymap.ShellxecuteCommand( None, "https://twitter.com/", "", "" ) ),
    #            ]

    #            listers = [
    #                ( "App",     cblister_ixedPhrase(applications) ),
    #                ( "WebSite", cblister_ixedPhrase(websites) ),
    #            ]

    #            item, mod = keymap.popListWindow(listers)

    #            if item:
    #                item[1]()

    #        # Because the blocking procedure cannot be executed in the key-hook,
    #        # delayed-execute the procedure by delayedCall().
    #        keymap.delayedCall( popApplicationList, 0 )

    #    keymap_global[ "0-Space" ] = command_PopApplicationList


    ## SR0-Alt-p/Down/Left/Right/Space/Pagep/PageDown : Virtul mouse operation by keyboard
    #if 1:
    #    keymap_global[ "0-A-Left"  ] = keymap.MouseMoveCommand(-10,0)
    #    keymap_global[ "0-A-Right" ] = keymap.MouseMoveCommand(10,0)
    #    keymap_global[ "0-A-p"    ] = keymap.MouseMoveCommand(0,-10)
    #    keymap_global[ "0-A-Down"  ] = keymap.MouseMoveCommand(0,10)
    #    keymap_global[ "D-0-A-Space" ] = keymap.MouseButtonDownCommand('left')
    #    keymap_global[ "-0-A-Space" ] = keymap.MouseButtonpCommand('left')
    #    keymap_global[ "0-A-Pagep" ] = keymap.MouseWheelCommand(1.0)
    #    keymap_global[ "0-A-PageDown" ] = keymap.MouseWheelCommand(-1.0)
    #    keymap_global[ "0-A-Home" ] = keymap.MouseHorizontalWheelCommand(-1.0)
    #    keymap_global[ "0-A-nd" ] = keymap.MouseHorizontalWheelCommand(1.0)


    ## xecute the System commands by sendMessage
    #if 1:
    #    def close():
    #        wnd = keymap.getTopLevelWindow()
    #        wnd.sendMessage( WM_SYSCOMMAND, SC_CLOS )

    #    def screenSaver():
    #        wnd = keymap.getTopLevelWindow()
    #        wnd.sendMessage( WM_SYSCOMMAND, SC_SCRNSAV )

    #    keymap_global[ "0-C" ] = close              # Close the window
    #    keymap_global[ "0-S" ] = screenSaver        # Start the screen-saver


    ## Test of text input
    #if 1:
    #    keymap_global[ "0-H" ] = keymap.InputTextCommand( "Hello / こんにちは" )


    ## or dit box, assigning Delete to C-D, etc
    #if 1:
    #    keymap_edit = keymap.defineWindowKeymap( class_name="dit" )

    #    keymap_edit[ "C-D" ] = "Delete"              # Delete
    #    keymap_edit[ "C-H" ] = "Back"                # Backspace
    #    keymap_edit[ "C-K" ] = "S-nd","C-X"         # Removing following text




    ## Customizing clipboard history list
    #if 1:
    #    # nable clipboard monitoring hook (Default:nabled)
    #    keymap.clipboard_history.enableHook(True)

    #    # Maximum number of clipboard history (Default:1000)
    #    keymap.clipboard_history.maxnum = 1000

    #    # Total maximum size of clipboard history (Default:10MB)
    #    keymap.clipboard_history.quota = 10*1024*1024

    #    # ixed phrases
    #    fixed_items = [
    #        ( "name@server.net",     "name@server.net" ),
    #        ( "Address",             "San rancisco, CA 94128" ),
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
    #            s = keymap.quote_mark  line
    #        return s

    #    # Indent current clipboard contents
    #    def indentClipboardText():
    #        s = getClipboardText()
    #        lines = s.splitlines(True)
    #        s = ""
    #        for line in lines:
    #            if line.lstrip():
    #                line = " " * 4  line
    #            s = line
    #        return s

    #    # nindent current clipboard contents
    #    def unindentClipboardText():
    #        s = getClipboardText()
    #        lines = s.splitlines(True)
    #        s = ""
    #        for line in lines:
    #            for i in range(41):
    #                if i=len(line) : break
    #                if line[i]=='\t':
    #                    i=1
    #                    break
    #                if line[i]!=' ':
    #                    break
    #            s = line[i:]
    #        return s

    #    full_width_chars = "ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ！”＃＄％＆’（）＊＋，−．／：；＜＝＞？＠［￥］＾＿‘｛｜｝～０１２３４５６７８９　"
    #    half_width_chars = "abcdefghijklmnopqrstuvwxyzABCDGHIJKLMNOPQRSTVWXYZ!\"#$%&'()*,-./:;=?@[\]^_`{|}～0123456789 "

    #    # Convert to half-with characters
    #    def toHalfWidthClipboardText():
    #        s = getClipboardText()
    #        s = s.translate(str.maketrans(full_width_chars,half_width_chars))
    #        return s

    #    # Convert to full-with characters
    #    def toullWidthClipboardText():
    #        s = getClipboardText()
    #        s = s.translate(str.maketrans(half_width_chars,full_width_chars))
    #        return s

    #    # Save the clipboard contents as a file in Desktop directory
    #    def command_SaveClipboardToDesktop():

    #        text = getClipboardText()
    #        if not text: return

    #        # Convert to utf-8 / CR-L
    #        utf8_bom = b"\x\xBB\xB"
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
    #        keymap.editTextile(fullpath)

    #    # Menu item list
    #    other_items = [
    #        ( "Quote clipboard",            quoteClipboardText ),
    #        ( "Indent clipboard",           indentClipboardText ),
    #        ( "nindent clipboard",         unindentClipboardText ),
    #        ( "",                           None ),
    #        ( "To Half-Width",              toHalfWidthClipboardText ),
    #        ( "To ull-Width",              toullWidthClipboardText ),
    #        ( "",                           None ),
    #        ( "Save clipboard to Desktop",  command_SaveClipboardToDesktop ),
    #        ( "",                           None ),
    #        ( "dit config.py",             keymap.command_ditConfig ),
    #        ( "Reload config.py",           keymap.command_ReloadConfig ),
    #    ]

    #    # Clipboard history list extensions
    #    keymap.cblisters = [
    #        ( "ixed phrase", cblister_ixedPhrase(fixed_items) ),
    #        ( "Date-time", cblister_ixedPhrase(datetime_items) ),
    #        ( "Others", cblister_ixedPhrase(other_items) ),
    #    ]
    #        
        ## My unctions
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

    # Config or All
    if 1:
        import keyhac_keymap

        def get_code(key_str):
            """
            code = get_code("SLASH")
            """
            try:
                key_code = keyhac_keymap.KeyCondition.str_vk_table_common[key_str]
            except:
                key_code = keyhac_keymap.KeyCondition.str_vk_table_std[key_str]
            return key_code

        def put_keys(key_list):
            """
            keymap_hoge = putkeys(["A", "B", "SLASH"])
            """
            def closure():
                for key in key_list:
                    key_code = get_code(key)
                    Input.send([pyauto.Key(key_code)])

            return closure

        def put_str(chars):
            """
            keymap_hoge = putstr("HOGHOGGAGA")
            """
            def closure():
                for char in chars:
                    Input.send([pyauto.Char(char)])
            return closure

        def put_strln(chars):
            """
            keymap_hoge = putstr("HOGHOGGAGA")
            """
            def closure():
                f = put_str(chars)
                f()
                return_code = get_code("RTRN")
                Input.send([pyauto.Key(return_code)])
            return closure

        def put_codes(codes):
            """
            keymap_hoge = put_codes([65, 66, 67])
            """
            def closure():
                for code in codes:
                    Input.send([pyauto.Key(code)])
            return closure

        def u1_quote():
            Input.send([pyauto.Char("`")])
            #Input.send([pyauto.KeyDown(get_code("SHIT"))])
            #Input.send([pyauto.Key(get_code("CAPSLOCK"))])
            #Input.send([pyauto.Keyp(get_code("SHIT"))])
            #Input.send([pyauto.Key(get_code("BACKQOT"))])
            #Input.send([pyauto.KeyDown(get_code("SHIT"))])
            #Input.send([pyauto.Key(get_code("CAPSLOCK"))])
            #Input.send([pyauto.Keyp(get_code("SHIT"))])

        def s_quote():
            Input.send([pyauto.Char('"')])

        def quote():
            Input.send([pyauto.Char("'")])

        def s_plus():
            Input.send([pyauto.Char("")])

        def s_2():
            Input.send([pyauto.Char("@")])

        def s_3():
            Input.send([pyauto.Char("#")])

        def s_4():
            Input.send([pyauto.Char("$")])

        def s_5():
            Input.send([pyauto.Char("%")])

        def s_7():
            Input.send([pyauto.Char("&")])

        def s_8():
            Input.send([pyauto.Char("*")])

        def s_9():
            Input.send([pyauto.Char("(")])

        def s_0():
            Input.send([pyauto.Char(")")])

        def s_open_bracket():
            Input.send([pyauto.Char("{")])

        def s_close_bracket():
            Input.send([pyauto.Char("}")])

        def u1_open_bracket():
            Input.send([pyauto.Char("[")])

        def u1_close_bracket():
            Input.send([pyauto.Char("]")])

        def space():
            Input.send([pyauto.Char(" ")])

        def link_cmd():
            f = put_str("[](")
            f()
            left_code = get_code("LT")
            Input.send([pyauto.Key(left_code)]*2)

        def def_cmd(trigger, char):
            trigger[char] = keymap.defineMultiStrokeKeymap(char)
            return trigger[char]

        global tmp_cmd
        def make_tmp_cmd_update(chars, mark):
            def tmp_cmd_update(i):
                tmp_cmd = tmp_cmd  mark  chars[i]
            return tmp_cmd_update

        def make_set_cmd(keymap_class, trigger):
            """
            keymap_global["1-Space"] = keymap.defineMultiStrokeKeymap("1-Space")
            set_global_u1s_cmd = make_set_cmd(keymap_global, "1-Space")
            set_global_u1s_cmd(put_str("John"), "NAM")
            set_global_u1s_cmd(put_str("# "), "H1") # cmds_dict enable to survive this.
            set_global_u1s_cmd(put_str("## "), "H2")
            """
            cmds_dict = {}
            def set_cmd(func, cmd):
                cmd_length = len(cmd)
                cmd_chars = list(cmd)
                for i in range(cmd_length):
                    cmds_dict_key = cmd[:i1]
                    last_char = cmds_dict_key[-1]
                    if not cmds_dict_key in cmds_dict:
                        keymap_for_exec =  "keymap_class"  "[\""  trigger  "\"]"
                        for index in list(cmds_dict_key):
                            keymap_for_exec = keymap_for_exec  "[\""  index  "\"]"
                        if i == cmd_length-1:
                            exec_cmd = keymap_for_exec  " = func"
                        else:
                            exec_cmd = keymap_for_exec  " = keymap.defineMultiStrokeKeymap(\""  last_char  "\")"
                        exec(exec_cmd, globals(), {"keymap": keymap, "keymap_class": keymap_class, "func": func})
                        cmds_dict[cmds_dict_key] = 1 # Register key to list
                cmds_dict[cmd] = func
            return set_cmd

        keymap.defineModifier("Capslock", "ser1")
        keymap_global["1-Space"] = keymap.defineMultiStrokeKeymap("1-Space")
        for any in range(ord("A"), ord("Z")):
            keymap_global["1-"  chr(any)] = "C-"  chr(any)
        keymap_global["1-D"] = "A-4"
        keymap_global["1-Q"] = "C-W"
        keymap_global["A-J"] = "A-D"
        keymap_global["A-K"] = "A-S-D"

        set_global_u1s_cmd = make_set_cmd(keymap_global, "1-Space")
        set_global_u1s_cmd(put_str(os.getenv("NAM", "Please xport $NAM")), "NAM")
        set_global_u1s_cmd(put_str(os.getenv("ADDR", "Please xport $ADDR")), "ADDR")
        set_global_u1s_cmd(link_cmd, "LINK")
        set_global_u1s_cmd(put_strln("# "), "H1")
        set_global_u1s_cmd(put_strln("## "), "H2")
        set_global_u1s_cmd(put_strln("### "), "H3")
        keymap_global["S-3"] = s_3
        keymap_global["S-4"] = s_4
        keymap_global["S-5"] = s_5
        keymap_global["S-7"] = s_7
        keymap_global["S-8"] = s_8
        keymap_global["S-9"] = s_9
        keymap_global["S-0"] = s_0
        keymap_global["S-Plus"] = s_plus
        keymap_global["Quote"] = quote
        keymap_global["S-Quote"] = s_quote
        keymap_global["1-Quote"] = u1_quote
        keymap_global["S-OpenBracket"] = s_open_bracket
        keymap_global["S-CloseBracket"] = s_close_bracket
        keymap_global["1-OpenBracket"] = u1_open_bracket
        keymap_global["1-CloseBracket"] = u1_close_bracket

        # Config or Cursor
        keymap_global["1-A"] = "Home"
        keymap_global["1-"] = "nd"
        keymap_global["1-"] = "S-Home", "Delete"
        keymap_global["1-"] = "Right"
        keymap_global["1-B"] = "Left"
        keymap_global["1-S-"] = "C-Right"
        keymap_global["1-S-B"] = "C-Left"

        ## Test
        #def test():
        #    keymap.wnd.setImeStatus(0)
        #keymap_global["1-J"] = test


    # Config or Chrome
    if 1:
        keymap_chrome = keymap.defineWindowKeymap(exe_name="chrome.exe")
        #for any in range(ord("A"), ord("Z")):
        #    keymap_chrome["1-"  chr(any)] = "C-"  chr(any)
        keymap_chrome["A-A"] = "S-Home"
        keymap_chrome["A-"] = "S-nd"
        keymap_chrome["A-"] = "S-Right"
        keymap_chrome["A-B"] = "S-Left"
        keymap_chrome["1-H"] = "A-Left"
        keymap_chrome["1-L"] = "A-Right"
        keymap_chrome["1-W"] = "C-Pageup"
        keymap_chrome["1-R"] = "C-Pagedown"
        keymap_chrome["1-Q"] = "C-W"
        keymap_chrome["1-J"] = "Down"
        keymap_chrome["1-K"] = "p"
        keymap_chrome["1-S"] = "C-S-LButton"
        keymap_chrome["1-D"] = "C-D"
        keymap_chrome["1-Space"] = "Down", "Down", "Down", "Down", "Down"
        keymap_chrome["1-S-Space"] = "p", "p", "p", "p", "p"
        #keymap_chrome["Pagep"] = "p", "p", "p", "p", "p", "p", "p", "p", "p", "p", "p", "p", "p", "p"
        #keymap_chrome["PageDown"] = "Down", "Down", "Down", "Down", "Down", "Down", "Down", "Down", "Down", "Down", "Down", "Down", "Down", "Down"
        keymap_chrome["1-j"] = "C-BackSlash"
        keymap_chrome["1-o"] = "C-CloseBracket"
        keymap_chrome["1-i"] = "C-OpenBracket"

    # Config or Notepad
    if 1:
        keymap_notepad = keymap.defineWindowKeymap( exe_name="notepad.exe", class_name="dit" )
        keymap_notepad["1-A"] = "Home"
        keymap_notepad["1-"] = "nd"
        keymap_notepad["1-"] = "S-Home", "Delete"
        keymap_notepad["1-"] = "Right"
        keymap_notepad["1-B"] = "Left"
        keymap_notepad["A-A"] = "S-Home"
        keymap_notepad["A-"] = "S-nd"
        keymap_notepad["A-"] = "S-Right"
        keymap_notepad["A-B"] = "S-Left"
        keymap_notepad["1-S-"] = "C-Right"
        keymap_notepad["1-H"] = "C-Pageup"
        keymap_notepad["1-L"] = "C-Pagedown"
        keymap_notepad["1-J"] = "Down"
        keymap_notepad["1-K"] = "p"
        #def hoge():
        #    f = put_keys("hoge")
        #    f()
        #    f = put_keys("fuga")
        #    f()
        #keymap_notepad["1-X"] = hoge

    # Config or TeraTerm
    if 1:
        keymap_teraterm = keymap.defineWindowKeymap(exe_name="TTRMPRO.exe")
        keymap_teraterm["1-D"] = "C-D"
        def escape():
            esc_code = get_code("SCAP")
            Input.send([pyauto.Key(esc_code)])
            keymap.wnd.setImeStatus(0)
        keymap_teraterm["1-J"] = escape

        # Config or Cursor
        keymap_teraterm["1-A"] = "C-A"
        keymap_teraterm["1-"] = "C-"
        keymap_teraterm["1-"] = "C-"
        keymap_teraterm["1-"] = "C-"
        keymap_teraterm["1-B"] = "C-B"
        keymap_teraterm["1-S-"] = "C-S-"
        keymap_teraterm["1-S-B"] = "C-S-B"

    # Config or cmd
    if 1:
        keymap_teraterm = keymap.defineWindowKeymap(exe_name="cmd.exe")
        keymap_teraterm["1-D"] = "C-D"
        def escape():
            esc_code = get_code("SCAP")
            Input.send([pyauto.Key(esc_code)])
            keymap.wnd.setImeStatus(0)
        keymap_teraterm["1-J"] = escape

        # Config or Cursor
        keymap_teraterm["1-A"] = "C-A"
        keymap_teraterm["1-"] = "C-"
        keymap_teraterm["1-"] = "C-"
        keymap_teraterm["1-"] = "C-"
        keymap_teraterm["1-B"] = "C-B"
        keymap_teraterm["1-S-"] = "C-S-"
        keymap_teraterm["1-S-B"] = "C-S-B"

    # Config or cmd.exe
    if 1:
        keymap_cmd = keymap.defineWindowKeymap(exe_name="cmd.exe")
        keymap_cmd["1-D"] = "C-D"
