D = readmatrix('rheo_data.csv');
x = D(:,1);  y = D(:,2);

% models 
Bmodel = @(x,p) p(1) + p(2)*x;                  
Hmodel = @(x,p) p(1) + p(2)*x.^p(3);            
Pmodel = @(x,p) p(1) + p(2)*x + p(3)*x.^p(4);  
% Bingham fit 
ZB = [ones(size(x)) x];
pB = fit_linear(ZB, y);

% Herschel-Bulkley fit 
tau0 = min(y);
n0   = 0.5;
K0   = (max(y) - tau0) / (max(x)^n0 + eps);
pH   = fit_nonlinear(x, y, Hmodel, [tau0; K0; n0]);

% HB Plus fit 
K1_0 = pB(2);
K2_0 = 0.3*K0;     
pP   = fit_nonlinear(x, y, Pmodel, [tau0; K1_0; K2_0; n0]);
% semilogx plot
xp = logspace(log10(min(x(x>0))), log10(max(x)), 400).';
yB = Bmodel(xp, pB);
yH = Hmodel(xp, pH);
yP = Pmodel(xp, pP);

%  plot data symbols
semilogx(x, y, 'o', 'LineStyle','none', 'LineWidth',1.5); hold on;
semilogx(xp, yB, 'r-', 'LineWidth',2);
semilogx(xp, yH, 'g-', 'LineWidth',2);
semilogx(xp, yP, 'b-', 'LineWidth',2);

xlabel('Shear rate, x [1/s]');
ylabel('Shear stress, y [Pa]');
ldg = legend('Data','Bingham','Herschel-Bulkley','HB Plus','Location','best');
lgd.FontName = 'Times New Roman';
lgd.FontSize = 20;
legend boxoff
set(gca,'FontSize',14);
set(get(gca,'XLabel'),'FontSize',16);
set(get(gca,'YLabel'),'FontSize',16);
