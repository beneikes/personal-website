clear

% model parameters
R = 0.5;
L = 500e-6;
t_s = 1/20000;

% design parameters
f_des = 500;
T_des = 1/(2*pi*f_des);

% continuous plant model
ssPlant = ss(-R/L,[1/L -1/L],1,[0 0]);
ssPlant.InputName = {'u_req', 'u_dist'};
ssPlant.StateName = 'i_dot';
ssPlant.OutputName = 'i';

% discrete plant model
dssPlant = c2d(ssPlant,t_s,'zoh');
% add input delay
dssDelay = ss(0,1,1,0,t_s);
dssDelay.InputName = 'u_req';
dssDelay.StateName = 'u_req';
dssDelay.OutputName = 'u';
dssPlant.InputName = {'u', 'u_dist'};
dssPlant = connect(dssDelay,dssPlant,{'u_req','u_dist'},'i');

% PI compensation control (continuous)
k_p = L/T_des;
k_i = R/T_des;
ssPI_c = ss(0,k_i,1,k_p);
ssPI_c.InputName = 'e';
ssPI_c.OutputName = 'u_req';
sum = sumblk('e = i_ref - i');
sysPI_c = connect(ssPlant,sum,ssPI_c,{'i_ref','u_dist'},{'i'});

% continuous compensation control discretized
dssPI_d = c2d(ssPI_c,t_s,'foh');
sysPI_d = connect(dssPlant,sum,dssPI_d,{'i_ref','u_dist'},{'i'});

% direct discrete compensation control
V = 1-exp(-t_s/T_des);
z = exp(-t_s/(L/R));
k_p_dd = V/(1/R)*z/(1-z);
k_i_dd = (exp(t_s/(L/R))-1)/t_s*k_p_dd;
dssPI_dd = ss(1,k_i_dd*t_s,1,k_p_dd+k_i_dd*t_s,t_s);
dssPI_dd.InputName = 'e';
dssPI_dd.OutputName = 'u_req';
sysPI_dd = connect(dssPlant,sum,dssPI_dd,{'i_ref','u_dist'},{'i'});

% direct discrete compensation control with back calculation
dssPI_dd_bc = ss(1-((k_i*t_s)/(k_i*t_s+k_p)),[0 (k_i*t_s)/(k_i*t_s+k_p)],1,[(k_p+k_i*t_s) 0],t_s);
dssPI_dd_bc.InputName = {'e','u_req'};
dssPI_dd_bc.OutputName = 'u_req';
sysPI_dd_bc = connect(dssPlant,sum,dssPI_dd_bc,{'i_ref','u_dist'},{'i'});

% simplest implementation
dssPI_simple = ss(1-k_i*t_s/k_p,[0 k_i*t_s/k_p],1,[k_p 0],t_s);
dssPI_simple.InputName = {'e','u_req'};
dssPI_simple.OutputName = 'u_req';
sysPI_simple = connect(dssPlant,sum,dssPI_simple,{'i_ref','u_dist'},{'i'});


t_step = 0.005;
[i_ref, t] = step(c2d(sysPI_c('i','i_ref'),t_s,'zoh'),t_step);


[i_dd_bc, ~] = step(sysPI_dd_bc('i','i_ref'),t);
e_i_dd_bc = i_ref - i_dd_bc;

[i_simple, ~] = step(sysPI_simple('i','i_ref'),t);
e_i_simple = i_ref - i_simple;

figure;
stairs(t,e_i_dd_bc)
hold all
stairs(t,e_i_simple)
grid on
grid minor
xlabel('t / sec')
ylabel('e_i / A')
legend('Back-Calculation FOH','Back-Calculation ZOH')

% figure;
% step(sysPI_c('i','i_ref'))
% hold all
% step(sysPI_d('i','i_ref'))
% step(sysPI_dd('i','i_ref'))
% step(sysPI_dd_bc('i','i_ref'))
% step(sysPI_simple('i','i_ref'))
% grid on
% grid minor
% legend('Continuous','Discretized','Direct Discrete','Direct Discrete Back-Calculation','Simple')




% figure;
% step(sysPI_c('i','i_ref'))
% hold all
% step(sysPI_d('i','i_ref'))
% step(sysPI_dd('i','i_ref'))
% step(sysPI_dd_bc('i','i_ref'))
% step(sysPI_simple('i','i_ref'))
% grid on
% grid minor
% legend('Continuous','Discretized','Direct Discrete','Direct Discrete Back-Calculation','Simple')








