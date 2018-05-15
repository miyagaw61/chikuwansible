extern crate clap;
extern crate colored;
//extern crate regex;
//extern crate serde_json;
//#[macro_use]
//extern crate chan;
//extern crate chan_signal;
#[macro_use]
extern crate lazy_static;

use std::fs::OpenOptions;
use std::io::Read;
use std::process::Command;
use colored::*;
//use serde_json::Value;
//use std::thread;
//use chan_signal::Signal;
use std::sync::RwLock;
use clap::{App, Arg, SubCommand};

struct SystemResult {
    stdout: String,
    stderr: String,
    status: i32
}

impl SystemResult {
    fn new(output: std::process::Output) -> SystemResult {
        let mut stdout: Vec<char> = std::str::from_utf8(&output.stdout[..]).unwrap().to_string().chars().collect();
        stdout.pop();
        let stdout: String = stdout.into_iter().collect();
        let mut stderr: Vec<char> = std::str::from_utf8(&output.stderr[..]).unwrap().to_string().chars().collect();
        stderr.pop();
        let stderr: String = stderr.into_iter().collect();
        let mut result = SystemResult {
            stdout: stdout,
            stderr: stderr,
            status: 0
        };
        if result.stderr.chars().count() > 0 {
            result.status = 1
        }
        result
    }
}

fn system(command: &str) -> SystemResult {
    let result = Command::new("sh")
        .arg("-c")
        .arg(command)
        .output()
        .expect("failed to execute process");
    let result = SystemResult::new(result);
    if result.status != 0 {
        let emsg = [
            "== ".red().to_string(),
            "[+]ERROR".red().bold().to_string(),
            " =====================".red().to_string()
        ].join("");
        println!("{}", emsg);
        println!("{}", result.stderr);
        println!("{}", "=================================".red().to_string());
    }
    result
}

fn system_allow_stderr(command: &str) -> SystemResult {
    let result = Command::new("sh")
        .arg("-c")
        .arg(command)
        .output()
        .expect("failed to execute process");
    SystemResult::new(result)
}

fn process(command: &str) -> std::process::ExitStatus {
    let mut child = Command::new("sh")
        .arg("-c")
        .arg(command)
        .spawn()
        .expect("failed to execute process");
    child.wait().unwrap()
}

lazy_static! {
    static ref ADDRESS: RwLock<String> = RwLock::new(String::new());
    static ref SUM: RwLock<f64> = RwLock::new(0.00);
    static ref LOOP_COUNTER: RwLock<f64> = RwLock::new(1.00);
}

fn help() {
    println!("\
USAGE:
    manukazeny [SUBCOMMAND]
manukazeny -h for help\
");
}

fn main() {
    let matches = App::new("Manuka Zeny")
        .version("0.0.1")
        .author("miyagaw61 <miyagaw61@gmail.com>")
        .about("Cpuminer Wrapper in Rust")
        .subcommand(SubCommand::with_name("start")
                    .about("start manukazeny")
                    .arg(Arg::with_name("json_file")
                         .help(r#"config json file
    (Example)
    { "address": ["ABC", "IJK", "XYZ"] }"#)
                         .takes_value(true)
                         .required(true)
                         )
                    )
        .subcommand(SubCommand::with_name("stop")
                    .about("stop manukazeny")
                    )
        .get_matches();
    let sub_command = matches.subcommand_name().unwrap_or("");
    match sub_command {
        "start" => start(&matches),
        "stop" => stop(),
        _ => help()
    }
}
