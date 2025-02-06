SELECT 

	TO_DATE(data_atendimento, 'DD/MM/YYYY') 										as "Data de Atendimento"
	, TO_DATE(data_inicial_chamada, 'DD/MM/YYYY') 									as "Data Inicial da Chamada"
	, TO_CHAR(TO_DATE(data_inicial_chamada, 'DD/MM/YYYY'), 'Day') 					as "DIA_SEMANA"
	, CEIL((EXTRACT(DAY FROM TO_DATE(data_inicial_chamada, 'DD/MM/YYYY')) + 
		(EXTRACT(DOW FROM DATE_TRUNC('MONTH', 
			TO_DATE(data_inicial_chamada, 'DD/MM/YYYY'))) % 7) / 7.0))				as "SEMANA_MES"
	, servico 																		as "Serviço"
	, agente 																		as "Agente" 
	, tempo_conversacao 															as "Tempo de Conversação"
	, origem 																		as "Origem"
	, classificacao_chamada 														as "Classificação da Chamada"
	, condicao_desligamento 														as "Condição de Desligamento"
	,'VOZ' 																			as "EQUIPE"
	, CASE WHEN CAST(tempo_conversacao as INTEGER) >= 240 THEN 'até 240s'
		WHEN CAST(tempo_conversacao as INTEGER) >= 480 THEN 'de 241 a 480s'
		WHEN CAST(tempo_conversacao as INTEGER) >= 720 THEN 'de 481 a 720s'
		WHEN CAST(tempo_conversacao as INTEGER) >= 960 THEN 'de 721 a 960s'
		ELSE 'mais de 960'															end as "RangeTMA"
	
FROM
	atendimento.base_digitro;
