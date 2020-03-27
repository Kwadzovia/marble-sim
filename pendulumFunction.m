%%Pendulum Function Rough Draft

pendulumResults [linVelImpact,linVelResult,linAccResult,angVelResult,angAccResult]=givenValues(massMarb,massPend,lengthPend,anglePend,impactTime,gravity)
linVelImpact=sqrt(gravity*lengthPend*(1-cos(anglePend))*2);
angVelResult=linVelResult*lengthPend;
linAccResult=0;
angAccResult=linAccResult*lengthPend;




