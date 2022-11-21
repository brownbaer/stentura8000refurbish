//Original TXbolt code is created by Charley Shattuck and contributor Luke Thompson over at 
//https://github.com/CharleyShattuck/Steno-Keyboard-Arduino
//The following code is public domain 

//This modified version of Charley's code and the default Arduino Multiplexer example
//has been modified by BrownBaer (nikonekonyaa#1716) on discord.
//November 21st, 2022 

boolean pressed = false;

// the four bytes of the TX Bolt protocol
byte val0 = 0;
byte val1 = 0;
byte val2 = 0;
byte val3 = 0;

//Mux control pins
int s0 = A4;
int s1 = A3;
int s2 = A2;
int s3 = A1;

//Mux in "SIG" pin
int SIG_pin = A0;


void setup(){
  pinMode(s0, OUTPUT); 
  pinMode(s1, OUTPUT); 
  pinMode(s2, OUTPUT); 
  pinMode(s3, OUTPUT); 
  pinMode(13, INPUT_PULLUP);
  pinMode(12, INPUT_PULLUP);
  pinMode(11, INPUT_PULLUP);
  pinMode(10, INPUT_PULLUP);
  pinMode(9, INPUT_PULLUP);
  pinMode(7, INPUT_PULLUP);
  pinMode(5, INPUT_PULLUP);

  digitalWrite(s0, LOW);
  digitalWrite(s1, LOW);
  digitalWrite(s2, LOW);
  digitalWrite(s3, LOW);
  delay(1000);
  Serial.begin(9600);
}


void loop(){

  // accumulate keys  
  do { scan(); } while (!pressed);
  delay(10); // Debounces 1st keypress
  //INCREASE THIS DELAY NUMBER IF YOU FIND YOUR STROKES GHOSTING
// until all keys released  
  do { scan(); } while (pressed);
// debounce the release  
  delay(50);
  give();  // TX Bolt Protocol
  empty();

}


float readMux(int channel){
  int controlPin[] = {s0, s1, s2, s3};

  int muxChannel[16][4]={
    {0,0,0,0}, //channel 0, S-
    {1,0,0,0}, //channel 1, T-
    {0,1,0,0}, //channel 2, K-
    {1,1,0,0}, //channel 3, P- 
    {0,0,1,0}, //channel 4, W-
    {1,0,1,0}, //channel 5, H-
    {0,1,1,0}, //channel 6, R-
    {1,1,1,0}, //channel 7, A-
    {0,0,0,1}, //channel 8, O-
    {1,0,0,1}, //channel 9, *
    {0,1,0,1}, //channel 10, -E
    {1,1,0,1}, //channel 11, -U
    {0,0,1,1}, //channel 12, -F
    {1,0,1,1}, //channel 13, -R
    {0,1,1,1}, //channel 14, -P
    {1,1,1,1}  //channel 15, -B
  };

  //loop through the 4 sig
  for(int i = 0; i < 4; i ++){
    digitalWrite(controlPin[i], muxChannel[channel][i]);
  }

  //read the value at the SIG pin
  int val = digitalRead(SIG_pin);

  //return the value
  return val;
}

void scan() {
  pressed = false;

//             pin, mask, byte
  val0 = getKey(0, 1, val0); /* S */
  val0 = getKey(1, 2, val0); /* T */
  val0 = getKey(2, 4, val0); /* K */
  val0 = getKey(3, 8, val0); /* P */
  val0 = getKey(4, 16, val0);   /* W */
  val0 = getKey(5, 32, val0);   /* H */

  val1 = getKey(6, 1, val1); /* R */
  val1 = getKey(7, 2, val1); /* A */
  val1 = getKey(8, 4, val1); /* O */
  val1 = getKey(9, 8, val1); /* * */
  val1 = getKey(10, 16, val1);   /* E */
  val1 = getKey(11, 32, val1);   /* U */
 
  val2 = getKey(12, 1, val2); /* F */
  val2 = getKey(13, 2, val2); /* R */
  val2 = getKey(14, 4, val2); /* P */
  val2 = getKey(15, 8, val2); /* B */
  val2 = getPin(5, 16, val2);   /* L */
  val2 = getPin(7, 32, val2);   /* G */

  val3 = getPin(9, 1, val3); /* T */
  val3 = getPin(10, 2, val3); /* S */
  val3 = getPin(11, 4, val3); /* D */
  val3 = getPin(12, 8, val3); /* Z */
  val3 = getPin(13, 16, val3);   /* # */
} 

// k = Mux channel to check
// b = bit mask for TX Bolt bit position
// v = current protocol byte
byte getKey(int k, byte b, byte v) {
  int val = readMux(k);
  if (val == 0) {
    v = b | v;
    pressed = true;
  }
  return v;
}

// k = Arduino pin to check
// b = bit mask for TX Bolt bit position
// v = current protocol byte
byte getPin(int k, byte b, byte v){
  int val = digitalRead(k);
  if (val == 0 ) {
    v = b | v;
    pressed = true;

  }
  return v;
}

void empty() {
  val0 = 0;
  val1 = 0;
  val2 = 0;
  val3 = 0;
}


// send TX bytes over serial,
// then clear buffers
void give() {
  Serial.write(val0);
  val1 = val1 | 64;
  Serial.write(val1);
  val2 = val2 | 128;
  Serial.write(val2);
  val3 = val3 | 192;
  Serial.write(val3);
  empty();
}
