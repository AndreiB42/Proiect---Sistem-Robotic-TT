function TT_Robot(q,l)

for t=0:0.01:1
cla

axis([-5 5 -5 5])
P_1 = [1;0]
P_2 = [1;5]
P_3 = [5;5]
P_4 = [5;0]
Square = [P_1,P_2,P_3,P_4,P_1]

q_1 = -2*q(1,:)*t.^3 + 3*q(1,:)*t.^2
q_2 = -2*q(1,:)*t.^3 + 3*q(1,:)*t.^2

%q_1(0) = 0  q_1(0) = a_0 = 0
%q_1(t_f) = q(1,:) q_1(1) = a_3 + a_2 + a_1 = q(1,:) -2*a_2/3 +3*a_2/3 =
%a_2 = 3*q(1,:)
%a_3 = -2*q(1,:)

%q_1'(t) = 3*a_3*t.^2 + 2*a_2*t +a_1
%q_1'(0) = 0 q_1'(0) = a_1 = 0
%q_1'(t_f) = 0 q_1'(1) = 3*a_3 + 2*a_2 = 0 a_3 = -2*a_2/3

x = [0.01;0;0]
y = [0;0.01;0]
o = [0;0;0]

T_01 = [1 , 0 , 0 , 0; ...
        0 , 1 , 0 , l(1,:) + q_1; ...
        0 , 0 , 1 , 0; ...
        0 , 0 , 0 , 1]
T_12 = [1 , 0 , 0 , l(2,:) + q_2; ...
        0 , 1 , 0 , 0; ...
        0 , 0 , 1 , 0; ...
        0 , 0 , 0 , 1]
T_23 = [1 , 0 , 0 , 0 ;...
        0 , 1 , 0 , l(3,:); ...
        0 , 0 , 1 , 0; ...
        0 , 0 , 0 , 1]
T_3e = [1 , 0 , 0 , l(4,:); ...
        0 , 1 , 0 , 0; ...
        0 , 0 , 1 , 0; ...
        0 , 0 , 0 , 1]

T_02 = T_01 * T_12 
T_03 = T_02 * T_23
T_0e = T_03 * T_3e 


Ox = T_01*[x;1]
Oy = T_01*[y;1]
Oo = T_01*[o;1]

Sx = T_02*[x;1]
Sy = T_02*[y;1]
So = T_02*[o;1]

Qx = T_03*[x;1]
Qy = T_03*[y;1]
Qo = T_03*[o;1]

Px = T_0e*[x;1]
Py = T_0e*[y;1]
Po = T_0e*[o;1]

O =[T_01(1,4);T_01(2,4)]'
S =[T_02(1,4);T_02(2,4)] 
P =[T_0e(1,4);T_0e(2,4)]

R_matrix = [[o;1],Oo,So,Qo,Po]

r1=rectangle('Position',[-0.2 0.5 0.4 1.2],'Curvature',0.2)
r1.FaceColor = 'black';
r2=rectangle('Position',[So(1,:)-0.5 Sx(1,:)-0.25 1 0.5],'Curvature',0.2)
r2.FaceColor = 'black';

plot([Po(1,:),Px(1,:)+0.5],[Po(2,:),Px(2,:)+0.5],'black','LineWidth',1)
%plot([Po(1,:)+0.3,Px(1,:)+0.2],[Po(2,:)+0.3,Px(2,:)+0.2],'black','LineWidth',1)
plot([Po(1,:),Py(1,:)+0.5],[Po(2,:),Py(2,:)-0.5],'black','LineWidth',1)
%plot([Po(1,:)-0.2,Py(1,:)-0.4],[Po(2,:)-0.2,Py(2,:)-0.2],'black','LineWidth',1)





plot(Square(1,:),Square(2,:),'green','LineWidth',1)
plot(R_matrix(1,:),R_matrix(2,:),'black','LineWidth',0.5)

plot([Oo(1,:),Ox(1,:)],[Oo(2,:),Ox(2,:)],'r','LineWidth',1)
plot([Oo(1,:),Oy(1,:)],[Oo(2,:),Oy(2,:)],'b','LineWidth',1)

plot([So(1,:),Sx(1,:)],[So(2,:),Sx(2,:)],'r','LineWidth',1)
plot([So(1,:),Sy(1,:)],[So(2,:),Sy(2,:)],'b','LineWidth',1)

plot([Po(1,:),Px(1,:)],[Po(2,:),Px(2,:)],'r','LineWidth',1)
plot([Po(1,:),Py(1,:)],[Po(2,:),Py(2,:)],'b','LineWidth',1)

hold on
grid on

pause (0.001)
end

end