use std::{env, fs, fs::File};
use std::io::Write;
const MAX_MSGS:usize = 100;

fn main() {
    let args: Vec<String> = env::args().collect();
    let file = std::env::home_dir().unwrap().display().to_string() + "/Messages.txt";
    let mut file_contents = match fs::read_to_string(&file){
        Ok(f) => get_messages(&f),
        _ => vec!["--NEW CHAT--".to_string()]
    };
    if args.len()>2 && args[1] == "write"{
        write_to_file(&file, &file_contents, &args[2]);
        file_contents = match fs::read_to_string(&file){
            Ok(f) => get_messages(&f),
            _ => vec!["--NEW CHAT--".to_string()]
        };

    }
    println!("{}", format_text(&file_contents));

}
fn format_text(msgs:&Vec<String>) -> String{
    let mut formatted = String::new();
    let mut msg = 0;
    for msg in msgs{
        let text:Vec<char> = msg.chars().collect();
        formatted+="<p style=\"color:white;font-family:fira;background:black\">";
        for chr in text{
            if chr == '&'{formatted+="&amp;"}
            else if chr == ';'{formatted+="&semi;"}
            else if chr == '<'{formatted+="&lt;"}
            else if chr == '>'{formatted+="&gt;"}
            else {formatted.push(chr);}
        }
        formatted+="</p>";
    }
    formatted
}

fn write_to_file(filepath:&String, current_content:&Vec<String>, message:&String){
    let mut towrite = String::new();
    let mut x = 0;
    if current_content.len() >= MAX_MSGS{x=1}
    while x < current_content.len(){
        towrite+=&format!("{}\n",current_content[x]);
        x+=1;
    }
    towrite+=&message.replace("\n", "");
    File::create(filepath).unwrap().write(towrite.as_bytes());
} 

fn get_messages(t:&String) -> Vec::<String>{
    let mut toret = Vec::new();
    let mut curmsg = String::new();
    let mut x:usize = 0;
    let text:Vec<char> = t.chars().collect();
    while x < text.len(){
        if text[x] == '\n'{
            if curmsg.len() > 1{
                toret.push(curmsg);
            }
            curmsg = String::new();
        }
        else{
            curmsg.push(text[x]);
        }
        x+=1;
    }
    if curmsg.len() > 1{
        toret.push(curmsg);
    }
    toret
}
