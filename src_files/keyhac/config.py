import time
import sys
import os
import datetime
import pyauto
from keyhac import *
from pyautogui import *

hhkb_flag = False
jp_flag = True

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

    # Define My Functions
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
            for key in key_list:
                key_code = get_code(key)
                Input.send([pyauto.Key(key_code)])

            return closure

        def put_key(key):
            """
            keymap_hoge["C-X"] = put_key("BACKSLASH")
            """
            key_code = get_code(key)
            Input.send([pyauto.Key(key_code)])

        def down_key(key):
            """
            keymap_hoge["C-X"] = down_key("BACKSLASH")
            """
            key_code = get_code(key)
            Input.send([pyauto.KeyDown(key_code)])

        def up_key(key):
            """
            keymap_hoge["C-X"] = up_key("BACKSLASH")
            """
            key_code = get_code(key)
            Input.send([pyauto.KeyUp(key_code)])

        def put_str(chars):
            """
            keymap_hoge = putstr("HOGEHOGEFUGAFUGA")
            """
            for char in chars:
                Input.send([pyauto.Char(char)])

        def put_strln(chars):
            """
            keymap_hoge = putstr("HOGEHOGEFUGAFUGA")
            """
            put_str(chars)
            return_code = get_code("RETURN")
            Input.send([pyauto.Key(return_code)])

        def put_codes(codes):
            """
            keymap_hoge = put_codes([65, 66, 67])
            """
            def closure():
                for code in codes:
                    Input.send([pyauto.Key(code)])
            return closure

        def link_cmd():
            put_str("[](")
            typewrite(["left"]*2)

        def def_cmd(trigger, char):
            trigger[char] = keymap.defineMultiStrokeKeymap(char)
            return trigger[char]

        global tmp_cmd
        def make_tmp_cmd_update(chars, mark):
            def tmp_cmd_update(i):
                tmp_cmd = tmp_cmd + mark + chars[i]
            return tmp_cmd_update

        def make_set_cmd(keymap_class, trigger):
            """
            keymap_global["C-Space"] = keymap.defineMultiStrokeKeymap("C-Space")
            set_global_cspace_cmd = make_set_cmd(keymap_global, "C-Space")
            set_global_cspace_cmd(put_str("John"), "NAME")
            set_global_cspace_cmd(put_str("# "), "H1") # cmds_dict enable to survive this.
            set_global_cspace_cmd(put_str("## "), "H2")
            """
            cmds_dict = {}
            def set_cmd(func, cmd):
                cmd_length = len(cmd)
                for i in range(cmd_length):
                    cmds_dict_key = cmd[:i+1]
                    last_char = cmds_dict_key[-1]
                    if not cmds_dict_key in cmds_dict:
                        keymap_for_exec =  "keymap_class" + "[\"" + trigger + "\"]"
                        for index in list(cmds_dict_key):
                            keymap_for_exec = keymap_for_exec + "[\"" + index + "\"]"
                        if i == cmd_length-1:
                            exec_cmd = keymap_for_exec + " = func"
                        else:
                            exec_cmd = keymap_for_exec + " = keymap.defineMultiStrokeKeymap(\"" + last_char + "\")"
                        #print("exec:", exec_cmd)
                        exec(exec_cmd, globals(), {"keymap": keymap, "keymap_class": keymap_class, "func": func})
                        cmds_dict[cmds_dict_key] = 1 # Register key to list
                cmds_dict[cmd] = func
            return set_cmd

        def jump_tab_name(window_name):
            down_key("CTRL")
            put_key("BACKSLASH")
            up_key("CTRL")
            typewrite(["alt", "alt"], interval=0.2)
            put_str(window_name)
            put_key("RETURN")
            typewrite(["alt", "alt"], interval=0.02)
            put_key("RETURN")

        def jump_tab_nr(nr):
            hotkey("ctrl", str(nr))

        def jump_window_nr(nr):
            hotkey("win", str(nr))
            typewrite(["return"])
            typewrite(["return"])
            typewrite(["return"])

        def jump_vwindow_nr(nr):
            down_key("LWIN")
            down_key("CTRL")
            put_key(str(nr))
            up_key("LWIN")
            up_key("CTRL")

        def jump_google_tab_nr(nr):
            jump_window_nr(1)
            typewrite(["return"])
            typewrite(["return"])
            typewrite(["return"])
            jump_tab_nr(nr)

        def escape():
            esc_code = get_code("ESCAPE")
            Input.send([pyauto.Key(esc_code)])
            time.sleep(0.1)
            keymap.wnd.setImeStatus(0)
	
        def ime_switch():
            status = keymap.wnd.getImeStatus()
            if status == 1:
                keymap.wnd.setImeStatus(0)
            elif status == 0:
                keymap.wnd.setImeStatus(1)

        def enter_jp_mode():
            status = keymap.wnd.getImeStatus()
            if status == 0:
                keymap.wnd.setImeStatus(1)

        def enter_en_mode():
            status = keymap.wnd.getImeStatus()
            if status == 1:
                keymap.wnd.setImeStatus(0)

        def i_jp():
            put_str("i")
            time.sleep(0.1)
            enter_jp_mode()

        def s_i_jp():
            put_str("I")
            time.sleep(0.1)
            enter_jp_mode()

        def o_jp():
            put_str("o")
            time.sleep(0.1)
            enter_jp_mode()

        def s_o_jp():
            put_str("O")
            time.sleep(0.1)
            enter_jp_mode()

        def a_jp():
            put_str("a")
            time.sleep(0.1)
            enter_jp_mode()

        def s_a_jp():
            put_str("A")
            time.sleep(0.1)
            enter_jp_mode()

        def c_jp():
            put_str("c")
            time.sleep(0.1)
            enter_jp_mode()

        def s_c_jp():
            put_str("C")
            time.sleep(0.1)
            enter_jp_mode()

        def m_jp():
            put_str("m")
            time.sleep(0.1)
            enter_jp_mode()

        def return_en():
            put_key("RETURN")
            time.sleep(0.1)
            enter_en_mode()

        def space_4():
            put_str("    ")
            put_key("RETURN")

        def insert_bold():
            put_str("**[]**")
            put_key("LEFT")
            put_key("LEFT")
            put_key("LEFT")

        def insert_ul():
            put_str("<UL><LI></UL>")
            typewrite(["return"] + ["left"]*5)

        def insert_li():
            put_str("<LI>")
            typewrite(["return"])

        def insert_h4():
            put_str("**<INS>**")
            typewrite(["return"] + ["left"]*2)

        def insert_ins():
            put_str("<INS></INS>")
            typewrite(["return"] + ["left"]*6)

        def initialize_keybind_alnum(keymap_class):
            for any in range(ord("A"), ord("Z")):
                keymap_class["C-" + chr(any)] = "C-" + chr(any)
            for any in range(ord("0"), ord("9")):
                keymap_class["C-" + chr(any)] = "C-" + chr(any)

        def initialize_keybind_shift(keymap_class):
            keymap_class["S-2"] = lambda:put_str("@")
            keymap_class["S-3"] = lambda:put_str("#")
            keymap_class["S-4"] = lambda:put_str("$")
            keymap_class["S-5"] = lambda:put_str("%")
            keymap_class["S-6"] = lambda:put_str("^")
            keymap_class["S-7"] = lambda:put_str("&")
            keymap_class["S-8"] = lambda:put_str("*")
            keymap_class["S-9"] = lambda:put_str("(")
            keymap_class["S-0"] = lambda:put_str(")")
            keymap_class["S-Plus"] = lambda:put_str("+")
            keymap_class["S-Quote"] = lambda:put_str("\"")
            keymap_class["S-OpenBracket"] = lambda:put_str("{")
            keymap_class["S-CloseBracket"] = lambda:put_str("}")

        def initialize_keybind_alt(keymap_class):
            keymap_class["A-L"] = "A-Tab"
            keymap_class["A-H"] = "A-S-Tab"
            keymap_class["A-J"] = "A-Down"
            keymap_class["A-K"] = "A-Up"
            keymap_class["A-Q"] = "A-Tab"
            keymap_class["LA-RS-Q"] = "A-Left"
            keymap_class["A-Insert"] = "C-C"
            keymap_class["A-Pause"] = "C-V"
        
        def initialize_keybind_cursor(keymap_class):
            keymap_class["C-A"] = "Home"
            keymap_class["C-E"] = "End"
            keymap_class["C-U"] = "S-Home", "Delete"
            keymap_class["C-F"] = "Right"
            keymap_class["C-B"] = "Left"
            if hhkb_flag or jp_flag:
                keymap_class["C-A"] = "Home"
                keymap_class["C-E"] = "End"
                keymap_class["C-U"] = "S-Home", "Delete"
                keymap_class["C-F"] = "Right"
                keymap_class["C-B"] = "Left"
            #keymap_class["U0-F"] = "C-Right"
            #keymap_class["U0-B"] = "C-Left"
            #keymap_class["A-A"] = "S-Home"
            #keymap_class["A-E"] = "S-End"

        def initialize_keybind_jump(keymap_class):
            """
            w1 - G: Google Chrome
            w2 - Ex: Explorer
            w3 - TW: Twitter
            w4 - SL: Slack
            w5 - DI: Discord
            w6 - V : VirtualBox
            w7 - C : CMD
            t2 - TY: Typetalk
            t3 - BA: Backlog
            t4 - EN: Google English
            """
            keymap_class["C-J"] = keymap.defineMultiStrokeKeymap("C-J")
            set_class_cj_cmd = make_set_cmd(keymap_class, "C-J")
            if hhkb_flag or jp_flag:
                keymap_class["C-J"] = keymap.defineMultiStrokeKeymap("C-J")
                set_class_cj_cmd = make_set_cmd(keymap_class, "C-J")
            set_class_cj_cmd(lambda:jump_google_tab_nr(2), "TY")
            set_class_cj_cmd(lambda:jump_google_tab_nr(3), "BA")
            set_class_cj_cmd(lambda:jump_google_tab_nr(4), "EN")
            set_class_cj_cmd(lambda:jump_window_nr(1), "G")
            set_class_cj_cmd(lambda:jump_window_nr(2), "EX")
            set_class_cj_cmd(lambda:jump_window_nr(3), "TW")
            set_class_cj_cmd(lambda:jump_window_nr(4), "SL")
            set_class_cj_cmd(lambda:jump_window_nr(5), "DI")
            set_class_cj_cmd(lambda:jump_window_nr(6), "V")
            set_class_cj_cmd(lambda:jump_window_nr(7), "C")

        def initialize_keybind_c(keymap_class):
            #def put_function_key(function_key):
            #    put_key(function_key)
            #    put_key("RETURN")
            if jp_flag:
                keymap_class["C-Atmark"] = lambda:put_str("[")
                keymap_class["C-OpenBracket"] = lambda:put_str("]")
                keymap_class["C-Colon"] = lambda:put_str("`")
            else:
                keymap_class["C-OpenBracket"] = lambda:put_str("[")
                keymap_class["C-CloseBracket"] = lambda:put_str("]")
                keymap_class["C-Quote"] = lambda:put_str("`")
            if hhkb_flag:
                keymap_class["C-Colon"] = lambda:put_str("|")
            keymap_class["C-J"] = lambda:enter_jp_mode()
            keymap_class["C-K"] = lambda:enter_en_mode()
                
        def initialize_keybind_cspace(keymap_class):
            def translate():
                time.sleep(0.5)
                hotkey("ctrl", "c")
                typewrite(["esc"]*2)
                hotkey("winleft", "1")
                typewrite(["return"])
                typewrite(["return"])
                typewrite(["return"])
                typewrite(["f10"])
                typewrite(["left"]*4)
                typewrite(["return"])
                time.sleep(1)
                hotkey("ctrl", "v")
                typewrite(["return"])
            keymap_class["C-Space"] = keymap.defineMultiStrokeKeymap("C-Space")
            keymap_class["C-Space"]["E"] = keymap.defineMultiStrokeKeymap("E")
            keymap_class["C-Space"]["E"]["N"] = translate
            if hhkb_flag or jp_flag:
                keymap_class["C-Space"] = keymap.defineMultiStrokeKeymap("C-Space")
                keymap_class["C-Space"]["E"] = keymap.defineMultiStrokeKeymap("E")
                keymap_class["C-Space"]["E"]["N"] = translate


        def initialize_keybind_ci(keymap_class):
            keymap_class["C-I"] = keymap.defineMultiStrokeKeymap("C-I")
            set_class_ci_cmd = make_set_cmd(keymap_class, "C-I")
            if hhkb_flag or jp_flag:
                keymap_class["C-I"] = keymap.defineMultiStrokeKeymap("C-I")
                set_class_ci_cmd = make_set_cmd(keymap_class, "C-I")
            set_class_ci_cmd(lambda:put_str(os.getenv("NAME", "<<<Please Export $NAME>>>")), "NAME")
            set_class_ci_cmd(lambda:put_str(os.getenv("ADDR", "<<<Please Export $ADDR>>>")), "ADDR")
            set_class_ci_cmd(lambda:put_str(os.getenv("MAIL", "<<<Please Export $MAIL>>>")), "MAIL")
            set_class_ci_cmd(lambda:put_str(os.getenv("USER", "<<<Please Export $MAIL>>>")), "MAIL")
            set_class_ci_cmd(link_cmd, "LK")
            set_class_ci_cmd(lambda:put_strln("-> "), "Y")
            set_class_ci_cmd(lambda:put_strln("# "), "1")
            set_class_ci_cmd(lambda:put_strln("## <INS>"), "2")
            set_class_ci_cmd(lambda:put_strln("### "), "3")
            set_class_ci_cmd(insert_ins, "INS")
            set_class_ci_cmd(insert_h4, "4")
            set_class_ci_cmd(insert_bold, "B")
            set_class_ci_cmd(insert_ul, "UL")
            set_class_ci_cmd(insert_li, "LI")
            set_class_ci_cmd(lambda:put_strln("https://qiita.com/search?utf8=%E2%9C%93&sort=&q=user%3Amiyagi1024+"), "QIITA")
            set_class_ci_cmd(lambda:put_strln("https://twitter.com/search?f=tweets&vertical=default&q=list%3Amiyagi1024%2Fperfect-monitoring%20min_faves%3A1"), "TWITTER")
            set_class_ci_cmd(lambda:put_strln("https://qiita.com/drafts/new"), "NQIITA")
            set_class_ci_cmd(lambda:put_strln("```\n"), "KD")
            set_class_ci_cmd(lambda:put_strln("```Rust\n"), "KR")
            set_class_ci_cmd(lambda:put_strln("```Bash\n"), "KB")
            set_class_ci_cmd(lambda:put_strln("```C\n"), "KC")
            set_class_ci_cmd(lambda:put_strln("```Python\n"), "KP")
            procon_template = r"""#![allow(unused_imports)]
#![allow(unused_macros)]
#![allow(unknown_lints)]
#![allow(unused_variables)]
#![allow(unused_must_use)]
#![allow(unused_mut)]
#![allow(dead_code)]
#![allow(unused_assignments)]

use std::collections::HashMap;
use std::process::exit;
use std::io::{
    stdin,
    stdout,
    stderr,
    Read,
    Write,
    BufReader,
    BufWriter
};

macro_rules! d {
    ($t:expr, $($e:expr),*) => {
        #[cfg(debug_assertions)]
        $({
            let (e, mut err) = (stringify!($e), stderr());
            writeln!(err, "\x1B[33m{}\x1B[0m = {:?}", $t, $e).unwrap()
        })*
    };
    ($($e:expr),*) => {
        #[cfg(debug_assertions)]
        $({
            let (e, mut err) = (stringify!($e), stderr());
            writeln!(err, "\x1B[33m{}\x1B[0m = {:?}", e, $e).unwrap()
        })*
    };
}

macro_rules! e {
    ($($arg:tt)*) => {
        #[cfg(debug_assertions)]
        {
            let mut err = stderr();
            let e = format!($($arg)*);
            write!(err, "\x1B[32m{}\x1B[0m", e).unwrap()
        }
    };
}

macro_rules! eln {
    ($($arg:tt)*) => {
        #[cfg(debug_assertions)]
        {
            let mut err = stderr();
            let e = format!($($arg)*);
            writeln!(err, "\x1B[32m{}\x1B[0m", e).unwrap()
        }
    };
}

macro_rules! stdin {
    () => ({
        use std::io::Read;
        let mut s = String::new();
        std::io::stdin().read_to_string(&mut s).unwrap();
        s
    })
}

macro_rules! test {
    (name = $name:ident, $($input:expr => $output:expr),* $(,)*) => (
        #[test]
        fn $name() {
            $(
                assert_eq!(solve($input.to_string()), $output);
            )*
        }
    );
    ($($input:expr => $output:expr),* $(,)*) => (
        #[test]
        fn solve_test() {
            $(
                assert_eq!(solve($input.to_string()), $output);
            )*
        }
    );
}

macro_rules! input {
    (source = $s:expr, $($r:tt)*) => {
        let mut iter = $s.split_whitespace();
        let mut next = || { iter.next().unwrap() };
        input_inner!{next, $($r)*}
    };
    ($($r:tt)*) => {
        let stdin = std::io::stdin();
        let mut bytes = std::io::Read::bytes(std::io::BufReader::new(stdin));
        let mut next = move || -> String{
            bytes
                .by_ref()
                .map(|r|r.unwrap() as char)
                .skip_while(|c|c.is_whitespace())
                .take_while(|c|!c.is_whitespace())
                .collect()
        };
        input_inner!{next, $($r)*}
    };
}

macro_rules! input_inner {
    ($next:expr) => {};
    ($next:expr, ) => {};

    ($next:expr, $var:ident : $t:tt $($r:tt)*) => {
        let $var = read_value!($next, $t);
        input_inner!{$next $($r)*}
    };
}

macro_rules! read_value {
    ($next:expr, ( $($t:tt),* )) => {
        ( $(read_value!($next, $t)),* )
    };

    ($next:expr, [ $t:tt ; $len:expr ]) => {
        (0..$len).map(|_| read_value!($next, $t)).collect::<Vec<_>>()
    };

    ($next:expr, chars) => {
        read_value!($next, String).chars().collect::<Vec<char>>()
    };

    ($next:expr, usize1) => {
        read_value!($next, usize) - 1
    };

    ($next:expr, $t:ty) => {
        $next().parse::<$t>().expect("Parse error")
    };
}

fn main() {
    print!("{}", solve(stdin!()));
}

/* TEMPLATE END */

"""
            set_class_ci_cmd(lambda:put_strln(procon_template), "PT")

        def initialize_keybind_u0(keymap_class):
            #keymap_class["O-Tab"] = "Tab"
            #keymap_class["U0-J"] = "PageDown"
            #keymap_class["U0-K"] = "PageUp"
            #keymap_class["U0-Q"] = "A-F4"
            #if hhkb_flag or jp_flag:
            #    keymap_class["U0-F"] = "C-F"
            pass

        def initialize_keybind_cu0(keymap_class):
            pass

        def initialize_keybind_win(keymap_class):
            keymap_class["Win-Tab"] = "Win-Tab"

        def initialize_keybind_jp2en(keymap_class):
            keymap_class["D-240"] = "S-Caret"
            keymap_class["S-Semicolon"] = "Colon"
            keymap_class["S-Minus"] = "S-BackSlash"
            keymap_class["S-BackSlash"] = "S-Yen"
            keymap_class["Yen"] = "S-Atmark"
            keymap_class["S-Yen"] = "S-Caret"
            keymap_class["Atmark"] = "OpenBracket"
            keymap_class["S-Atmark"] = "S-OpenBracket"
            keymap_class["OpenBracket"] = "CloseBracket"
            keymap_class["S-OpenBracket"] = "S-CloseBracket"
            keymap_class["Colon"] = "S-7"
            keymap_class["CloseBracket"] = "S-Minus"
            keymap_class["S-CloseBracket"] = "S-Plus"
            keymap_class["Caret"] = "S-Minus"
            keymap_class["S-Caret"] = "S-Plus"
            keymap_class["S-7"] = "S-6"
            keymap_class["S-Colon"] = "S-2"

        def initialize_keybind_henkan(keymap_class):
            def henkan_a():
                down_key("SHIFT")
                put_key("HOME")
                up_key("SHIFT")

            def henkan_e():
                down_key("SHIFT")
                put_key("END")
                up_key("SHIFT")

            keymap_class["U1-A"] = lambda:henkan_a()
            keymap_class["U1-E"] = lambda:henkan_e()

        def initialize_keybind_muhenkan(keymap_class):
            keymap_class["U2-A"] = "C-A"
            keymap_class["U2-J"] = "PageDown"
            keymap_class["U2-K"] = "PageUp"
            keymap_class["U2-H"] = "C-PageUp"
            keymap_class["U2-L"] = "C-PageDown"
            keymap_class["U2-F"] = "C-F"
            keymap_class["U2-S-9"] = lambda:put_str("（")
            keymap_class["U2-S-0"] = lambda:put_str("）")

        #def initialize_keybind_katahira(keymap_class):
        #    keymap_class["U3-A"] = lambda:put_str("hoge")
        
        def initialize_keybind_special(keymap_class):
            keymap_class["Insert"] = "S-C-M"

        def initialize_keybind(keymap_class):
            if hhkb_flag or jp_flag:
                initialize_alttab(keymap_class)
                initialize_jpen(keymap_class)
            else:
                initialize_keybind_alnum(keymap_class)

            initialize_keybind_shift(    keymap_class )
            initialize_keybind_alt(      keymap_class )
            initialize_keybind_cursor(   keymap_class )
            #initialize_keybind_jump(    keymap_class )
            initialize_keybind_c(        keymap_class )
            initialize_keybind_cspace(   keymap_class )
            initialize_keybind_ci(       keymap_class )
            #initialize_keybind_u0(      keymap_class )
            #initialize_keybind_cu0(     keymap_class )
            initialize_keybind_win(      keymap_class )
            initialize_keybind_special(  keymap_class )

            keymap_class["BackSlash"] = lambda:put_str("\\")
            #keymap_class["U0-Space"] = space_4
            if jp_flag:
                keymap_class["U2-Space"] = space_4

            if jp_flag:
                initialize_keybind_jp2en(keymap_class)
                initialize_keybind_henkan(   keymap_class )
                initialize_keybind_muhenkan( keymap_class )
                #initialize_keybind_katahira( keymap_class )
            else:
                keymap_class["Quote"] = lambda:put_str("'")

        def get_keymap(exe_name):
            return keymap.defineWindowKeymap(exe_name=exe_name)

        def escape():
            esc_code = get_code("ESCAPE")
            Input.send([pyauto.Key(esc_code)])
            keymap.wnd.setImeStatus(0)

        def config_terminal(keymap_class):
            for x in ["A", "E", "U", "F", "B", "S-F", "S-B"]:
                keymap_class["C-" + x] = "C-" + x
            if hhkb_flag or jp_flag:
                for x in ["A", "E", "U", "F", "B", "S-F", "S-B"]:
                    keymap_class["C-" + x] = "C-" + x

        def config_vim(keymap_class):
            keymap_class["C-SEMICOLON"] = "C-F", "BackSlash"
            #keymap_class["U0-J"] = escape
            #keymap_class["U0-I"] = i_jp
            #keymap_class["U0-O"] = o_jp
            #keymap_class["U0-S-O"] = s_o_jp
            #keymap_class["U0-A"] = a_jp
            #keymap_class["U0-S-A"] = s_a_jp
            if jp_flag:
                keymap_class["U2-J"] = escape
                keymap_class["U2-I"] = i_jp
                keymap_class["U2-S-I"] = s_i_jp
                keymap_class["U2-O"] = o_jp
                keymap_class["U2-S-O"] = s_o_jp
                keymap_class["U2-A"] = a_jp
                keymap_class["U2-S-A"] = s_a_jp
                keymap_class["U2-C"] = c_jp
                keymap_class["U2-S-C"] = s_c_jp
                keymap_class["U2-M"] = m_jp
                keymap_class["U2-RETURN"] = return_en
                keymap_class["U2-K"] = return_en

        def n_slack(keymap_class):
            keymap_class["C-N"] = "S-A-Down"
            #keymap_class["C-U0-N"] = "S-A-Up"
            if jp_flag:
                keymap_class["U2-N"] = "S-A-Down"
                keymap_class["U2-S-N"] = "S-A-Up"
        
        def n_notepad(keymap_class):
            keymap_class["C-N"] = "Down"
            #keymap_class["C-U0-N"] = "Up"
            if hhkb_flag or jp_flag:
                keymap_class["C-N"] = "Down"
                #keymap_class["C-U0-N"] = "Up"
                keymap_class["C-U2-N"] = "Up"

        def qiita():
            base_url = "https://qiita.com/search?utf8=%E2%9C%93&sort=&q=user%3Amiyagi1024+"
            down_key("CTRL")
            put_key("T")
            up_key("CTRL")
            put_str(base_url)
            put_key("RETURN")

	# Functions For HHKB

        def initialize_alttab(keymap_class):
            keymap_class["D-A-Tab"] = "A-Tab"
            keymap_class["D-A-S-Tab"] = "A-Left"

        def initialize_jpen(keymap_class):
            keymap_class["O-C-Tab"] = "S-CapsLock"

    # Config For All
    if 1:
        #keymap.defineModifier("Tab", "User0")
        if jp_flag:
            keymap.defineModifier("(28)", "User1")
            keymap.defineModifier("(29)", "User2")
            keymap.defineModifier("(241)", "User3")
            keymap.defineModifier("(242)", "User3")

    # Config For Global
    if 1:
        keymap_global = keymap.defineWindowKeymap()
        initialize_keybind(keymap_global)

    # Config For Firefox
    if 1:
        def step_in():
            down_key("CTRL")
            put_str("[")
            up_key("CTRL")

        def step_over():
            down_key("CTRL")
            put_str("]")
            up_key("CTRL")

        def translate_page():
            time.sleep(0.3)
            hotkey("alt", "d")
            hotkey("ctrl", "c")
            url = getClipboardText()
            url = url.replace(":", "%3A")
            url = url.replace("/", "%2F")
            typewrite(["return"])
            hotkey("ctrl", "t")
            base_url = "https://translate.google.com/#en/ja/"
            put_str(base_url)
            typewrite(["return"])
            put_str(url)
            typewrite(["return"])
            typewrite(["return"])
            #typewrite(["return"])
            #typewrite(["return"])
            #time.sleep(3)
            #typewrite(["esc"])
            #hotkey("ctrl", "[")
            #time.sleep(1)
            #put_str("ak")

        def translate_now():
            time.sleep(0.3)
            hotkey("ctrl", "c")
            typewrite(["f10"])
            typewrite(["left"]*4)
            typewrite(["return"])
            hotkey("ctrl", "v")
            typewrite(["return"])

        keymap_firefox = get_keymap("firefox.exe")
        initialize_keybind(keymap_firefox)
        n_notepad(keymap_firefox)
        keymap_firefox["C-H"] = "A-Left"
        keymap_firefox["C-L"] = "A-Right"
        keymap_firefox["C-PageUp"] = "C-PageUp"
        keymap_firefox["C-PageDown"] = "C-PageDown"
        if hhkb_flag or jp_flag:
            keymap_firefox["C-H"] = "A-Left"
            keymap_firefox["C-L"] = "A-Right"
            keymap_firefox["C-PageUp"] = "C-PageUp"
            keymap_firefox["C-PageDown"] = "C-PageDown"
        #keymap_firefox["U0-H"] = "C-Pageup"
        #keymap_firefox["U0-L"] = "C-Pagedown"
        #keymap_firefox["U0-Q"] = "C-W"
        #keymap_firefox["U0-I"] = step_in
        #keymap_firefox["U0-O"] = step_over
        ##keymap_firefox["O-Tab"] = space_4
        keymap_firefox["C-Space"] = keymap.defineMultiStrokeKeymap("C-Space")
        set_firefox_cs_cmd = make_set_cmd(keymap_firefox, "C-Space")
        set_firefox_cs_cmd(translate_page, "P")
        set_firefox_cs_cmd(translate_now, "EN")

        ## Config For Jump
        #keymap_firefox["C-J"] = keymap.defineMultiStrokeKeymap("C-J")
        #set_firefox_cj_cmd = make_set_cmd(keymap_firefox, "C-J")
        #if hhkb_flag or jp_flag:
        #    keymap_firefox["C-J"] = keymap.defineMultiStrokeKeymap("C-J")
        #    set_firefox_cj_cmd = make_set_cmd(keymap_firefox, "C-J")
        #set_firefox_cj_cmd(lambda:jump_tab_nr(2), "TY")
        #set_firefox_cj_cmd(lambda:jump_tab_nr(3), "BA")
        #set_firefox_cj_cmd(lambda:jump_tab_nr(4), "EN")
        #set_firefox_cj_cmd(lambda:jump_window_nr(3), "TW")
        #set_firefox_cj_cmd(lambda:jump_window_nr(4), "SL")
        #set_firefox_cj_cmd(lambda:jump_window_nr(5), "DI")
        #set_firefox_cj_cmd(lambda:jump_window_nr(6), "V")
        #set_firefox_cj_cmd(lambda:jump_window_nr(7), "C")
        #set_firefox_cj_cmd(qiita, "QI")

    # Config For Discord
    if 1:
        keymap_discord = keymap.defineWindowKeymap(exe_name="discord.exe")
        n_slack(keymap_discord)

    # Config For Slack
    if 1:
        keymap_slack = keymap.defineWindowKeymap(exe_name="slack.exe")
        initialize_keybind(keymap_slack)
        n_slack(keymap_slack)

    # Config For Notepad
    if 1:
        keymap_notepad = keymap.defineWindowKeymap( exe_name="notepad.exe", class_name="Edit" )
        initialize_keybind(keymap_notepad)
        n_notepad(keymap_notepad)

    # Config For TeraTerm
    if 1:
        keymap_teraterm = keymap.defineWindowKeymap(exe_name="TTERMPRO.exe")
        initialize_keybind(keymap_teraterm)
        config_terminal(keymap_teraterm)
        #keymap_teraterm["U0-J"] = escape
        #keymap_teraterm["U0-I"] = i_jp
        #keymap_teraterm["U0-O"] = o_jp
        config_vim(keymap_teraterm)

    # Config For cmd
    if 1:
        keymap_cmd = keymap.defineWindowKeymap(exe_name="cmd.exe")
        initialize_keybind(keymap_cmd)
        config_terminal(keymap_cmd)
        config_vim(keymap_cmd)

        def for_python():
            down_key("SHIFT")
            put_key("SEMICOLON")
            up_key("SHIFT")
            put_key("E")
            put_key("SPACE")
            put_key("BACK")
            keymap.MouseButtonClickCommand("right")()

        keymap_cmd["C-BackSlash"] = keymap.defineMultiStrokeKeymap("C-BackSlash")
        keymap_cmd["C-BackSlash"]["A"] = for_python

        def hoge():
            typewrite(["return"])

        #keymap_cmd["U0-X"] = hoge

    # Config For PowerShell
    if 1:
        keymap_powershell = keymap.defineWindowKeymap(exe_name="powershell.exe")
        initialize_keybind(keymap_powershell)
        #config_terminal(keymap_powershell)
        config_vim(keymap_powershell)

    # Config For WSL
    if 1:
        keymap_ubuntu = keymap.defineWindowKeymap(exe_name="ubuntu1604.exe")
        initialize_keybind(keymap_ubuntu)
        config_terminal(keymap_ubuntu)
        config_vim(keymap_ubuntu)

        keymap_wsl = keymap.defineWindowKeymap(exe_name="wsl.exe")
        initialize_keybind(keymap_wsl)
        config_terminal(keymap_wsl)
        config_vim(keymap_wsl)

        keymap_wsl = keymap.defineWindowKeymap(exe_name="mintty.exe")
        initialize_keybind(keymap_wsl)
        config_terminal(keymap_wsl)
        config_vim(keymap_wsl)

    # Config For Explorer
    if 1:
        def open_vim():
            hotkey("ctrl", "c")
            hotkey("alt", "d")
            hotkey("ctrl", "v")
            typewrite(["backspace", "backspace", "home", "delete"])
            put_str("winpath2wslpath_copy.vbs ")
            typewrite(["return", "alt", "alt"], interval=0.2)
            hotkey("win", "7")
            typewrite(["return"])
            typewrite([":", "e", " "], interval=0.03)
            rightClick(1000, 1000)
        keymap_explorer = keymap.defineWindowKeymap(exe_name="explorer.exe")
        #keymap_explorer["U0-V"] = open_vim
        if jp_flag:
            keymap_explorer["U2-V"] = open_vim
