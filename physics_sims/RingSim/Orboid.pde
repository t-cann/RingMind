//What are the minimum and maximum extents in r for initialisation
float r_min = 1;
float r_max = 3.5;
float vr_maxinitial = 0;
float vtheta_maxinitial = 0.1;

//How strong is the damping of radial motions?
float amp_rule_1 = 0.1;

//How strong is the forcing to Keplerian motion?
float amp_rule_2 = 0.1;

//How strong is random scattering?
float amp_rule_4 = 1e-5;

//Where are the orbital resonances (ring gaps) and what is their width, and how
//strong is the gap. Larger values of w will make the gaps wider, larger values
//of s will make them emptier.
float r_res_a = 2.2;
float w_res_a = 0.1;
float s_res_a = 0.0005;
float r_res_b = 2.8;
float w_res_b = 0.01;
float s_res_b = 0.5;
float r_res_c = 1.8;
float w_res_c = 0.01;
float s_res_c = 0.5;

// Spiral Density Wave effect
// white line
float amp_rule_51 = 1e-1;
float Q1 = 2.0;
float r_gap1 = 2.33;
float r_moon1 = r_gap1*(pow(Q1, 2.0/3.0));
float theta_moon1 = 0;
float vtheta_moon1 = sqrt(1/pow(r_moon1, 3));

// green line
float amp_rule_52 = 1e-1;
float Q2=2.0;
float r_gap2=2.33;
float r_moon2= r_gap2*pow(Q2, 2.0/3.0);
float theta_moon2 = PI;
float vtheta_moon2 = sqrt(1/pow(r_moon2, 3));

//// blue line
//float amp_rule_53 = 1e-1;
//float Q3=3.5;
//float r_gap3=3.0;
//float r_moon3= r_gap3*pow(Q3, 2.0/3.0);
//float theta_moon3 = PI;
//float vtheta_moon3 = sqrt(1/pow(r_moon3, 3));

/**<h1>Orboid</h1> represents an Orboid
 * @author Thomas Cann 
 * @author Sam Hinson
 * @version 1.0
 */
class Orboid {

  float r;
  float theta;
  float vr;
  float vtheta;
  float ar;
  float atheta;
  float scale =75;

  /**
   *  Class Constuctor - Initialises an Orboid object with a random position and velocity. 
   */
  Orboid() {

    r = random(1)*(r_max-r_min) + r_min;
    theta = random(1)*2.0*PI;
    vr = randomGaussian()*vr_maxinitial;
    vtheta = randomGaussian()*vtheta_maxinitial;
  }

  /**
   *  Class Constuctor - Initialises an Orboid at the mouse position with a random velocity.
   * @param MouseX x coordinate of mouse [pixels]
   * @param MouseY y coordinate of mouse [pixels]
   */
  Orboid(int MouseX, int MouseY) {
    //Initialise our Orboids.
    float radius =sqrt(sq(MouseX -(width/2)) + sq(MouseY-(height/2)));
    float angle = atan2(float(MouseY-height/2), float(MouseX-width/2));
    r = radius/scale;
    theta = angle;
    vr = randomGaussian()*vr_maxinitial;
    vtheta = randomGaussian()*vtheta_maxinitial;
  }

  /**
   *  Applies rules to calculate accelerations and integrates to calculate new position and velocity.
   */
  void update() {

    //Zero acceleration to start
    ar=0;
    atheta=0;

    //Apply rule 1: we damp out any motions towards/away from the planet
    ar = -amp_rule_1*vr;

    //Apply rule 2: orboids want to move at Keplerian speed for their orbital distance.
    atheta = -amp_rule_2*(vtheta - sqrt(1/r)/r);    // theta is an angle, this is basically v=r*omega since aphi is an angular acceleration

    // Apply rule 3: orboids are pushed away from resonance sites
    //ar += a_ringgap(r,r_res_a,w_res_a)*s_res_a;
    //ar += a_ringgap(r,r_res_b,w_res_b)*s_res_b;
    //ar += a_ringgap(r,r_res_c,w_res_c)*s_res_c;

    // Apply rule 4: there is a small amount of natural scattering in random directions.

    vr += randomGaussian()*amp_rule_4;  //Could use inbuilt Noise Function ?
    vtheta += randomGaussian()*amp_rule_4;

    // Update velocities and positons
    vr += ar*h_stepsize;
    vtheta += atheta*h_stepsize;
    r += vr*h_stepsize;
    theta += vtheta*h_stepsize;

    //Displays this object.
    display();
  }
  
