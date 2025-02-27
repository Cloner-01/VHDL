#half_adder

entity half_adder is
  port(a,b:in bit;s,cout:out bit)

end half_adder;

  architecture madar of half_adder is
begin
      s <= a xor b;
      cout <= a and b;

end madar;

#full_adder

entity full_adder is
  port(a,b,cin:in bit;s,cout:out bit)

end full_adder;

  architecture madar of full_adder is
begin
      s <= a xor b xor cin;
      c <= (a and b) or (a and cin) or (b and cin);

end madar;

#MUX4*1

entity mux 4*1 is
  port(a,b,c,d,s1,s0:in bit;muxout:out bit)

end mux 4*1;

  architecture First of mux 4*1 is
begin
    muxout <= (not s1 and not s0 and a) or 
              (not s1 and s0 and b) or  
              (s1 and not s0 and c) or 
              (s1 and s0 and d);
end First;

#full_adder_8bit

entity full_majoul is
  port (A,B,Cin:in bit;S,Cout:out bit)

end full_majoul;

  architecture First of full_majoul is
    component cloner
      port (a,b:in bit;s,c:out bit)

    end component;

for all : cloner use entity work.HA_rashid (saed)
  signal im1 , im2 , im3 : bit;
  begin
    g0: cloner port map ( A,B,im1,im2);
    g1: cloner port map (im1,Cin,S,im3);
    Cout<= im2 or im3;
end First;

#8-bit adder

entity adder8bit is
  port(a7,a6,a5,a4,a3,a2,a1,a0,
      b7,b6,b5,b4,b3,b2,b1,b0,Cin:in bit ;
      s7,s6,s5,s4,s3,s2,s1,s0,Cout:out bit);  
end adder8bit;

architecture first of adder8bit is
  component cloner
    port(A,B,Cin:in bit;Sum,carry_out:out bit)
  end component;
for all : cloner use entity work.full_adder(first);
  signal x7,x6,x5,x4,x3,x2,x2,x1:bit;
begin
  g0: cloner port map (a0,b0,Cin,s0,x1);
  g1: cloner port map (a1,b1,x1,s1,x2);
  g2: cloner port map (a2,b2,x2,s2,x3);
  g3: cloner port map (a3,b3,x3,s3,x4);
  g4: cloner port map (a4,b4,x4,s4,x5);
  g5: cloner port map (a5,b5,x5,s5,x6);
  g6: cloner port map (a6,b6,x6,s6,x7);
  g7: cloner port map (a7,b7,x7,s7,Cout);
end first;

#adder_8bit

entity adder8bit is
  port (A,B:in bit_vector (7 downto 0);
        Cin:in bit;
        S:out bit_vector (7 downto 0);
        Cout:out bit);
end adder8bit;

architecture first of adder8bit is
  component of cloner
    port (A,B,Cin :in bit;Sum,carry_out:out bit)
end component;
for all : cloner use entity work.full_adder(first);
  signal X : bit_vector (7 downto 1);
begin
  g0: cloner port map (a(0),b(0),Cin,s(0),x(1));
  g1: cloner port map (a(1),b(1),x(1),s(1),x(2));
  g2: cloner port map (a(2),b(2),x(2),s(2),x(3));
  g3: cloner port map (a(3),b(3),x(3),s(3),x(4));
  g4: cloner port map (a(4),b(4),x(4),s(4),x(5));
  g5: cloner port map (a(5),b(5),x(5),s(5),x(6));
  g6: cloner port map (a(6),b(6),x(6),s(6),x(7));
  g7: cloner port map (a(7),b(7),x(7),s(7),Cout);
end first;

# MUX4*1_8bit

entity mux8_bit is
  port (A,B,C,D:in bit_vector(7 downto 0);
        S1,S0:in bit;
        muxout:out bit_vectore(7 downto 0));
end mux8_bit;

architecture Ali of mux8_bit is
  component cloner
    port (A,B,C,D,S1,S0:in bit;muxout:out bit);
end component ;
  for all : cloner use entity work. mux 4*1(first);
begin
  mux7 : cloner port map (A(7),B(7),C(7),D(7),S1,S0,muxout(7));
  mux6 : cloner port map (A(6),B(6),C(6),D(6),S1,S0,muxout(6));
  mux5 : cloner port map (A(5),B(5),C(5),D(5),S1,S0,muxout(5));
  mux4 : cloner port map (A(4),B(4),C(4),D(4),S1,S0,muxout(4));
  mux3 : cloner port map (A(3),B(3),C(3),D(3),S1,S0,muxout(3));
  mux2 : cloner port map (A(2),B(2),C(2),D(2),S1,S0,muxout(2));
  mux1 : cloner port map (A(1),B(1),C(1),D(1),S1,S0,muxout(1));
  mux0 : cloner port map (A(0),B(0),C(0),D(0),S1,S0,muxout(1));
end   Ali ;

#AU_8bit

entity AU8bit is
  port (A,B:in bit_vector (7 downto 0);
        s1,s0:in bit;
        F:out bit_vector (7 downto 0));
end AU8bit;

architecture first of AU8bit is
  component cloner1
    port (A,B:in bit_vector( 7 downto 0 );
          Cin:in bit ;
          S: out bit_vector(7 downto 0);
          Cout : out bit);
end component;

  component cloner2
    port (A,B,C,D:in bit_vector(7 downto 0);
          s1,s0 : in bit;
          muxout:out bit_vector(7 downto 0));
end component;

for all:cloner1 use entity work.adder8bit (first);
for all:cloner2 use entity work.max4x18bit (first);
  signal x,Bnot:bit_vector(7 downto 0);
  signal zero8:bit_ vector(7 downto 0) : ="00000000";
  signal one8:bit_vector(7 downto 0 ) : ="11111111";
  signal im1,im2:bit;
begin
  bnot <= not b;
  g0 : cloner2 port map (B,bnot,zero8,one8,s1,s0,x);
  im1 <= (not s1 . s0);
  g1 : cloner1 port map(A,x,im1,F,im2);
end first;
