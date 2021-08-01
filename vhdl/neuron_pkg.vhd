USE work.fixed_package.all;

PACKAGE neuron_pkg IS

	TYPE fixed_vector IS ARRAY(NATURAL RANGE<>, INTEGER RANGE <>) OF BIT;

	FUNCTION Activation1(X : fixed) return fixed;
	FUNCTION Activation2(X : fixed) return fixed;

END PACKAGE;

PACKAGE BODY neuron_pkg IS


	-- Funcao de Transferencia (ou Ativacao), baseada no trabalho:
	--  I. Tsmots, O. Skorokhoda and V. Rabyk, "Hardware Implementation of Sigmoid Activation Functions using
	--  FPGA", IEEE 15th Int. Conf. on the Experience of Designing and Application of CAD Systems (CADSM),
	--  Polyana, Ukraine, 2019, pp. 34-38, doi: 10.1109/CADSM.2019.8779253.
	--  ref: https://ieeexplore.ieee.org/abstract/document/8779253
	--  
	-- Parametro de entrada:
	-- 	X : fixed [0,1]
	-- Parametro de saida:
	-- 	SIG : fixed [0,1]
	-- Retorna:
	--  / Se      X < -4	SIG =  0.0
	--  | Se -4 < X < 0 	SIG = +0.03125*X**2+0.25*X+0.5
	-- <  Se      X = 0 	SIG = +0.5
	--  | Se  0 < X < 4 	SIG = -0.03125*X**2+0.25*X+0.5
	--  \ Se      X >= 4 	SIG = +1.0
		
	FUNCTION Activation1 (X : fixed) RETURN fixed IS
		CONSTANT X_LEFT: integer := X'left;
		CONSTANT X_RIGHT: integer := X'right;
		CONSTANT a2p: fixed(X'range) := to_fixed(0.03125, X_LEFT, X_RIGHT);
		CONSTANT a2n: fixed(X'range) := to_fixed(-0.03125, X_LEFT, X_RIGHT);
		CONSTANT a1: fixed(X'range) := to_fixed(0.25000, X_LEFT, X_RIGHT);
		CONSTANT a0: fixed(X'range) := to_fixed(0.50000, X_LEFT, X_RIGHT);
		CONSTANT maxSIG: fixed(X'range) := to_fixed(0.99997, X_LEFT, X_RIGHT);
		CONSTANT minSIG: fixed(X'range) := to_fixed(0.00000, X_LEFT, X_RIGHT);
		VARIABLE SIG: fixed(X'range);
	BEGIN
		IF to_integer(X) >= 4 THEN		-- Se      X >= 4 SIG = +1.0
			SIG := maxSIG;
		ELSIF to_integer(X) < -4 THEN	-- Se      X < -4 SIG =  0.0
			SIG := minSIG;
		ELSIF to_integer(X) < 0 THEN	-- Se -4 < X < 0  SIG = (+0.03125*X+0.25)*X+0.5
			SIG := (0.03125 * (to_real(X) * to_real(X))) + (0.25000 * to_real(X)) + a0;
		ELSE							-- Se  0 < X < 4  SIG = (-0.03125*X+0.25)*X+0.5
			SIG := ((-0.03125) * (to_real(X) * to_real(X))) + (0.25000 * to_real(X)) + a0;			
		END IF;
		RETURN SIG;
	END; 	

	-- Funcao de Transferencia (ou Ativacao), adaptada do trabalho:
	--  I. Tsmots, O. Skorokhoda and V. Rabyk, "Hardware Implementation of Sigmoid Activation Functions using FPGA,", 2019
	--  IEEE 15th Int. Conf. on the Experience of Designing and Application of CAD Systems (CADSM), Polyana, Ukraine, 2019
	--  pp. 34-38, doi: 10.1109/CADSM.2019.8779253.
	--  ref: https://ieeexplore.ieee.org/abstract/document/8779253
	-- Parametro de entrada:
	-- 	X : fixed
	-- Parametro de saida:
	-- 	SIG : fixed
	-- Retorna:
	--  / Se      X < -4	SIG = -1.0
	--  | Se -4 < X < 0 	SIG = +0.0625*X**2+0.5*X
	-- <  Se      X = 0 	SIG =  0.0
	--  | Se  0 < X < 4 	SIG = -0.0625*X**2+0.5*X
	--  \ Se      X > 4 	SIG = +1.0
	FUNCTION Activation2 (X : fixed) RETURN fixed IS
		CONSTANT X_LEFT: integer := X'left;
		CONSTANT X_RIGHT: integer := X'right;
		CONSTANT a2p: fixed(X'RANGE) := to_fixed(0.0625, X_LEFT, X_RIGHT);
		CONSTANT a2n: fixed(X'RANGE) := to_fixed(-0.0625, X_LEFT, X_RIGHT);
		CONSTANT a1: fixed(X'RANGE) := to_fixed(0.50000, X_LEFT, X_RIGHT);
		CONSTANT maxSIG: fixed(X'RANGE) := to_fixed(1.00000, X_LEFT, X_RIGHT);
		CONSTANT minSIG: fixed(X'RANGE) := to_fixed(-1.00000, X_LEFT, X_RIGHT);
		VARIABLE SIG: fixed(X'RANGE);
	BEGIN
		IF to_integer(X) >= 4 THEN	-- Se      X >= 4 SIG = +1.0
			SIG := maxSIG;
		ELSIF to_integer(X) < -4 THEN	-- Se      X < -4 SIG = -1.0
			SIG := minSIG;
		ELSIF to_integer(X) < 0 THEN	-- Se -4 < X < 0  SIG = (+0.0625*X+0.5)*X
			SIG := (a2p * X + a1) * X;
		ELSE				-- Se  0 < X < 4  SIG = (-0.0625*X+0.5)*X
			SIG := (a2n * X + a1) * X;			
		END IF;
		RETURN SIG;
	END;

END neuron_pkg;