----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Reference:  https://github.com/nkkav/complexpack/
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.math_real.all;

package ComplexPackage is 
    constant re : integer := 0;
    constant im : integer := 1;
    type complex is array (natural range re to im) of real;

    constant rho   : integer := 0;
    constant theta : integer := 1;
    type polar is array (natural range rho to theta) of real;

    function to_complex (a, b : real) return complex;
    function get_real (a : complex) return real;
    function get_imaginary (a : complex) return real;
    function "+" (a, b : complex) return complex;
    function "-" (a, b : complex) return complex;
    function "-" (a : complex) return complex;
    function "*" (a, b : complex) return complex;
    function "/" (a, b : complex) return complex;
    function mac (a, b, c : complex) return complex;
    function reciprocal (a : complex) return complex;
    function conjugate (a : complex) return complex;
    function magnitude (a : complex) return real;
    function arg (a : complex) return real;
    function "abs" (a : complex) return real;
    function "<"  (a, b : complex) return boolean;  
    function ">"  (a, b : complex) return boolean;  
    function "<=" (a, b : complex) return boolean;  
    function ">=" (a, b : complex) return boolean;  
    function "="  (a, b : complex) return boolean;  
    function "/=" (a, b : complex) return boolean;

    function exp (a : complex) return complex;
    function log (a : complex) return complex;
    function pow (a, b : complex) return complex;
    function sqrt (a : complex) return complex;
    function sin (a : complex) return complex;
    function cos (a : complex) return complex;
    function tan (a : complex) return complex;

    function arcsin (a : complex) return complex;  
    function arccos (a : complex) return complex;
    function arctan (a : complex) return complex;

    function to_polar(a : complex) return polar;
    function to_cartesian(a : polar) return complex;

end ComplexPackage;

package body ComplexPackage is 

