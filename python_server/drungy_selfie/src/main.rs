use opencv::{
    Result,
    prelude::*, 
    imgcodecs::*,
    objdetect,
    imgproc,
    core,
    types
};
use std::env;


use rand::seq::SliceRandom;
use rand::{ Rng};
use std::process::Command;
use std::path::Path;

fn tmp_filename(fex:&str) -> String {
    let mut out = String::from("/tmp/");
    let av:Vec<char> = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM1234567890".chars().collect::<Vec<char>>();
    let mut chs = 100;
    while chs > 0{
        chs-=1;
        out.push(av[rand::thread_rng().gen_range(0..av.len()-1)]);

    }
    out+=&(".".to_owned()+fex);
    out
}



fn main()->Result<()> {
    let args: Vec<String> = env::args().collect();
    let binding = args[0].clone();
    let hd = Path::new(&binding).parent().expect("ERROR PARENT OF EXEC PATH INVALID").to_str().unwrap();
    println!("{:?}", args);
    //return Ok(());
    let infile = args[1].clone();
    let xml = hd.to_owned() + "/haarcascade_frontalface_default.xml"; //relative dir
    let mut other_to_del:Vec<String> = Vec::new();
    let mut face_detector = objdetect::CascadeClassifier::new(&xml).unwrap();

           
        let mut tmp_main_files = Vec::new();
        tmp_main_files.push(tmp_filename("jpg"));
        Command::new("ffmpeg").arg("-i").arg(infile).arg(tmp_main_files[0].clone()).output().unwrap_or_else( |_| {println!("NO FACES"); panic!("womp")});
        
        let mut image = imread(&tmp_main_files[0], IMREAD_UNCHANGED).unwrap();
            let mut grey = Mat::default();
    imgproc::cvt_color(&image, &mut grey, imgproc::COLOR_BGR2GRAY, 0)?;

        let mut faces = types::VectorOfRect::new();
        face_detector.detect_multi_scale(
            &grey, 
            &mut faces, 
            1.1, 
            3,
            objdetect::CASCADE_SCALE_IMAGE,
            core::Size::new(10, 10),
            core::Size::new(0, 0)
        )?; 
        println!("{:?}", faces);
        if faces.len() > 0{
            for face in faces.iter(){
                tmp_main_files.push(tmp_filename("webp"));
                let tmp_darm = tmp_filename("png");
                let tmp_dface = tmp_filename("png");
                other_to_del.push(tmp_darm.clone());
                other_to_del.push(tmp_dface.clone());

                let dc = tmp_darm.clone();
                let ad = format!("scale={}:{}", face.width, face.height);
                Command::new("ffmpeg")
                    .arg("-i")
                    .arg(hd.to_owned() + "/dface.png")
                    .arg("-vf")
                    .arg(format!("scale={}:{}",face.width*2,face.height*2))
                    .arg(tmp_dface.clone()).output().unwrap();
                println!("{:?}",Command::new("ffmpeg").arg("-i").arg(hd.to_owned() + "/darm.png").arg("-vf").arg(ad).arg(dc).output().unwrap());
                println!("not-darm: {:?}", Command::new("ffmpeg")
                    .arg("-i")
                    .arg(tmp_main_files[tmp_main_files.len()-2].clone())
                    .arg("-i")
                    .arg(tmp_darm)
                    .arg("-i")
                    .arg(tmp_dface)
                    .arg("-filter_complex")
                    .arg(format!("[0:v][1:v] overlay={}:{}[o];[o][2:v]overlay={}:{}", face.x-face.width/3, face.y+face.height/3, face.x+face.width, face.y-face.height/2))
                    .arg("-pix_fmt")
                    .arg("yuv420p")
                    .arg("-c:a")
                    .arg("copy")
                    .arg(tmp_main_files[tmp_main_files.len()-1].clone()).output().unwrap());
            }    
        }
        else{
            println!("NO FACES");
        }
    println!("FINAL:{}", tmp_main_files[tmp_main_files.len()-1].clone());
    for i in other_to_del.iter(){
        Command::new("rm").arg(i).output().unwrap();
        }
    let mut x = 0;
    while x < tmp_main_files.len()-1{
        Command::new("rm").arg(tmp_main_files[x].clone()).output().unwrap();
        x+=1
        }
    println!("{:?}", tmp_main_files);
    Ok(())
}
