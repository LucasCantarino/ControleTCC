Descrição da função dos arquivos matlab/simulink:

IdentificaPlanta.m -> Obtém as plantas de malha interna dos motores esquerdo e direito.

main_malha_interna.m -> Utiliza as plantas de malha interna (arquivo IdentificaPlanta.m) para obter os ganhos dos controladores PI. Esse arquivo chama os arquivos otimiza_Dir.m e otimiza_Esq.m.

otimiza_Dir.m -> Obtém a resposta ao degrau da malha interna do motor direito.

otimiza_Esq.m -> Obtém a resposta ao degrau da malha interna do motor esquerdo.

plantaMalhaInterna.slx -> Utiliza as funções de transferência das plantas dos motores esquerdo e direito (arquivo IdentificaPlanta.m) e controlador (arquivo main_malha_interna.m) para obter o sistema controlado de malha fechada das malhas internas.

planta.slx -> Implementação completa da planta de malha externa do robô, utilizando os arquivos das plantas de malha interna (arquivo plantaMalhaInterna.slx).

obtem_planta_malha_ext_simplificada.m -> Obtem a versão simplificada da planta do robô através de parâmetros gráficos obtidos na planta completa (arquivo planta.slx).

Main_Malha_Externa.m -> Otimiza os ganhos do controlador de malha externa do robô (arquivo MalhaExternaSimplificadaR2018b.slx) para a planta simplificada utilizando um degrau ideal como referência.

Main_Malha_Externa_referencia.m -> Otimiza os ganhos do controlador de malha externa do robô (arquivo MalhaExternaSimplificadaR2018b.slx) para a planta simplificada utilizando uma resposta ao degrau desejada como referência.

MalhaExternaSimplificada(R2018b).slx -> Utiliza a planta simplificada (arquivo obtem_planta_malha_ext_simplificada.m) para implementar o controle de malha fechada do sistema.

TesteMalhaExterna_referencia(R2018b).slx -> Implementa a resposta ao degrau a ser utilizada como referência para a planta de malha externa (arquivo Main_Malha_Externa_referencia.m).

malha_fechada_planta.slx -> Sistema controlado de malha fechada utilizando a planta de malha externa (arquivo planta.slx).

otimiza_planta_completa.m -> Otimiza os ganhos do controlador de malha externa do robô (arquivo malha_fechada_planta.slx).

otimiza_PIDF_completa ->





