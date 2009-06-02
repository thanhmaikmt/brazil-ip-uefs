function [ output_args ] = mainI0 (x, kMax_in)
    
    global kMax;    

    if(~exist('x')),
        x = [];
    end;

    if(exist('kMax_in')),
        kMax = kMax_in;
    else,
        kMax = [];
    end;

    if(isempty(x)),
        fprintf ('\n Digite o valor de x: \n');
            x = input('--> ');
    end;

    if(isempty(kMax)),
        fprintf ('\n Digite o k máximo: \n');
            kMax = input('--> ');
    end;


    i0_result = i0(x);

    result_max = 1;
    result_min = i0_result(2, kMax)

    y = (result_min/result_max)^(0.5)

    eixos = [0 kMax 0 y];

    figure;
    subplot(2,1,1);
    plot(i0_result(1,:), i0_result(2,:) );
        title('função');
        xlabel('k');
        ylabel('resultado');



    %subplot(2,1,2);
    %plot(i0_result(1,:), i0_result(2,:) );
    %    title('função (maior zoom)');
    %    xlabel('k');
    %    ylabel('x');
    %    if(~isempty(eixos))
    %        axis(eixos);
    %    end;


    subplot(2,1,2);
    string = sprintf('\ni0 (%d)\n', x)
    plot(i0_result(1,:), i0_result(3,:) );
        title(string);
        xlabel('k');
        ylabel('resultado');



    %----------------------------------------------------

    xMin = -x
    xMax = x

    x = linspace(xMin, xMax, 10);
    r = [];

    for(i = 1:10),
        i0_result = i0(x(i));
        r(i,:) = i0_result(3,:);
    end;

    k = i0_result(1,:);

    z_min = min(min(r))
    %z_view = (max(r)/min(r))^(0.5)
    z_view = max(max(r))

    eixos = [0 kMax xMin xMax z_min z_view]


    figure;
    mesh (k, x, r);
        title('i0(x)');
        xlabel('k');
        ylabel('x');
        zlabel('resultado');
        if(~isempty(eixos))
            axis(eixos);
        end;
    
    
    %eixos = [0 kMax -1 1 z_min z_view]
    %figure;
    %mesh (k, x, r);
    %    title('i0(x)');
    %    xlabel('k');
    %    ylabel('x');
    %    zlabel('resultado');
    %    if(~isempty(eixos))
    %        axis(eixos);
    %    end;

