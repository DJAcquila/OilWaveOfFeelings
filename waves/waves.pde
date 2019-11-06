JSONObject json;

int numWaves = 4;
float k = 120.0;
float velocidade = 0.00025;
float altura = 0.5;
float humor = 0.5;
float sadness = 0.5;
float hapiness = 0.5;
float transpTexto = 0.2;
int state;
float valorTexto = 0.005;
String palavra = "palavra";
String sentiment = "sentiment";
String newPalavra = "palavra";
int count = 0;
float r = humor;
float g = humor;
float b = humor;

void setup(){
  size(720,480);
  noStroke();
  
  ExplorarJSON();
}

void draw(){
  json = loadJSONObject("../log.json");
  newPalavra = json.getString("last_msg");
  if(!newPalavra.equals(palavra)){ 
    ExplorarJSON();
  }
  
    background(255);
    if(sentiment.equals("neg") && k < height-50){ 
      humor = 0.25*humor + 0.75*(1 - sadness);
      k += 0.2;  
    }
    else if(sentiment.equals("pos") && k > 100){
      humor = 0.25*humor + 0.75*hapiness;
      k -= 0.2;
    }
   for(int i = 0 ; i < numWaves; i++){
     fill(humor*60,humor*240,humor*360,map(i,0,numWaves-1,192,32));
     drawSineWave(HALF_PI,velocidade * (i+1),50 + (10 * i), 8, width, k);
   }
  /* 
  textSize(40);
  textAlign(CENTER);
  fill(0, 102, 153, transpTexto*255);
  text(palavra, width/2, 90);
  fill(0, 102, 153, transpTexto*51);
  text(palavra, width/2, 100); 
  
  transpTexto += valorTexto;
  
  if(transpTexto >= 1.0 || transpTexto <= 0.0) valorTexto *= -1;*/
}
/*
* radians   - how often does the wave cycle (larges values = more peaks)
* speed     - how fast is the wave moving
* amplitude - how high is the wave (from centre point)
* detail    - how many points are used to draw the wave (small=angled, many = smooth)
* y         - y centre of the wave
*/
void drawSineWave(float radians,float speed,float amplitude,int detail,float size,float y){
  beginShape();
  vertex(0,height);//fix to bottom
  //compute the distance between each point
  float xoffset = size / detail;
  //compute angle offset between each point
  float angleIncrement = radians / detail;
  //for each point
  for(int i = 0 ; i <= detail; i++){
    //compute x position
    float px = xoffset * i;
    //use sine function compute y
    //millis() * speed is like an ever increasing angle
    //to which we add the angle increment for each point (so the the angle changes as we traverse x
    //the result of sine is a value between -1.0 and 1.0 which we multiply to the amplitude (height of the wave)
    //finally add the y offset
    float py = y + (sin((millis() * speed) + angleIncrement * i) * amplitude);
    //add the point
    vertex(px,py);
  }
  vertex(size,height);//fix to bottom
  endShape();
}

void SetJSON(){
  palavra = newPalavra;
}
void ExplorarJSON(){
  //Carregando o arquivo jason
  json = loadJSONObject("../log.json");
  sadness = json.getFloat("sadness_degree");
  println("Leu sadness: ", sadness);
  hapiness = json.getFloat("happiness_degree");
  println("Leu hapiness", hapiness);
  palavra = json.getString("last_msg");
  sentiment = json.getString("last_sentiment");
  int s = json.getInt("state");
  //println("Leu ", s);
  state = s;
  //println("Valor do state ", state);
  
  //if(sadness > hapiness) humor = humor - sadness*humor;
  //else humor = humor + sadness*humor;
  
  
  println("Valor de k", k);
  println("humor ", humor);
  
}
