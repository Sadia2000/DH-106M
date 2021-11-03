## DECU Attempt (!)
## Engine

#Initialise
var engine1 = engines.Jet.new(0 , 0 , 0.01 , 5.21 , 3 , 5 , 1 , 6);
var engine2 = engines.Jet.new(1 , 0 , 0.01 , 5.21 , 3 , 5 , 1 , 6);
var engine3 = engines.Jet.new(2 , 0 , 0.01 , 5.21 , 3 , 5 , 1 , 6);
var engine4 = engines.Jet.new(3 , 0 , 0.01 , 5.21 , 3 , 5 , 1 , 6);

engine1.init();

props.globals.initNode("/sim/autostart/started", 0, "BOOL");

var eng1fuelon = func { setprop("/controls/engines/engine[0]/cutoff", 0); }
var eng2fuelon = func { setprop("/controls/engines/engine[1]/cutoff", 0); }
var eng3fuelon = func { setprop("/controls/engines/engine[2]/cutoff", 0); }
var eng4fuelon = func { setprop("/controls/engines/engine[3]/cutoff", 0); }

var eng1fueloff = func { setprop("/controls/engines/engine[0]/cutoff", 1); }
var eng2fueloff = func { setprop("/controls/engines/engine[1]/cutoff", 1); }
var eng3fueloff = func { setprop("/controls/engines/engine[2]/cutoff", 1); }
var eng4fueloff = func { setprop("/controls/engines/engine[3]/cutoff", 1); }

var eng1starter = func { setprop("/controls/engines/engine[0]/starter", 1); }
var eng2starter = func { setprop("/controls/engines/engine[1]/starter", 1); }
var eng3starter = func { setprop("/controls/engines/engine[2]/starter", 1); }
var eng4starter = func { setprop("/controls/engines/engine[3]/starter", 1); }

var eng1start = func {
  gui.popupTip("*** Engine start left exterior ***");
  eng1fueloff();
  eng1starter();
  settimer(eng1fuelon, 2);
  setprop("/controls/engines/engine[0]/condition", 1);
}

var eng2start = func {
  gui.popupTip("*** Engine start left interior ***");
  eng2fueloff();
  eng2starter();
  settimer(eng2fuelon, 2);
  setprop("/controls/engines/engine[1]/condition", 1);
}

var eng3start = func {
  gui.popupTip("*** Engine start right interior ***");
  eng3fueloff();
  eng3starter();
  settimer(eng3fuelon, 2);
  setprop("/controls/engines/engine[2]/condition", 1);
}

var eng4start = func {
  gui.popupTip("*** Engine start right exterior ***");
  eng4fueloff();
  eng4starter();
  settimer(eng4fuelon, 2);
  setprop("/controls/engines/engine[3]/condition", 1);
}

var engstart = func {
  settimer(eng1start, 2);
  settimer(eng4start, 4);
  settimer(eng2start, 6);
  settimer(eng3start, 8);
}

var engstop = func {
  eng1fueloff();
  setprop("/controls/engines/engine[0]/throttle", 0);
  setprop("/controls/engines/engine[0]/condition", 0);
  eng2fueloff();
  setprop("/controls/engines/engine[1]/throttle", 0);
  setprop("/controls/engines/engine[1]/condition", 0);
  eng3fueloff();
  setprop("/controls/engines/engine[2]/throttle", 0);
  setprop("/controls/engines/engine[2]/condition", 0);
  eng4fueloff();
  setprop("/controls/engines/engine[3]/throttle", 0);
  setprop("/controls/engines/engine[3]/condition", 0);
}

var autostart = func {
  var startstatus = getprop("/sim/autostart/started");
  if ( startstatus == 0 ) {
    gui.popupTip("Autostarting...");
    setprop("/sim/model/autostart", 1);
    setprop("/sim/autostart/started", 1);
    setprop("/controls/electric/battery-switch", 1);
    settimer(engstart, 0.4);
    gui.popupTip("Starting Engines");
  }
  if ( startstatus == 1 ) {
    gui.popupTip("Shutting Down...");
    setprop("/sim/model/autostart", 0);
    setprop("/sim/autostart/started", 0);
    engstop();
  }
}
