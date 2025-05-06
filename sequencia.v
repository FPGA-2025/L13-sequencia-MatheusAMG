module Sequencia (
    input wire clk,
    input wire rst_n,

    input wire setar_palavra,
    input wire [7:0] palavra,

    input wire start,
    input wire bit_in,

    output reg encontrado
);

reg [7:0] registrador_deslocamento;
reg [7:0] palavra_armazenada;
//reg [2:0] contador;

always @(posedge clk, negedge rst_n) begin
    if (~rst_n) begin
        palavra_armazenada <= 0;
        encontrado <= 0;
        
        registrador_deslocamento <= 0;
        //contador <= 0; //Usei para poder inicializar registrador_deslocamento com 0
    end
    else begin //start mto estranho ele fica ativo só 1 vez
        if (setar_palavra) begin
            palavra_armazenada <= palavra;
        end
        else begin
            registrador_deslocamento <= {registrador_deslocamento[6:0], bit_in};
            //if (contador < 3'd7)begin //Preciso deslocar pelo menos 8 vezes para verificar ele considera 0 antes da palavra.
            //    encontrado <= 0;
            //     contador <= contador + 1;
            //end
            //else begin
            //    contador <= 3'd7;
            if ({registrador_deslocamento[6:0], bit_in} == palavra_armazenada) begin
                encontrado <= 1;
            end
        end
    end
end

endmodule
