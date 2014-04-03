Obj createWindows(Pts basicLine,Pts basicLineUp,Pts basicLineSlab,Pts basicLineSlabUp){
  Obj ruban = new Obj();

  CSpline curve = new CSpline(basicLine,6);
  ((CSpline)curve).closedMode = true;
  ((CSpline)curve).mode = CSpline.NEXT;
  Pts curveUniform = curve.getPts(numberOfPts);

  Pts curveMidDown = new Pts();
  for(int i = 0; i<curveUniform.numOfPts(); i+=8)
    curveMidDown.add(curveUniform.pt(i));

  CSpline curveSlab = new CSpline(basicLineSlab,6);
  ((CSpline)curveSlab).closedMode = true;
  ((CSpline)curveSlab).mode = CSpline.NEXT;
  Pts curveUniformSlab = curveSlab.getPts(numberOfPts);

  CSpline curveUp = new CSpline(basicLineUp,6);
  ((CSpline)curveUp).closedMode = true;
  ((CSpline)curveUp).mode = CSpline.NEXT;
  Pts curveUniformUp = curveUp.getPts(numberOfPts);

  Pts curveMidUp = new Pts();
  for(int i = 0; i<curveUniform.numOfPts(); i+=8)
    curveMidUp.add(curveUniformUp.pt(i));

  CSpline curveSlabUp = new CSpline(basicLineSlabUp,6);
  ((CSpline)curveSlabUp).closedMode = true;
  ((CSpline)curveSlabUp).mode = CSpline.NEXT;
  Pts curveUniformSlabUp = curveSlabUp.getPts(numberOfPts);

 // ruban.add(curveUniform);
  curveUniform.stroke(255,0,0);
  //ruban.add(curveUniformUp);
  curveUniformUp.stroke(0,255,0);

  int p = 16*(int)random(2);
  //println(p);

  //ParamLength di = new ParamLength(curveWithPointsUniformUptrans.pt(1),curveWithPointsUniformUp.pt(1));

  //println(di);


  Pts extDown = new Pts();
  Pts intDown = new Pts();
  Pts extUp = new Pts();
  Pts intUp = new Pts();



  //Param offdivext = new ParamDiv(offext,4);
  //Param offdivint = new ParamDiv(offint,4);



  ////////////////////////////////////////////////////
  ///////////////////////////////////////////////////
  Obj etageMid = new Obj();
  Pts midtemp = new Pts();
  Pts mid = new Pts();

  ////// calcul des points millieux entre les 2 courbes
  for(int i = 0; i<curveUniform.numOfPts(); i++){
    Pts etageMidtemp = new Pts();
    etageMidtemp = new PtsMid(curveUniform.pt(i),curveUniformUp.pt(i),2); 
    etageMid.add(etageMidtemp);
  }

  for(int i=0; i<curveUniform.numOfPts(); i+=8)
    mid.add(etageMid.line(i).pt(1));

  //for(int i=0; i<curveUniform.numOfPts(); i++)
  //ruban.add(mid);

  ///////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////

  Param offext = new Param(0);

  for(int i = 0 ; i<=curveUniform.numOfPts(); i++){

    /*if( i<2*curveUniform.numOfPts()/3){
      offext = new Param(1+sin(i*(PI/(2*curveUniform.numOfPts()/3))));
    }
    else 
    { 
      offext = new Param(1);
    } */

    Transform OffsetOut = new Transform();
    OffsetOut.translate(zero,zero,offext);

    Transform Offset3Pts = new Transform(curveUniform.pt((i)%curveUniform.numOfPts()),curveUniformSlab.pt((i)%curveUniform.numOfPts()),curveUniform.pt((i+1)%curveUniform.numOfPts()), OffsetOut);
    Transform Offset3PtsUp = new Transform(curveUniformUp.pt((i)%curveUniform.numOfPts()),curveUniformSlabUp.pt((i)%curveUniform.numOfPts()),curveUniformUp.pt((i+1)%curveUniform.numOfPts()), OffsetOut);
    Pt OffsetPt = Pt.create(curveUniform.pt((i)%curveUniform.numOfPts()));
    Pt OffsetPtUp = Pt.create(curveUniformUp.pt((i)%curveUniform.numOfPts()));
    OffsetPt.apply(Offset3Pts);
    OffsetPtUp.apply(Offset3PtsUp);
    extDown.add(OffsetPt);
    extUp.add(OffsetPtUp);
  }


  Param offint = new Param(0);
  for(int i = 0 ; i<=curveUniform.numOfPts(); i++){
   /* if( i<2*curveUniform.numOfPts()/3)
      offint = new Param(-1-sin(i*(PI/(2*curveUniform.numOfPts()/3))));
    else 
    { 
      offint = new Param(-1);
    }  */
    Transform OffsetInt = new Transform();
    OffsetInt.translate(zero,zero,offint); 

    Transform Offset3Pts = new Transform(curveUniform.pt((i)%curveUniform.numOfPts()),curveUniformSlab.pt((i)%curveUniform.numOfPts()),curveUniform.pt((i+1)%curveUniform.numOfPts()), OffsetInt);
    Transform Offset3PtsUp = new Transform(curveUniformUp.pt((i)%curveUniform.numOfPts()),curveUniformSlabUp.pt((i)%curveUniform.numOfPts()),curveUniformUp.pt((i+1)%curveUniform.numOfPts()), OffsetInt);
    Pt OffsetPt = Pt.create(curveUniform.pt((i)%curveUniform.numOfPts()));
    Pt OffsetPtUp = Pt.create(curveUniformUp.pt((i)%curveUniform.numOfPts()));
    OffsetPt.apply(Offset3Pts);
    OffsetPtUp.apply(Offset3PtsUp);
    intDown.add(OffsetPt);
    intUp.add(OffsetPtUp);
  }


  Pts slabint = new Pts();
  
 for(int i =3; i<=curveUniform.numOfPts(); i+=16){
   slabint.add( intDown.pt(i));
   slabint.add( intDown.pt(i+1));
   slabint.add( intDown.pt(i+2));
   slabint.add( curveUniform.pt((i+5)%curveUniform.numOfPts()));
   slabint.add( curveUniform.pt((i+8)%curveUniform.numOfPts()));
   slabint.add( curveUniform.pt((i+9)%curveUniform.numOfPts()));
   slabint.add( curveUniform.pt((i+10)%curveUniform.numOfPts()));
   slabint.add( curveUniform.pt((i+13)%curveUniform.numOfPts()));
   }
  /*
  for(int i =3; i<=curveUniform.numOfPts(); i+=16){
   slabint.add( curveUniform.pt(i));
   slabint.add( curveUniform.pt(i+1));
   slabint.add( curveUniform.pt(i+2));
   slabint.add( curveUniform.pt((i+5)%curveUniform.numOfPts()));
   slabint.add( extDown.pt((i+8)%curveUniform.numOfPts()));
   slabint.add( extDown.pt((i+9)%curveUniform.numOfPts()));
   slabint.add( extDown.pt((i+10)%curveUniform.numOfPts()));
   slabint.add( curveUniform.pt((i+13)%curveUniform.numOfPts()));
   }
   */
  slabint.stroke(255,0,0);
  ruban.add(slabint);
   
  return ruban;
}
