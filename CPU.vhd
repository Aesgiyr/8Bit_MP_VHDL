library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity CPU is
	port(
			-- Inputs:
			clk 			: in std_logic;
			rst 			: in std_logic;
			from_memory 	: in std_logic_vector(7 downto 0);
			--Outputs:
			to_memory 		: out std_logic_vector(7 downto 0);
			write_en  		: out std_logic;
			address 		: out std_logic_vector(7 downto 0)
		
	);
end entity;

architecture arch of CPU is 

-- Control Unit
component control_unit is 
	port(
		--Inputs:
		clk 		: in std_logic;
		rst 		: in std_logic;
		CCR_Result 	: in std_logic_vector(3 downto 0);
		IR 			: in std_logic_vector(7 downto 0);
		--Outputs:
		IR_Load 	: out std_logic;
		MAR_Load 	: out std_logic;
		PC_Load 	: out std_logic;
		PC_Inc 		: out std_logic;
		A_Load 		: out std_logic;
		B_Load 		: out std_logic;
		ALU_Sel 	: out std_logic_vector(2 downto 0);
		CCR_Load 	: out std_logic;
		Bus2_Sel 	: out std_logic_vector(1 downto 0);
		Bus1_Sel 	: out std_logic_vector(1 downto 0);
		write_en 	: out std_logic
	);
end component;

-- Data Path
component data_path is
	port(
		--Inputs
		clk 		: in std_logic;
		rst 		: in std_logic;
		IR_Load 	: in std_logic;
		MAR_Load 	: in std_logic;
		PC_Load 	: in std_logic;
		PC_Inc 		: in std_logic;
		A_Load 		: in std_logic;
		B_Load 		: in std_logic;
		ALU_Sel 	: in std_logic_vector(2 downto 0);
		CCR_Load 	: in std_logic;
		Bus2_Sel 	: in std_logic_vector(1 downto 0);
		Bus1_Sel 	: in std_logic_vector(1 downto 0);
		from_memory : in std_logic_vector(7 downto 0);
		--Outputs
		IR 			: out std_logic_vector(7 downto 0); -- Address to memory
		address 	: out std_logic_vector(7 downto 0);
		CCR_Result 	: out std_logic_vector(3 downto 0); -- NZVC
		to_memory 	: out std_logic_vector(7 downto 0)  -- Data to memory
		
	);
end component;

-- Connection Signals

signal IR_Load 		: std_logic;
signal IR 			: std_logic_vector(7 downto 0 );
signal MAR_Load     : std_logic;
signal PC_Load      : std_logic;
signal PC_Inc 	    : std_logic;
signal A_Load 	    : std_logic;
signal B_Load 	    : std_logic;
signal ALU_Sel      : std_logic_vector(2 downto 0);
signal CCR_Load     : std_logic;
signal CCR_Result 	: std_logic_vector(3 downto 0);
signal Bus2_Sel     : std_logic_vector(1 downto 0);
signal Bus1_Sel     : std_logic_vector(1 downto 0);

begin

-- Control Unit:
control_unit_module: control_unit port map
							(
								--Inputs:	=> --Inputs:
								clk 		=> clk,		
								rst 		=> rst,
								CCR_Result 	=> CCR_Result, 	
								IR 			=> IR, 			
								--Outputs:  => --Outputs:
								IR_Load 	=> IR_Load,	
								MAR_Load 	=> MAR_Load, 	
							    PC_Load 	=> PC_Load, 	
							    PC_Inc 		=> PC_Inc, 		
							    A_Load 		=> A_Load,		
							    B_Load 		=> B_Load, 		
							    ALU_Sel 	=> ALU_Sel, 	
							    CCR_Load 	=> CCR_Load, 	
							    Bus2_Sel 	=> Bus2_Sel, 	
							    Bus1_Sel 	=> Bus1_Sel, 	
							    write_en 	=> write_en 	
							);
							
-- Data Path:
data_path_module: data_path port map
							(
								clk 		=> clk, 		
								rst 		=> rst, 		
								IR_Load 	=> IR_Load, 	
								MAR_Load 	=> MAR_Load, 	
								PC_Load 	=> PC_Load, 	
								PC_Inc 		=> PC_Inc, 		
								A_Load 		=> A_Load, 		
								B_Load 		=> B_Load, 		
								ALU_Sel 	=> ALU_Sel, 	
								CCR_Load 	=> CCR_Load,	
								Bus2_Sel 	=> Bus2_Sel, 	
								Bus1_Sel 	=> Bus1_Sel, 	
								from_memory => from_memory, 
								--Outputs   => --Outputs
								IR 			=> IR, 			
								address 	=> address, 	
								CCR_Result 	=> CCR_Result, 	
								to_memory	=> to_memory 	
							);

end architecture;