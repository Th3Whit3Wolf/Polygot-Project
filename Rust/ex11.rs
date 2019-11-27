use std::io::{self, Write};
use std::fmt::Display;
use std::process;
 
fn main() {
    let age = grab_input("How old are you?")
        .unwrap_or_else(|e| exit_err(&e, e.raw_os_error().unwrap_or(-1)));
    let height = grab_input("How tall are you?")
        .unwrap_or_else(|e| exit_err(&e, e.raw_os_error().unwrap_or(-1)));
    let weight = grab_input("How much do you weigh?")
        .unwrap_or_else(|e| exit_err(&e, e.raw_os_error().unwrap_or(-1)));
    println!("So, you're {} years old, {} tall, and weigh {} lbs.", age, height, weight)
}
 
fn grab_input(msg: &str) -> io::Result<String> {
    let mut buf = String::new();
    print!("{}\n", msg);
    io::stdout().flush()?;
 
    io::stdin().read_line(&mut buf)?;
    Ok(buf.trim().to_string())
}
 
fn exit_err<T: Display>(msg: T, code: i32) -> ! {
    let _ = writeln!(&mut io::stderr(), "Error: {}", msg);
    process::exit(code)
}
