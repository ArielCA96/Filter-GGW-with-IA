function CstWaveguidePort2(mws,PortNumber, Xrange, Yrange, Zrange, XrangeAdd, YrangeAdd, ZrangeAdd,Coordinates,Orientation, Normal)

%coordinates = 'Picks' or 'Full'
%orientation = 'positive' or 'xmax'
Port = invoke(mws,'Port');
invoke(Port,'Reset');
invoke(Port,'PortNumber',num2str(PortNumber));
invoke(Port,'Label','');
invoke(Port,'NumberOfModes','1');
invoke(Port,'AdjustPolarization','False');
invoke(Port,'PolarizationAngle','0.0');
invoke(Port,'ReferencePlaneDistance','0');
invoke(Port,'TextSize','50');
invoke(Port,'Coordinates',Coordinates);
invoke(Port,'Orientation',Orientation);
invoke(Port,'Normal',Normal);
invoke(Port,'PortOnBound','False');
invoke(Port,'ClipPickedPortToBound','False');  
invoke(Port,'Xrange',sprintf('%.2f', Xrange(1)),sprintf('%.2f', Xrange(2)));
invoke(Port,'Yrange',sprintf('%.2f', Yrange(1)),sprintf('%.2f', Yrange(2)));
invoke(Port,'Zrange',sprintf('%.2f', Zrange(1)),sprintf('%.2f', Zrange(2)));
invoke(Port,'XrangeAdd',sprintf('%.2f', XrangeAdd(1)),sprintf('%.2f', XrangeAdd(2)));
invoke(Port,'YrangeAdd',sprintf('%.2f', YrangeAdd(1)),sprintf('%.2f', YrangeAdd(2)));
invoke(Port,'ZrangeAdd',sprintf('%.2f', ZrangeAdd(1)),sprintf('%.2f', ZrangeAdd(2)));
invoke(Port,'SingleEnded','False');
invoke(Port,'Create');
end 