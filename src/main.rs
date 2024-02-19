#![no_main]

#[no_mangle]
fn main() {
    let host = std::env::var("HOST").expect("env 'HOST' not set");
    let port = std::env::var("PORT").expect("env 'PORT' not set");
    let addr = format!("{}:{}", host, port);

    let listener = std::net::TcpListener::bind(&addr).expect("Could not bind to address");

    for stream_res in listener.incoming() {
        let mut stream = stream_res.expect("Happy little accident");
        std::io::Read::read(&mut stream, &mut [0; 2048]).unwrap();
        std::io::Write::write(&mut stream, b"HTTP/1.1 200 OK\r\n\r\n").unwrap();
        std::io::Write::flush(&mut stream).unwrap();
    }
}