function to_complex (a, b : real) return complex is
    variable t : complex;
  begin
    t(re) := a;
    t(im) := b;
    return t;
  end to_complex;

  function get_real (a : complex) return real is
    variable t : real;
  begin
    t := a(re);
	return t;
  end get_real;   

  function get_imaginary (a : complex) return real is
    variable t : real;
  begin
    t := a(im);
	return t;
  end get_imaginary;   
  
  function "+" (a, b : complex) return complex is
    variable t : complex;
  begin
    t(re) := a(re) + b(re);
    t(im) := a(im) + b(im);
    return t;
  end "+";

  function "-" (a, b : complex) return complex is
    variable t : complex;
  begin
    t(re) := a(re) - b(re);
    t(im) := a(im) - b(im);
    return t;
  end "-";

  function "-" (a : complex) return complex is
    variable t : complex;
  begin
    t(re) := - a(re);
    t(im) := - a(im);
    return t;
  end "-";
  
  function "*" (a, b : complex) return complex is
    variable t : complex;
  begin
    t(re) := a(re) * b(re) - a(im) * b(im);
    t(im) := a(re) * b(im) + b(re) * a(im);
    return t;
  end "*";

  function "/" (a, b : complex) return complex is
    variable i : real;
    variable t : complex;
  begin
    t(re) := a(re) * b(re) + a(im) * b(im);
    t(im) := b(re) * a(im) - a(re) * b(im);
    i := b(re)**2 + b(im)**2;
    t(re) := t(re) / i;
    t(im) := t(im) / i;
    return t;
  end "/";

  -- a * b + c
  function mac (a, b, c : complex) return complex is
    variable t : complex;
    variable u : complex;
  begin
    u := a * b;
    t(re) := c(re) + u(re);
    t(im) := c(im) + u(im);
    return t;
  end mac;

  function reciprocal (a : complex) return complex is
    variable t : complex;
  begin
    t(re) := a(re) / (a(re) * a(re) + a(im) * a(im));
    t(im) := -a(im) / (a(re) * a(re) + a(im) * a(im));
    return t;
  end reciprocal;

  function conjugate (a : complex) return complex is
    variable t : complex;
  begin
    t(re) := a(re);
    t(im) := -a(im);
    return t;
  end conjugate;
  
  function magnitude (a: complex) return real is
    variable t : real;
  begin
    t := sqrt(a(re)*a(re) + a(im)*a(im));
    return t;
  end magnitude;

  function arg (a : complex) return real is
    variable t : real;
  begin
    t := arctan(a(im), a(re));
    return t;
  end arg;

  function "abs" (a: complex) return real is
  begin
    return (magnitude(a));
  end "abs";
  
  function "<" (a, b : complex) return boolean is
    variable t : boolean;
  begin
    t := (magnitude(a) < magnitude(b));
    return t;
  end "<";  

  function ">" (a, b : complex) return boolean is
    variable t : boolean;
  begin
    t := (magnitude(a) > magnitude(b));
    return t;
  end ">";  

  function "<=" (a, b : complex) return boolean is
    variable t : boolean;
  begin
    t := (magnitude(a) <= magnitude(b));
    return t;
  end "<=";  

  function ">=" (a, b : complex) return boolean is
    variable t : boolean;
  begin
    t := (magnitude(a) >= magnitude(b));
    return t;
  end ">=";  

  function "=" (a, b : complex) return boolean is
    variable t : boolean;
  begin
    t := (magnitude(a) = magnitude(b));
    return t;
  end "=";  

  function "/=" (a, b : complex) return boolean is
    variable t : boolean;
  begin
    t := (magnitude(a) /= magnitude(b));
    return t;
  end "/=";

  function exp (a : complex) return complex is
    variable t : complex;
    variable exponent : real;
  begin
    exponent := exp(a(re));
    t(re) := exponent * cos(a(im));
    t(im) := exponent * sin(a(im));
    return t;
  end exp;

  function log (a : complex) return complex is
    variable t : complex;
    variable real_part : real;
    variable imag_part : real;
  begin
    real_part := magnitude(a);
    imag_part := arctan(a(im), a(re));
    if (imag_part > MATH_PI) then
      imag_part := imag_part - 2.0 * MATH_PI;
    end if;
    t(re) := log(real_part);
    t(im) := imag_part;
    return t;
  end log;

  function pow (a, b : complex) return complex is
    variable t : complex;
    variable logv, u : complex;
  begin
     logv := log(a);
     u := logv * b;
     t := exp(u);
     return t;
  end pow;
  
  function sqrt(a : complex) return complex is
    variable t : complex;
    variable mag : real;
    variable real_part : real;
    variable imag_part : real;    
  begin
    mag := magnitude(a);
    real_part := sqrt(0.5 * (mag + a(re)));
    imag_part := sqrt(0.5 * (mag - a(re)));
    if (a(im) < 0.0) then
      imag_part := -imag_part;
    end if;
    t(re) := real_part;
    t(im) := imag_part;
    return t;
  end sqrt;

  function sin(a : complex) return complex is
    variable t : complex;
  begin
    t(re) := sin(a(re)) * cosh(a(im));
    t(im) := cos(a(re)) * sinh(a(im));
    return t;
  end sin;

  function cos(a : complex) return complex is
    variable t : complex;
  begin
    t(re) := cos(a(re)) * cosh(a(im));
    t(im) := sin(a(re)) * sinh(a(im));
    return t;
  end cos;
 
  function tan(a : complex) return complex is
    variable t : complex;
    variable u : complex;
    variable v : complex;
  begin
    u := sin(a);
    v := cos(a);
    t := u / v;
    return t;
  end tan;

  function arcsin(a : complex) return complex is
    variable t : complex;
    variable u, v, uplusv, uminusv : real;
  begin
    u := 0.5 * sqrt((a(re) + 1.0) * (a(re) + 1.0) + a(im) * a(im));
    v := 0.5 * sqrt((a(re) - 1.0) * (a(re) - 1.0) + a(im) * a(im));
    uplusv := u + v;
    uminusv := u - v;
    t(re) := arcsin(uminusv);
    t(im) := log(uplusv + sqrt(uplusv * uplusv - 1.0));
    return t;
  end arcsin;

  function arccos(a : complex) return complex is
    variable t : complex;
    variable n, u, v, uminusv : real;
  begin
    n := magnitude(a);
    u := 0.5 * sqrt(1.0 + n + 2.0 * a(re));
    v := 0.5 * sqrt(1.0 + n - 2.0 * a(re));
    uminusv := u - v;
    u := u + v;
    t(re) := arccos(uminusv);
    t(im) := log(u + sqrt(u * u - 1.0));
    return t;
  end arccos;

  function arctan (a : complex) return complex is
    variable t : complex;
    variable u, v, y : complex;
  begin
    u := to_complex(1.0 - a(im), a(re));
    v := to_complex(1.0 + a(im), a(re));
    u := v - u;
    u(re) := u(re) / 2.0;
    u(im) := u(im) / 2.0;
    y := to_complex(0.0, -1.0);
    t := y * u;
    return t;
  end arctan;

  function to_polar(a : complex) return polar is
    variable t : polar;
  begin
    t(rho)   := magnitude(a);
    t(theta) := arctan(a(im), a(re));
    return t;
  end to_polar;

  function to_cartesian(a : polar) return complex is
    variable t : complex;
  begin
    t(re) := a(rho) * cos(a(theta));
    t(im) := a(rho) * sin(a(theta));
    return t;
  end to_cartesian;

end ComplexPackage;  
