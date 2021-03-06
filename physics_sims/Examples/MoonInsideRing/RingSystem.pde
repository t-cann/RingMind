

/**  Class RingSystem collection of Rings, Ringlets and Gaps for a planetary ring system. 
 *
 *
 *
 * @author Thomas Cann
 * @version 1.0
 */

final float G = 6.67408E-7;       // Gravitational Constant 6.67408E-11[m^3 kg^-1 s^-2]
final float Rp = 60268e3;          // Length scale (1 Saturn radius) [m]
final float GMp = 3.7931187e16;    // Gravitational parameter (Saturn)
final float scale = 100/Rp;        // Converts from [m] to [pixel] with planetary radius (in pixels) equal to the numerator. Size of a pixel represents approximately 600km.

// What are the minimum and maximum extents in r for initialisation
float r_min = 2.5;
float r_max = 3.5;

class RingSystem {

  ArrayList<Ring> rings;
  ArrayList<Moon> moons;
  //float r_min, r_max, num_particles;

  /**
   *  Class Constuctor - General need passing all the values. 
   */
  RingSystem() {
    //***********Initialise Rings*********************
    rings = new ArrayList<Ring>();

    switch(1) {
    case 1:
      //Generic Disc of Particles
      rings.add(new Ring(r_min, r_max, n_particles));
      break;
    case 2:
      //Saturn Ring Data (Source: Nasa Saturn Factsheet) [in Saturn radii]
      // D Ring: Inner 1.110 Outer 1.236
      rings.add(new Ring(1.110, 1.236, 1000));
      // C Ring: Inner 1.239 Outer 1.527
      rings.add(new Ring(1.239, 1.527, 1000));
      // B Ring: Inner 1.527 Outer 1.951
      rings.add(new Ring(1.527, 1.951, 1000));
      // A Ring: Inner 2.027 Outer 2.269
      rings.add(new Ring(2.027, 2.269, 5000));
      // F Ring: Inner 2.320 Outer *
      rings.add(new Ring(2.320, 2.321, 1000));
      // G Ring: Inner 2.754 Outer 2.874
      rings.add(new Ring(2.754, 2.874, 1000));
      // E Ring: Inner 2.987 Outer 7.964
      rings.add(new Ring(2.987, 7.964, 1000));

      //Gaps/Ringlet Data
      // Titan Ringlet 1.292
      // Maxwell Gap 1.452
      // Encke Gap 2.265
      // Keeler Gap 2.265

    default:
    }

    //***********Initialise Moons*********************
    moons = new ArrayList<Moon>();

    // Adding Specific Moons ( e.g. Mima, Enceladus, Tethys, ... )
    
    moons.add(new Moon(G*3.7e19, 2.08e6, 2*Rp));
    
    //addMoon(5, moons);
    //addMoon(6, moons);
    //addMoon(9, moons);
    //addMoon(12, moons);
    //addMoon(14, moons);

    //Adding All Moons

    //for (int i = 0; i < 18; i++) {
    //  addMoon(i, moons);
    //}
    //***********************************************
  }

  /**
   *  Updates object for one time step of simulation taking into account the position of one moon.
   */
  void update() {
    for (Ring r : rings) {
      r.update(moons);
    }
    for (Moon m : moons) {
      m.update(moons);
    }
  }

  void display() {
    for (Ring r : rings) {
      r.display();
    }
    for (Moon m : moons) {
      m.display();
    }
  }

  void render(PGraphics x) {
    for (Ring r : rings) {
      r.render(x);
    }
    for (Moon m : moons) {
      m.render(x);
    }
  }

