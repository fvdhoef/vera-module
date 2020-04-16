component sprite_ram is
    port(
        wr_clk_i: in std_logic;
        rd_clk_i: in std_logic;
        rst_i: in std_logic;
        wr_clk_en_i: in std_logic;
        rd_en_i: in std_logic;
        rd_clk_en_i: in std_logic;
        wr_en_i: in std_logic;
        ben_i: in std_logic_vector(3 downto 0);
        wr_data_i: in std_logic_vector(31 downto 0);
        wr_addr_i: in std_logic_vector(7 downto 0);
        rd_addr_i: in std_logic_vector(7 downto 0);
        rd_data_o: out std_logic_vector(31 downto 0)
    );
end component;

__: sprite_ram port map(
    wr_clk_i=>,
    rd_clk_i=>,
    rst_i=>,
    wr_clk_en_i=>,
    rd_en_i=>,
    rd_clk_en_i=>,
    wr_en_i=>,
    ben_i=>,
    wr_data_i=>,
    wr_addr_i=>,
    rd_addr_i=>,
    rd_data_o=>
);