   void update1() {

    //Zero acceleration to start
    ar=0;
    atheta=0;

    //Apply rule 1: we damp out any motions towards/away from the planet
    ar = -amp_rule_1*vr;

    //Apply rule 2: orboids want to move at Keplerian speed for their orbital distance.
    atheta = -amp_rule_2*(vtheta - sqrt(1/r)/r);    // theta is an angle, this is basically v=r*omega since aphi is an angular acceleration

    // Apply rule 3: orboids are pushed away from resonance sites
    //ar += a_ringgap(r,r_res_a,w_res_a)*s_res_a;
    //ar += a_ringgap(r,r_res_b,w_res_b)*s_res_b;
    //ar += a_ringgap(r,r_res_c,w_res_c)*s_res_c;

    // Apply rule 4: there is a small amount of natural scattering in random directions.

    vr += randomGaussian()*amp_rule_4;  //Could use inbuilt Noise Function ?
    vtheta += randomGaussian()*amp_rule_4;

    //Apply rule 5:
    float temp_theta = theta % (2 *PI);
    float temp_theta_moon1 = theta_moon1 % (2 *PI);
    float temp_theta_moon2 = theta_moon2 % (2 *PI);
    //float temp_theta_moon3 = theta_moon3 % (2 *PI);

    if ( abs(temp_theta_moon1-temp_theta) < 10*PI/180) {
      ar += amp_rule_51* (r_moon1-r)/pow(abs(r_moon1-r), 3); //(r_moon1-r)
    }
    if ( abs(temp_theta_moon2-temp_theta) < 10*PI/180) {
      ar += amp_rule_52* (r_moon2-r)/pow(abs(r_moon2-r), 3); //(r_moon2-r)
    }
    //if ( abs(temp_theta_moon3-temp_theta) < 1*PI/180) {
    //  ar += amp_rule_53* (r_moon3-r)/pow(abs(r_moon3-r), 3); //(r_moon3-r)
    //}


    // Update velocities and positons
    vr += ar*h_stepsize;
    vtheta += atheta*h_stepsize;
    r += vr*h_stepsize;
    theta += vtheta*h_stepsize;

    //Displays this object.
    display();
  }

  /**
   *  Method to calculate radial acceleration for rule 3.
   */
  float a_ringgap(float r, float r_gap, float w_gap) {
    // Converted in Java np.exp(-((r-r_gap)/w_gap)**2)*np.sign(r-r_gap)

    float temp_a;
    if (r-r_gap >0) {
      temp_a = exp(-(pow(((r-r_gap)/w_gap), 2)));
    } else if (r-r_gap ==0) {
      temp_a =0;
    } else {
      temp_a = exp(-(pow(((r-r_gap)/w_gap), 2)))*-1;
    }
    return temp_a;
  }

  /**
   *  Display Method - Renders this object to screen displaying its position and colour.
   */
  void display() {
    fill(255, 0, 0);
    stroke(255, 0, 0);
    //stroke(0);
    //strokeWeight(2);

    point(scale *r*cos(theta), scale*r*sin(theta));
    //ellipse(r*cos(theta),r*sin(theta) , 100, 100);
  }

  /**
   *  Print Method - Outputs position to console.
   */
  //void print_position() {
  //  print(" x: " + r*cos(theta));
  //  print(" y: " + r*sin(theta));
  //  println();
  //}

  /**
   *  Print Method -  Outputs all class properties to console.
   */
  //void print_properties() {
  //  print(" r: " + r);
  //  print(" theta: " + theta);
  //  print(" vr: " + vr);
  //  print(" vtheta: " + vtheta);
  //  print(" ar: " + ar);
  //  print(" atheta: " + atheta);
  //  println();
  //}
}
