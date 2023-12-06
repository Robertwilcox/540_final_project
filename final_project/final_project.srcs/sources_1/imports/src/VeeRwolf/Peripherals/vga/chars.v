//////////////////////////////////////////////////////////////////////////////////
// Character generator holding 8x8 character images.
// Input char is a 4-bit character number representing:
// 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, a-z, A-Z
// Input rownum is the desired row of the pixel image
// Output pixels is the 8 pixel row, pixels[7] is leftmost.
// Original font from https://github.com/dhepper/font8x8/blob/master/font8x8_basic.h (Numbers)
// Letters a-z and A-Z added by Robert Wilcox (wwilcox6@pdx.edu)


module chars(
    input [5:0] char,
    input [2:0] rownum,
    output reg [7:0] pixels
    );

always @(*)
  case ({char, rownum})
    9'b000000000: pixels = 8'b01111100; //  XXXXX  
    9'b000000001: pixels = 8'b11000110; // XX   XX 
    9'b000000010: pixels = 8'b11001110; // XX  XXX 
    9'b000000011: pixels = 8'b11011110; // XX XXXX 
    9'b000000100: pixels = 8'b11110110; // XXXX XX 
    9'b000000101: pixels = 8'b11100110; // XXX  XX 
    9'b000000110: pixels = 8'b01111100; //  XXXXX  
    9'b000000111: pixels = 8'b00000000; //         

    9'b000001000: pixels = 8'b00110000; //   XX    
    9'b000001001: pixels = 8'b01110000; //  XXX    
    9'b000001010: pixels = 8'b00110000; //   XX    
    9'b000001011: pixels = 8'b00110000; //   XX    
    9'b000001100: pixels = 8'b00110000; //   XX    
    9'b000001101: pixels = 8'b00110000; //   XX    
    9'b000001110: pixels = 8'b11111100; // XXXXXX  
    9'b000001111: pixels = 8'b00000000; //         

    9'b000010000: pixels = 8'b01111000; //  XXXX   
    9'b000010001: pixels = 8'b11001100; // XX  XX  
    9'b000010010: pixels = 8'b00001100; //     XX  
    9'b000010011: pixels = 8'b00111000; //   XXX   
    9'b000010100: pixels = 8'b01100000; //  XX     
    9'b000010101: pixels = 8'b11001100; // XX  XX  
    9'b000010110: pixels = 8'b11111100; // XXXXXX  
    9'b000010111: pixels = 8'b00000000; //         

    9'b000011000: pixels = 8'b01111000; //  XXXX   
    9'b000011001: pixels = 8'b11001100; // XX  XX  
    9'b000011010: pixels = 8'b00001100; //     XX  
    9'b000011011: pixels = 8'b00111000; //   XXX   
    9'b000011100: pixels = 8'b00001100; //     XX  
    9'b000011101: pixels = 8'b11001100; // XX  XX  
    9'b000011110: pixels = 8'b01111000; //  XXXX   
    9'b000011111: pixels = 8'b00000000; //         

    9'b000100000: pixels = 8'b00011100; //    XXX  
    9'b000100001: pixels = 8'b00111100; //   XXXX  
    9'b000100010: pixels = 8'b01101100; //  XX XX  
    9'b000100011: pixels = 8'b11001100; // XX  XX  
    9'b000100100: pixels = 8'b11111110; // XXXXXXX 
    9'b000100101: pixels = 8'b00001100; //     XX  
    9'b000100110: pixels = 8'b00011110; //    XXXX 
    9'b000100111: pixels = 8'b00000000; //         

    9'b000101000: pixels = 8'b11111100; // XXXXXX  
    9'b000101001: pixels = 8'b11000000; // XX      
    9'b000101010: pixels = 8'b11111000; // XXXXX   
    9'b000101011: pixels = 8'b00001100; //     XX  
    9'b000101100: pixels = 8'b00001100; //     XX  
    9'b000101101: pixels = 8'b11001100; // XX  XX  
    9'b000101110: pixels = 8'b01111000; //  XXXX   
    9'b000101111: pixels = 8'b00000000; //         

    9'b000110000: pixels = 8'b00111000; //   XXX   
    9'b000110001: pixels = 8'b01100000; //  XX     
    9'b000110010: pixels = 8'b11000000; // XX      
    9'b000110011: pixels = 8'b11111000; // XXXXX   
    9'b000110100: pixels = 8'b11001100; // XX  XX  
    9'b000110101: pixels = 8'b11001100; // XX  XX  
    9'b000110110: pixels = 8'b01111000; //  XXXX   
    9'b000110111: pixels = 8'b00000000; //         

    9'b000111000: pixels = 8'b11111100; // XXXXXX  
    9'b000111001: pixels = 8'b11001100; // XX  XX  
    9'b000111010: pixels = 8'b00001100; //     XX  
    9'b000111011: pixels = 8'b00011000; //    XX   
    9'b000111100: pixels = 8'b00110000; //   XX    
    9'b000111101: pixels = 8'b00110000; //   XX    
    9'b000111110: pixels = 8'b00110000; //   XX    
    9'b000111111: pixels = 8'b00000000; //         

    9'b001000000: pixels = 8'b01111000; //  XXXX   
    9'b001000001: pixels = 8'b11001100; // XX  XX  
    9'b001000010: pixels = 8'b11001100; // XX  XX  
    9'b001000011: pixels = 8'b01111000; //  XXXX   
    9'b001000100: pixels = 8'b11001100; // XX  XX  
    9'b001000101: pixels = 8'b11001100; // XX  XX  
    9'b001000110: pixels = 8'b01111000; //  XXXX   
    9'b001000111: pixels = 8'b00000000; //         

    9'b001001000: pixels = 8'b01111000; //  XXXX   
    9'b001001001: pixels = 8'b11001100; // XX  XX  
    9'b001001010: pixels = 8'b11001100; // XX  XX  
    9'b001001011: pixels = 8'b01111100; //  XXXXX  
    9'b001001100: pixels = 8'b00001100; //     XX  
    9'b001001101: pixels = 8'b00011000; //    XX   
    9'b001001110: pixels = 8'b01110000; //  XXX    
    9'b001001111: pixels = 8'b00000000; //         
    
    // 'a' character
    9'b001010000: pixels = 8'b00000000; //         
    9'b001010001: pixels = 8'b00000000; //         
    9'b001010010: pixels = 8'b01111000; //  XXXX   
    9'b001010011: pixels = 8'b00001100; //     XX  
    9'b001010100: pixels = 8'b01111100; //  XXXXX  
    9'b001010101: pixels = 8'b11001100; // XX  XX  
    9'b001010110: pixels = 8'b11001100; // XX  XX  
    9'b001010111: pixels = 8'b01110110; //  XXX XX 

    // 'b' character
    9'b001011000: pixels = 8'b11000000; // XX      
    9'b001011001: pixels = 8'b11000000; // XX      
    9'b001011010: pixels = 8'b11011100; // XX XXX  
    9'b001011011: pixels = 8'b11100110; // XXX  XX 
    9'b001011100: pixels = 8'b11000110; // XX   XX 
    9'b001011101: pixels = 8'b11100110; // XXX  XX 
    9'b001011110: pixels = 8'b11111110; // XXXXXXX 
    9'b001011111: pixels = 8'b00000000; //         

    // 'c' character
    9'b001100000: pixels = 8'b00000000; //         
    9'b001100001: pixels = 8'b00000000; //         
    9'b001100010: pixels = 8'b01111000; //  XXXX   
    9'b001100011: pixels = 8'b11001100; // XX  XX  
    9'b001100100: pixels = 8'b11000000; // XX      
    9'b001100101: pixels = 8'b11001100; // XX  XX  
    9'b001100110: pixels = 8'b01111000; //  XXXX   
    9'b001100111: pixels = 8'b00000000; // 

    // 'd' character
    9'b001101000: pixels = 8'b00001100; //     XX  
    9'b001101001: pixels = 8'b00001100; //     XX  
    9'b001101010: pixels = 8'b01111100; //  XXXXX  
    9'b001101011: pixels = 8'b11001100; // XX  XX  
    9'b001101100: pixels = 8'b11001100; // XX  XX  
    9'b001101101: pixels = 8'b11001100; // XX  XX  
    9'b001101110: pixels = 8'b01110110; //  XXX XX 
    9'b001101111: pixels = 8'b00000000; //         

    // 'e' character
    9'b001110000: pixels = 8'b00000000; //         
    9'b001110001: pixels = 8'b00000000; //         
    9'b001110010: pixels = 8'b01111000; //  XXXX   
    9'b001110011: pixels = 8'b11001100; // XX  XX  
    9'b001110100: pixels = 8'b11111100; // XXXXXX  
    9'b001110101: pixels = 8'b11000000; // XX      
    9'b001110110: pixels = 8'b01111000; //  XXXX   
    9'b001110111: pixels = 8'b00000000; //         

    // 'f' character
    9'b001111000: pixels = 8'b00111000; //   XXX   
    9'b001111001: pixels = 8'b01101100; //  XX XX  
    9'b001111010: pixels = 8'b01100000; //  XX     
    9'b001111011: pixels = 8'b11111000; // XXXXX   
    9'b001111100: pixels = 8'b01100000; //  XX     
    9'b001111101: pixels = 8'b01100000; //  XX     
    9'b001111110: pixels = 8'b01100000; //  XX     
    9'b001111111: pixels = 8'b00000000; //          

    // 'g' character
    9'b010000000: pixels = 8'b01111100; //  XXXXX
    9'b010000001: pixels = 8'b11000110; // XX   XX
    9'b010000010: pixels = 8'b11000110; // XX   XX
    9'b010000011: pixels = 8'b11000110; // XX   XX
    9'b010000100: pixels = 8'b01111110; //  XXXXXX
    9'b010000101: pixels = 8'b00000110; //      XX
    9'b010000110: pixels = 8'b11000110; // XX   XX
    9'b010000111: pixels = 8'b01111100; //  XXXXX

    // 'h' character
    9'b010001000: pixels = 8'b11000000; // XX
    9'b010001001: pixels = 8'b11000000; // XX
    9'b010001010: pixels = 8'b11011100; // XX XXX
    9'b010001011: pixels = 8'b11100110; // XXX  XX
    9'b010001100: pixels = 8'b11000110; // XX   XX
    9'b010001101: pixels = 8'b11000110; // XX   XX
    9'b010001110: pixels = 8'b11000110; // XX   XX
    9'b010001111: pixels = 8'b00000000; // 

    // 'i' character
    9'b010010000: pixels = 8'b00110000; //   XX
    9'b010010001: pixels = 8'b00000000; // 
    9'b010010010: pixels = 8'b01110000; //  XXX
    9'b010010011: pixels = 8'b00110000; //   XX
    9'b010010100: pixels = 8'b00110000; //   XX
    9'b010010101: pixels = 8'b00110000; //   XX
    9'b010010110: pixels = 8'b01111000; //  XXXX
    9'b010010111: pixels = 8'b00000000; // 

    // 'j' character
    9'b010011000: pixels = 8'b00011000; //    XX
    9'b010011001: pixels = 8'b00000000; // 
    9'b010011010: pixels = 8'b00111000; //   XXX
    9'b010011011: pixels = 8'b00011000; //    XX
    9'b010011100: pixels = 8'b00011000; //    XX
    9'b010011101: pixels = 8'b00011000; //    XX
    9'b010011110: pixels = 8'b11011000; // XX XX
    9'b010011111: pixels = 8'b01110000; //  XXX

    // 'k' character
    9'b010100000: pixels = 8'b11000000; // XX
    9'b010100001: pixels = 8'b11000000; // XX
    9'b010100010: pixels = 8'b11001100; // XX  XX
    9'b010100011: pixels = 8'b11011000; // XX XX
    9'b010100100: pixels = 8'b11110000; // XXXX
    9'b010100101: pixels = 8'b11011000; // XX XX
    9'b010100110: pixels = 8'b11001100; // XX  XX
    9'b010100111: pixels = 8'b00000000; // 


    // 'l' character
    9'b010101000: pixels = 8'b01110000; //  XXX    
    9'b010101001: pixels = 8'b00110000; //   XX    
    9'b010101010: pixels = 8'b00110000; //   XX    
    9'b010101011: pixels = 8'b00110000; //   XX    
    9'b010101100: pixels = 8'b00110000; //   XX    
    9'b010101101: pixels = 8'b00110000; //   XX    
    9'b010101110: pixels = 8'b01111000; //  XXXX   
    9'b010101111: pixels = 8'b00000000; //         

    // 'm' character
    9'b010110000: pixels = 8'b00000000; //         
    9'b010110001: pixels = 8'b00000000; //         
    9'b010110010: pixels = 8'b11001100; // XX  XX  
    9'b010110011: pixels = 8'b11111110; // XXXXXXX 
    9'b010110100: pixels = 8'b11011011; // XX XX XX
    9'b010110101: pixels = 8'b11011011; // XX XX XX
    9'b010110110: pixels = 8'b11011011; // XX XX XX
    9'b010110111: pixels = 8'b00000000; //         

    // 'n' character
    9'b010111000: pixels = 8'b00000000; //         
    9'b010111001: pixels = 8'b00000000; //         
    9'b010111010: pixels = 8'b11011100; // XX XXX  
    9'b010111011: pixels = 8'b11100110; // XXX  XX 
    9'b010111100: pixels = 8'b11000110; // XX   XX 
    9'b010111101: pixels = 8'b11000110; // XX   XX 
    9'b010111110: pixels = 8'b11000110; // XX   XX 
    9'b010111111: pixels = 8'b00000000; //         

    // 'o' character
    9'b011000000: pixels = 8'b00000000; //         
    9'b011000001: pixels = 8'b00000000; //         
    9'b011000010: pixels = 8'b01111100; //  XXXXX  
    9'b011000011: pixels = 8'b11000110; // XX   XX 
    9'b011000100: pixels = 8'b11000110; // XX   XX 
    9'b011000101: pixels = 8'b11000110; // XX   XX 
    9'b011000110: pixels = 8'b01111100; //  XXXXX  
    9'b011000111: pixels = 8'b00000000; // 

    // 'p' character
    9'b011001000: pixels = 8'b00000000; //         
    9'b011001001: pixels = 8'b11111000; // XXXXX        
    9'b011001010: pixels = 8'b11001100; // XX  XX  
    9'b011001011: pixels = 8'b11001100; // XX  XX  
    9'b011001100: pixels = 8'b11001100; // XX  XX 
    9'b011001101: pixels = 8'b11111000; // XXXXX 
    9'b011001110: pixels = 8'b11000000; // XX   
    9'b011001111: pixels = 8'b11000000; // XX      

    // 'q' character
    9'b011010000: pixels = 8'b00000000; //         
    9'b011010001: pixels = 8'b01111100; //  XXXXX  
    9'b011010010: pixels = 8'b11001100; // XX  XX  
    9'b011010011: pixels = 8'b11001100; // XX  XX  
    9'b011010100: pixels = 8'b11001100; // XX  XX  
    9'b011010101: pixels = 8'b01111100; //  XXXXX  
    9'b011010110: pixels = 8'b00001100; //     XX  
    9'b011010111: pixels = 8'b00001100; //     XX  

    // 'r' character
    9'b011011000: pixels = 8'b00000000; //         
    9'b011011001: pixels = 8'b11011100; // XX XXX  
    9'b011011010: pixels = 8'b11100110; // XXX  XX 
    9'b011011011: pixels = 8'b11000000; // XX      
    9'b011011100: pixels = 8'b11000000; // XX      
    9'b011011101: pixels = 8'b11000000; // XX      
    9'b011011110: pixels = 8'b11000000; // XX      
    9'b011011111: pixels = 8'b00000000; //         

    // 's' character
    9'b011100000: pixels = 8'b00000000; //         
    9'b011100001: pixels = 8'b01111100; //  XXXXX  
    9'b011100010: pixels = 8'b11000000; // XX      
    9'b011100011: pixels = 8'b01111000; //  XXXX   
    9'b011100100: pixels = 8'b00001100; //     XX  
    9'b011100101: pixels = 8'b11001100; // XX  XX  
    9'b011100110: pixels = 8'b01111000; //  XXXX   
    9'b011100111: pixels = 8'b00000000; //         

    // 't' character
    9'b011101000: pixels = 8'b00110000; //   XX    
    9'b011101001: pixels = 8'b11111100; // XXXXXX  
    9'b011101010: pixels = 8'b00110000; //   XX    
    9'b011101011: pixels = 8'b00110000; //   XX    
    9'b011101100: pixels = 8'b00110000; //   XX    
    9'b011101101: pixels = 8'b00110000; //   XX    
    9'b011101110: pixels = 8'b00111100; //   XXXX  
    9'b011101111: pixels = 8'b00000000; //         

    // 'u' character
    9'b011110000: pixels = 8'b00000000; //         
    9'b011110001: pixels = 8'b11000110; // XX   XX 
    9'b011110010: pixels = 8'b11000110; // XX   XX 
    9'b011110011: pixels = 8'b11000110; // XX   XX 
    9'b011110100: pixels = 8'b11000110; // XX   XX 
    9'b011110101: pixels = 8'b11000110; // XX   XX 
    9'b011110110: pixels = 8'b01111110; //  XXXXXX 
    9'b011110111: pixels = 8'b00000000; //         

    // 'v' character
    9'b011111000: pixels = 8'b00000000; //         
    9'b011111001: pixels = 8'b11000110; // XX   XX 
    9'b011111010: pixels = 8'b11000110; // XX   XX 
    9'b011111011: pixels = 8'b11000110; // XX   XX 
    9'b011111100: pixels = 8'b11000110; // XX   XX 
    9'b011111101: pixels = 8'b01101100; //  XX XX  
    9'b011111110: pixels = 8'b00111000; //   XXX   
    9'b011111111: pixels = 8'b00000000; //         

    // 'w' character
    9'b100000000: pixels = 8'b00000000; //         
    9'b100000001: pixels = 8'b11000011; // XX    XX 
    9'b100000010: pixels = 8'b11000011; // XX    XX 
    9'b100000011: pixels = 8'b11000011; // XX    XX 
    9'b100000100: pixels = 8'b11011011; // XX XX XX
    9'b100000101: pixels = 8'b11011011; // XX XX XX
    9'b100000110: pixels = 8'b01101100; //  XX XX  
    9'b100000111: pixels = 8'b00000000; //         

    // 'x' character
    9'b100001000: pixels = 8'b00000000; //         
    9'b100001001: pixels = 8'b11000110; // XX   XX 
    9'b100001010: pixels = 8'b01101100; //  XX XX  
    9'b100001011: pixels = 8'b00111000; //   XXX   
    9'b100001100: pixels = 8'b01101100; //  XX XX  
    9'b100001101: pixels = 8'b11000110; // XX   XX 
    9'b100001110: pixels = 8'b11000110; // XX   XX 
    9'b100001111: pixels = 8'b00000000; //         

    // 'y' character
    9'b100010000: pixels = 8'b00000000; //         
    9'b100010001: pixels = 8'b11000110; // XX   XX 
    9'b100010010: pixels = 8'b11000110; // XX   XX 
    9'b100010011: pixels = 8'b11000110; // XX   XX 
    9'b100010100: pixels = 8'b01111110; //  XXXXXX 
    9'b100010101: pixels = 8'b00000110; //      XX 
    9'b100010110: pixels = 8'b01111100; //  XXXXX  
    9'b100010111: pixels = 8'b00000000; //         

    // 'z' character
    9'b100011000: pixels = 8'b00000000; //         
    9'b100011001: pixels = 8'b11111110; // XXXXXXX 
    9'b100011010: pixels = 8'b00001100; //     XX  
    9'b100011011: pixels = 8'b00011000; //    XX   
    9'b100011100: pixels = 8'b00110000; //   XX    
    9'b100011101: pixels = 8'b01100000; //  XX     
    9'b100011110: pixels = 8'b11111110; // XXXXXXX 
    9'b100011111: pixels = 8'b00000000; //         

    // 'A' character
    9'b100100000: pixels = 8'b00110000; //   XX    
    9'b100100001: pixels = 8'b01111000; //  XXXX   
    9'b100100010: pixels = 8'b11001100; // XX  XX  
    9'b100100011: pixels = 8'b11001100; // XX  XX  
    9'b100100100: pixels = 8'b11111100; // XXXXXX  
    9'b100100101: pixels = 8'b11001100; // XX  XX  
    9'b100100110: pixels = 8'b11001100; // XX  XX  
    9'b100100111: pixels = 8'b00000000; //         

    // 'B' character
    9'b100101000: pixels = 8'b11111000; // XXXXX   
    9'b100101001: pixels = 8'b01101100; //  XX XX  
    9'b100101010: pixels = 8'b01100110; //  XX  XX 
    9'b100101011: pixels = 8'b01111000; //  XXXX   
    9'b100101100: pixels = 8'b01100110; //  XX  XX 
    9'b100101101: pixels = 8'b01100110; //  XX  XX 
    9'b100101110: pixels = 8'b11111000; // XXXXX   
    9'b100101111: pixels = 8'b00000000; //         

    // 'C' character
    9'b100110000: pixels = 8'b00111100; //   XXXX  
    9'b100110001: pixels = 8'b01100110; //  XX  XX 
    9'b100110010: pixels = 8'b11000000; // XX      
    9'b100110011: pixels = 8'b11000000; // XX      
    9'b100110100: pixels = 8'b11000000; // XX      
    9'b100110101: pixels = 8'b01100110; //  XX  XX 
    9'b100110110: pixels = 8'b00111100; //   XXXX  
    9'b100110111: pixels = 8'b00000000; //         

    // 'D' character
    9'b100111000: pixels = 8'b11110000; // XXXX    
    9'b100111001: pixels = 8'b01111000; //  XXXX   
    9'b100111010: pixels = 8'b01100110; //  XX  XX 
    9'b100111011: pixels = 8'b01100110; //  XX  XX 
    9'b100111100: pixels = 8'b01100110; //  XX  XX 
    9'b100111101: pixels = 8'b01111000; //  XXXX   
    9'b100111110: pixels = 8'b11110000; // XXXX    
    9'b100111111: pixels = 8'b00000000; //         

    // 'E' character
    9'b101000000: pixels = 8'b11111110; // XXXXXXX 
    9'b101000001: pixels = 8'b11000000; // XX      
    9'b101000010: pixels = 8'b11000000; // XX      
    9'b101000011: pixels = 8'b11111000; // XXXXX   
    9'b101000100: pixels = 8'b11000000; // XX      
    9'b101000101: pixels = 8'b11000000; // XX      
    9'b101000110: pixels = 8'b11111110; // XXXXXXX 
    9'b101000111: pixels = 8'b00000000; //         

    // 'F' character
    9'b101001000: pixels = 8'b11111110; // XXXXXXX 
    9'b101001001: pixels = 8'b11000000; // XX      
    9'b101001010: pixels = 8'b11000000; // XX      
    9'b101001011: pixels = 8'b11111000; // XXXXX   
    9'b101001100: pixels = 8'b11000000; // XX      
    9'b101001101: pixels = 8'b11000000; // XX      
    9'b101001110: pixels = 8'b11000000; // XX      
    9'b101001111: pixels = 8'b00000000; //         

    // 'G' character
    9'b101010000: pixels = 8'b00111100; //   XXXX  
    9'b101010001: pixels = 8'b01100110; //  XX  XX 
    9'b101010010: pixels = 8'b11000000; // XX      
    9'b101010011: pixels = 8'b11001110; // XX  XXX 
    9'b101010100: pixels = 8'b11000110; // XX   XX 
    9'b101010101: pixels = 8'b01100110; //  XX  XX 
    9'b101010110: pixels = 8'b00111100; //   XXXX  
    9'b101010111: pixels = 8'b00000000; //         

    // 'H' character
    9'b101011000: pixels = 8'b11000110; // XX   XX 
    9'b101011001: pixels = 8'b11000110; // XX   XX 
    9'b101011010: pixels = 8'b11000110; // XX   XX 
    9'b101011011: pixels = 8'b11111110; // XXXXXXX 
    9'b101011100: pixels = 8'b11000110; // XX   XX 
    9'b101011101: pixels = 8'b11000110; // XX   XX 
    9'b101011110: pixels = 8'b11000110; // XX   XX 
    9'b101011111: pixels = 8'b00000000; //         

    // 'I' character
    9'b101100000: pixels = 8'b11111100; // XXXXXX  
    9'b101100001: pixels = 8'b00110000; //   XX    
    9'b101100010: pixels = 8'b00110000; //   XX    
    9'b101100011: pixels = 8'b00110000; //   XX    
    9'b101100100: pixels = 8'b00110000; //   XX    
    9'b101100101: pixels = 8'b00110000; //   XX    
    9'b101100110: pixels = 8'b11111100; // XXXXXX  
    9'b101100111: pixels = 8'b00000000; //         

    // 'J' character
    9'b101101000: pixels = 8'b00111110; //   XXXXX 
    9'b101101001: pixels = 8'b00001100; //     XX  
    9'b101101010: pixels = 8'b00001100; //     XX  
    9'b101101011: pixels = 8'b00001100; //     XX  
    9'b101101100: pixels = 8'b11001100; // XX  XX  
    9'b101101101: pixels = 8'b11001100; // XX  XX  
    9'b101101110: pixels = 8'b01111000; //  XXXX   
    9'b101101111: pixels = 8'b00000000; //         

    // 'K' character
    9'b101110000: pixels = 8'b11000110; // XX   XX 
    9'b101110001: pixels = 8'b11001100; // XX  XX  
    9'b101110010: pixels = 8'b11011000; // XX XX   
    9'b101110011: pixels = 8'b11110000; // XXXX    
    9'b101110100: pixels = 8'b11011000; // XX XX   
    9'b101110101: pixels = 8'b11001100; // XX  XX  
    9'b101110110: pixels = 8'b11000110; // XX   XX 
    9'b101110111: pixels = 8'b00000000; //         

    // 'L' character
    9'b101111000: pixels = 8'b11000000; // XX      
    9'b101111001: pixels = 8'b11000000; // XX      
    9'b101111010: pixels = 8'b11000000; // XX      
    9'b101111011: pixels = 8'b11000000; // XX      
    9'b101111100: pixels = 8'b11000000; // XX      
    9'b101111101: pixels = 8'b11000000; // XX      
    9'b101111110: pixels = 8'b11111110; // XXXXXXX 
    9'b101111111: pixels = 8'b00000000; //         

    // 'M' character
    9'b110000000: pixels = 8'b11000110; // XX   XX
    9'b110000001: pixels = 8'b11101110; // XXX XXX
    9'b110000010: pixels = 8'b11111110; // XXXXXXX
    9'b110000011: pixels = 8'b11010110; // XX X XX
    9'b110000100: pixels = 8'b11000110; // XX   XX
    9'b110000101: pixels = 8'b11000110; // XX   XX
    9'b110000110: pixels = 8'b11000110; // XX   XX
    9'b110000111: pixels = 8'b00000000; //         

    // 'N' character
    9'b110001000: pixels = 8'b11000110; // XX   XX
    9'b110001001: pixels = 8'b11100110; // XXX  XX
    9'b110001010: pixels = 8'b11110110; // XXXX XX
    9'b110001011: pixels = 8'b11011110; // XX XXXX
    9'b110001100: pixels = 8'b11001110; // XX  XXX
    9'b110001101: pixels = 8'b11000110; // XX   XX
    9'b110001110: pixels = 8'b11000110; // XX   XX
    9'b110001111: pixels = 8'b00000000; //         

    // 'O' character
    9'b110010000: pixels = 8'b01111100; //  XXXXX
    9'b110010001: pixels = 8'b11000110; // XX   XX
    9'b110010010: pixels = 8'b11000110; // XX   XX
    9'b110010011: pixels = 8'b11000110; // XX   XX
    9'b110010100: pixels = 8'b11000110; // XX   XX
    9'b110010101: pixels = 8'b11000110; // XX   XX
    9'b110010110: pixels = 8'b01111100; //  XXXXX
    9'b110010111: pixels = 8'b00000000; //         

    // 'P' character
    9'b110011000: pixels = 8'b11111100; // XXXXXX
    9'b110011001: pixels = 8'b11000110; // XX   XX
    9'b110011010: pixels = 8'b11000110; // XX   XX
    9'b110011011: pixels = 8'b11111100; // XXXXXX
    9'b110011100: pixels = 8'b11000000; // XX
    9'b110011101: pixels = 8'b11000000; // XX
    9'b110011110: pixels = 8'b11000000; // XX
    9'b110011111: pixels = 8'b00000000; //         

    // 'Q' character
    9'b110100000: pixels = 8'b01111100; //  XXXXX
    9'b110100001: pixels = 8'b11000110; // XX   XX
    9'b110100010: pixels = 8'b11000110; // XX   XX
    9'b110100011: pixels = 8'b11000110; // XX   XX
    9'b110100100: pixels = 8'b11000110; // XX   XX
    9'b110100101: pixels = 8'b11001110; // XX  XXX
    9'b110100110: pixels = 8'b01111100; //  XXXXX
    9'b110100111: pixels = 8'b00001100; //     XX

    // 'R' character
    9'b110101000: pixels = 8'b11111100; // XXXXXX
    9'b110101001: pixels = 8'b11000110; // XX   XX
    9'b110101010: pixels = 8'b11000110; // XX   XX
    9'b110101011: pixels = 8'b11111100; // XXXXXX
    9'b110101100: pixels = 8'b11011000; // XX XX
    9'b110101101: pixels = 8'b11001100; // XX  XX
    9'b110101110: pixels = 8'b11000110; // XX   XX
    9'b110101111: pixels = 8'b00000000; //         

    // 'S' character
    9'b110110000: pixels = 8'b01111100; //  XXXXX
    9'b110110001: pixels = 8'b11000110; // XX   XX
    9'b110110010: pixels = 8'b11000000; // XX
    9'b110110011: pixels = 8'b01111000; //  XXXX
    9'b110110100: pixels = 8'b00001100; //     XX
    9'b110110101: pixels = 8'b11001100; // XX  XX
    9'b110110110: pixels = 8'b01111000; //  XXXX
    9'b110110111: pixels = 8'b00000000; //         

    // 'T' character
    9'b110111000: pixels = 8'b11111100; // XXXXXX
    9'b110111001: pixels = 8'b00110000; //   XX
    9'b110111010: pixels = 8'b00110000; //   XX
    9'b110111011: pixels = 8'b00110000; //   XX
    9'b110111100: pixels = 8'b00110000; //   XX
    9'b110111101: pixels = 8'b00110000; //   XX
    9'b110111110: pixels = 8'b00110000; //   XX
    9'b110111111: pixels = 8'b00000000; //         

    // 'U' character
    9'b111000000: pixels = 8'b11000110; // XX   XX
    9'b111000001: pixels = 8'b11000110; // XX   XX
    9'b111000010: pixels = 8'b11000110; // XX   XX
    9'b111000011: pixels = 8'b11000110; // XX   XX
    9'b111000100: pixels = 8'b11000110; // XX   XX
    9'b111000101: pixels = 8'b11000110; // XX   XX
    9'b111000110: pixels = 8'b01111100; //  XXXXX
    9'b111000111: pixels = 8'b00000000; //         

    // 'V' character
    9'b111001000: pixels = 8'b11000110; // XX   XX
    9'b111001001: pixels = 8'b11000110; // XX   XX
    9'b111001010: pixels = 8'b11000110; // XX   XX
    9'b111001011: pixels = 8'b11000110; // XX   XX
    9'b111001100: pixels = 8'b11000110; // XX   XX
    9'b111001101: pixels = 8'b01101100; //  XX XX
    9'b111001110: pixels = 8'b00111000; //   XXX
    9'b111001111: pixels = 8'b00000000; //         

    // 'W' character
    9'b111010000: pixels = 8'b11000011; // XX    XX
    9'b111010001: pixels = 8'b11000011; // XX    XX
    9'b111010010: pixels = 8'b11000011; // XX    XX
    9'b111010011: pixels = 8'b11000011; // XX    XX
    9'b111010100: pixels = 8'b11011011; // XX XX XX
    9'b111010101: pixels = 8'b11011011; // XX XX XX
    9'b111010110: pixels = 8'b01101100; //  XX XX
    9'b111010111: pixels = 8'b00000000; //         

    // 'X' character
    9'b111011000: pixels = 8'b11000110; // XX   XX
    9'b111011001: pixels = 8'b01101100; //  XX XX
    9'b111011010: pixels = 8'b00111000; //   XXX
    9'b111011011: pixels = 8'b00111000; //   XXX
    9'b111011100: pixels = 8'b01101100; //  XX XX
    9'b111011101: pixels = 8'b11000110; // XX   XX
    9'b111011110: pixels = 8'b11000110; // XX   XX
    9'b111011111: pixels = 8'b00000000; //         

    // 'Y' character
    9'b111100000: pixels = 8'b11000110; // XX   XX
    9'b111100001: pixels = 8'b11000110; // XX   XX
    9'b111100010: pixels = 8'b11000110; // XX   XX
    9'b111100011: pixels = 8'b01111100; //  XXXXX
    9'b111100100: pixels = 8'b00001100; //     XX
    9'b111100101: pixels = 8'b00001100; //     XX
    9'b111100110: pixels = 8'b01111100; //  XXXXX
    9'b111100111: pixels = 8'b00000000; //         

    // 'Z' character
    9'b111101000: pixels = 8'b11111110; // XXXXXXX
    9'b111101001: pixels = 8'b00001100; //     XX
    9'b111101010: pixels = 8'b00011000; //    XX
    9'b111101011: pixels = 8'b00110000; //   XX
    9'b111101100: pixels = 8'b01100000; //  XX
    9'b111101101: pixels = 8'b11000000; // XX
    9'b111101110: pixels = 8'b11111110; // XXXXXXX
    9'b111101111: pixels = 8'b00000000; //          


    default: pixels = 8'b00000000;
  endcase
endmodule