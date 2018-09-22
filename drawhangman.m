function maxfails = drawhangman(index)
axis([-4,4, -4.5, 4]);
if index == 1
    x = linspace(-3.5,3);
    y = linspace(-4,-4);
    plot(x,y,'k');
    hold on;
elseif index == 2
    x = linspace(-3,-3);
    y = linspace(-4,3);
    plot(x,y,'k');
elseif index == 3
    x = linspace(-3,0);
    y = linspace(3,3);
    plot(x,y,'k');
    x = linspace(0,0);
    y = linspace(2,3);
    plot(x,y,'k');
elseif index == 4
    x = linspace(-1,1);
    y = 1+(1-x.^2).^0.5;
    plot(x,y,'r');
    y = 1-(1-x.^2).^0.5;
    plot(x,y,'r');
elseif index == 5
    plot(-0.4,1.3,'bo');
elseif index == 6
    plot(0.4,1.3,'bo');
elseif index == 7
    x = linspace(-0.2,0);
    y = linspace(0.9,0.9);
    plot(x,y,'r')
    y = x+1.1;
    plot(x,y,'r');
elseif index == 8
    x = linspace(-0.5,0.5);
    y = -0.9.*x.^2+0.7;
    plot(x,y,'r');
elseif index == 9
    x = linspace(0,0);
    y = linspace(-1.5,0);
    plot(x,y,'r');
elseif index == 10
    x = linspace(0,1.4);
    y = 0.25.*x-0.5;
    plot(x,y,'r');
elseif index == 11
    x = linspace(-1.4,0);
    y = -0.25.*x-0.5;
    plot(x,y,'r');
elseif index == 12
    x = linspace(0,1.5);
    y = -1.5.*x-1.5;
    plot(x,y,'r');
elseif index == 13
    x = linspace(-1.5,0);
    y = 1.5.*x-1.5;
    plot(x,y,'r');
    hold off;
end
maxfails = 13;