  void addMoon(int i, ArrayList<Moon> m) {

    //Source: Nasa Saturn Factsheet

    switch(i) {
    case 0:
      // Pan Mass 5e15 [kg] Radius 1.7e4 [m] Orbital Radius 133.583e6 [m]
      m.add(new Moon(G*5e15, 1.7e4, 133.5832e6));
      break;
    case 1:
      // Daphnis Mass 1e14 [kg] Radius 4.3e3 [m] Orbital Radius 136.5e6 [m]
      m.add(new Moon(G*1e14, 4.3e3, 136.5e6));
      break;
    case 2:
      // Atlas Mass 7e15 [kg] Radius 2e4 [m] Orbital Radius 137.67e6 [m]
      m.add(new Moon(G*7e15, 2.4e4, 137.67e6));
      break;
    case 3:
      // Promethieus Mass 1.6e17 [kg] Radius 6.8e4 [m] Orbital Radius 139.353e6 [m]
      m.add(new Moon(G*1.6e17, 6.8e4, 139.353e6));
      break;
    case 4:
      // Pandora Mass 1.4e17 [kg] Radius 5.2e4 [m] Orbital Radius 141.7e6 [m]
      m.add(new Moon(G*1.4e17, 5.2e4, 141.7e6));
      break;
    case 5:
      // Epimetheus Mass 5.3e17 [kg] Radius 6.5e4 [m] Orbital Radius 151.422e6 [m]
      m.add(new Moon(G*5.3e17, 6.5e4, 151.422e6, color(0, 255, 0)));
      break;
    case 6:
      // Janus Mass 1.9e18 [kg] Radius 1.02e5 [m] Orbital Radius 151.472e6 [m]
      m.add(new Moon(G*1.9e18, 1.02e5, 151.472e6));
      break;
    case 7: 
      // Mima Mass 3.7e19 [kg] Radius 2.08e5 [m] Obital Radius 185.52e6 [m]
      m.add(new Moon(G*3.7e19, 2.08e5, 185.52e6));
      break;
    case 8:
      // Enceladus Mass 1.08e20 [kg] Radius 2.57e5 [m] Obital Radius 238.02e6 [m]
      m.add(new Moon(G*1.08e20, 2.57e5, 238.02e6));
      break;
    case 9:
      // Tethys Mass 6.18e20 [kg] Radius 5.38e5 [m] Orbital Radius 294.66e6 [m]
      m.add(new Moon(G*6.18e20, 5.38e5, 294.66e6));
      break;
    case 10:
      // Calypso Mass 4e15 [kg] Radius 1.5e4 [m] Orbital Radius 294.66e6 [m]
      m.add(new Moon(G*4e15, 1.5e4, 294.66e6));
      break;
    case 11:
      // Telesto Mass 7e15 [kg] Radius 1.6e4 [m] Orbital Radius 294.66e6 [m]
      m.add(new Moon(G*7e15, 1.6e4, 294.66e6));
      break;
    case 12:
      // Dione Mass 1.1e21 [kg] Radius 5.63e5 [m] Orbital Radius 377.4e6 [m]
      m.add(new Moon(G*1.1e21, 5.63e5, 377.4e6));
      break;
    case 13:
      // Helele Mass 3e16 [kg] Radius 2.2e4 [m] Orbital Radius 377.4e6[m]
      m.add(new Moon(G*3e16, 2.2e4, 377.4e6));
      break;
    case 14:
      // Rhea Mass 2.31e21 [kg] Radius 7.65e5 [m] Orbital Radius 527.04e6 [m]
      m.add(new Moon(G*2.31e21, 7.65e5, 527.4e6));
      break;
    case 15:
      // Titan Mass 1.3455e23 [kg] Radius 2.575e6 [m] Orbital Radius 1221.83e6 [m]
      m.add(new Moon(G*1.34455e23, 2.57e6, 1221.83e6));
      break;
    case 16:
      // Hyperion Mass 5.6e18 [kg] Radius 1.8e5 [m] Orbital Radius 1481.1e6 [m]
      m.add(new Moon(G*5.6e18, 1.8e5, 1481.1e6));
      break;
    case 17:
      // Iapetus Mass 1.81e21 [kg] Radius 7.46e5 [m] Orbital Radius 3561.3e6 [m]
      m.add(new Moon(G*1.81e21, 7.46e5, 3561.3e6));
      break;
    case 18:
      // Pheobe Mass 8.3e18 [kg] Radius 1.09e5 [m] Orbital Radius 12944e6 [m] 
      m.add(new Moon(G*8.3e18, 1.09e5, 12994e6));
      break;
    }
  }
}
