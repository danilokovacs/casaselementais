# Desafio de SELECTS em Banco de Dados

Em um reino antigo existem quatro casas guerreiras sendo elas: Acquas, Magnus, Terranos e Sopranos, cada casa possui um exercito que podem ser 
classificados como pequeno, médio ou grande, sendo liderados por um lider com classificação de experiencia baixa, media ou alta, o lider tambem 
possui poderes de um elemento sendo eles: terra, fogo, ar e água. Cada elemento possui dois poderes, um de ataque e um de defesa. As casas 
batalham entre si sendo que só podem haver duas casas por batalha e uma vencedora. Cada batalha pode ocorrer durante o dia ou durante a noite.

Primeiro passo:
<br>
[Script de criação do banco de dados](script_casaselementais.sql)

# Desafios:

## Nível Fácil:

<details>
  <summary>
    Me informe a batalha em que a penultima letra é 'E'
  </summary>
  
    select * from batalha where nome like '%e_';
</details>

<details>
  <summary>
    Exibe o resultado das batalhas onde o atacante é o vencedor
  </summary>
  
    select * from resultado where fkCasaAtacante = fkVencedora;
</details>

<details>
  <summary>
    Exiba o nome de uma casa cuja 3ª letra seja p
  </summary>
  
    select nome as NomeCasa from casa where nome like '__p%';
</details>

<details>
  <summary>
    Me informe apenas o nome e a descrição dos poderes que são apenas ataques
  </summary>
  
    select nome, descricao from poder where descricao = 'ataque';
</details>

<details>
  <summary>
    Informe os nomes das batalhas ordenados pelo nome
  </summary>
  
    select * from batalha order by nome;
</details>

<details>
  <summary>
    Selecione todas os lideres ordenadas pelo nome
  </summary>
  
    select * from lider order by nome;
</details>


## Nível Médio:

<details>
  <summary>
    Me informe quantas batalhas a casa Magnus ganhou
  </summary>
  
    select count(fkVencedora), casa.nome from resultado join casa on fkVencedora = idCasa where casa.nome = 'Magnus';
</details>

<details>
  <summary>
    Exiba a quantidade de vitórias de uma determinada casa onde o periodo foi de noite
  </summary>
  
    select fkCasaAtacante, count(fkVencedora) as Vitorias, fkPeriodo as Periodo from resultado where fkCasaAtacante = 501 and fkVencedora = 501 and fkPeriodo = 2;
</details>

<details>
  <summary>
    Exiba apenas o nome do lider que venceu a última batalha
  </summary>
    
    select l.nome as NomeLider, r.dataBatalha from resultado as r join casa on fkVencedora = idCasa join exercito on fkExercito = idExercito join lider as l on fkLider = idLider order by r.dataBatalha desc limit 1;
</details>

<details>
  <summary>
    Me informe a quantidade de vitórias durante a noite agrupadas por casa em ordem decrescente
  </summary>
  
    select casa.nome as 'Nome da Casa', count(fkVencedora) as 'Número de Vitórias', periodo.descricao as 'Periodo' from casa join resultado on fkVencedora = idCasa join periodo on fkPeriodo = idPeriodo where periodo.descricao = 'noite' group by casa.nome order by count(fkVencedora) desc;
</details>

<details>
  <summary>
    Me informe quantas batalhas teve no periodo da noite e no periodo do dia
  </summary>
  
    select count(fkPeriodo) as 'quantidade de batalhas a noite' from resultado join periodo on fkperiodo=idperiodo
where idperiodo = 2;
</details>

<details>
  <summary>
    Me informe o lider de cada exercito e as batalhas em que lutaram e os elementos que representam
  </summary>
  
    select lider.nome as 'nome dos lideres', exercito.tamanho as 'tamanho do exercito que lideram', elemento.nome as 'elemento que controlam'
from lider join exercito on fkLider = idLider
join elemento on fkElemento = idElemento;
</details>



## Nível Difícil:

<details>
  <summary>
    Me informe APENAS o nome do lider, o seu elemento que contém o poder "Vendaval cortante" e o tamanho do seu exercito
  </summary>
  
    select lider.nome, elemento.nome, tamanho from lider join elemento on lider.fkElemento = elemento.idElemento join exercito on fkLider = idLider join poder on poder.fkElemento = elemento.idElemento where poder.nome = 'Vendaval cortante';
</details>

<details>
  <summary>
    Exibir o nome da casa atacante, o nome da casa defensiva, o nome da vencedora, o periodo sendo dia ou noite, e as datas das batalhas
  </summary>
  
    select ca.nome as Atacante, cd.nome as Defensiva, cv.nome as Vencedora, p.descricao as Periodo, dataBatalha from resultado join casa as ca on fkCasaAtacante = ca.idCasa join casa as cd on fkCasaDefesa = cd.idCasa join casa as cv on fkVencedora = cv.idCasa join periodo as p on fkPeriodo = idPeriodo;
</details>

<details>
  <summary>
    Me mostre o nome de todas as batalhas, as casas que batalharam entre si, a casa vencedora, os líderes das casas que venceram as batalhas, o elemento e o tamanho do exército de cada líder.
  </summary>
  
    select batalha.nome as Batalha, ca.nome as 'Casa Atacante', cd.nome as 'Casa Defensiva', cv.nome as 'Casa Vencedora', lider.nome as 'Líder da Casa', exercito.tamanho as 'Tamanho do Exército', elemento.nome as 'Elemento' from batalha join resultado on fkBatalha = idBatalha join casa as ca on fkCasaAtacante = ca.idCasa join casa as cd on fkCasaDefesa = cd.idCasa join casa as cv on fkVencedora = cv.idCasa join exercito on cv.fkExercito = idExercito join lider on fkLider = idLider join elemento on fkElemento = idElemento;
</details>


## Nível Challenge:

<details>
  <summary>
    Me mostre o nome de todas as batalhas, o período em que elas ocorreram, o nome das casas que batalharam entre si, a casa vencedora, o líder da casa defensora, o tamanho do exército da casa defensora, o elemento do líder da casa vencedora agrupado por nome de batalha
  </summary>
  
    select batalha.nome as 'Nome da Batalha', periodo.descricao as Período, ca.nome as 'Casa Atacante', cd.nome as 'Casa Defensora', cv.nome as 'Casa Vencedora', li.nome as 'Líder Defensor', exercito.tamanho as 'Exército de Defesa', elcv.nome as 'Elemento Vencedor' from batalha join resultado on fkBatalha = idBatalha join periodo on fkPeriodo = idPeriodo join casa as ca on fkCasaAtacante = ca.idCasa join casa as cd on fkCasaDefesa = cd.idCasa join casa as cv on fkVencedora = cv.idCasa join exercito as ecv on ecv.idExercito = cv.fkExercito join exercito on cd.fkExercito = exercito.idExercito join lider as licv on licv.idLider = ecv.fkLider join lider as li on exercito.fkLider = li.idLider join elemento as elcv on elcv.idElemento = licv.fkElemento join elemento on li.fkElemento = elemento.idElemento join poder as po on po.fkElemento = elemento.idElemento group by batalha.nome;
</details>

<details>
  <summary>
    Exiba o nome da casa, a contagem de vitórias, o nome do líder do exercito, o elemento, seu poder de ataque, o tamanho de seu exército, agrupado pelo nome das casas e pelo poder ordenado pelo numero de vitórias
  </summary>
  
    select casa.nome as 'Nome da Casa', count(fkVencedora) as 'Número de Vitórias', l.nome as 'Nome do Lider', e.nome as 'Nome do Elemento', p.nome as 'Nome do Poder', ex.tamanho as 'Tamanho do Exército' from casa join resultado as r on r.fkVencedora = casa.idCasa join exercito as ex on casa.fkExercito = ex.idExercito join lider as l on fkLider = idLider join elemento as e on l.fkElemento = e.idElemento join poder as p on p.fkElemento = e.idElemento where p.descricao = 'Ataque' group by casa.nome, p.descricao order by count(fkVencedora);
  
</details>

<details>
  <summary>
    Exibir o nome da batalha, o nome da casa atacante, o nome da casa defensiva, o nome da vencedora, o periodo sendo dia ou noite, as datas das batalhas, a contagem de vitórias, o nome do líder do exercito, o elemento, seu poder de ataque, o tamanho de seu exército, agrupado pelo nome das casas e pelo poder e ordenado pela contagem de vitórias
  </summary>
  
    select b.nome as 'Nome da Batalha', atacante.nome as 'Casa Atacante', defensiva.nome as 'Casa Defensiva', vencedora.nome as 'Casa Vencedora', pe.descricao as Periodo, dataBatalha, vencedora.nome as 'Nome da Casa', count(fkVencedora) as 'Número de Vitórias', l.nome as 'Nome do Lider', e.nome as 'Nome do Elemento', p.nome as 'Nome do Poder', ex.tamanho as 'Tamanho do Exército' from casa join resultado as r on r.fkVencedora = casa.idCasa join periodo as pe on pe.idPeriodo = fkPeriodo join casa as vencedora on vencedora.idCasa = r.fkVencedora join casa as atacante on atacante.idCasa = r.fkCasaAtacante join casa as defensiva on defensiva.idCasa = r.fkCasaDefesa join batalha as b on b.idBatalha = r.fkBatalha join exercito as ex on casa.fkExercito = ex.idExercito join lider as l on fkLider = idLider join elemento as e on l.fkElemento = e.idElemento join poder as p on p.fkElemento = e.idElemento where p.descricao = 'Ataque' group by casa.nome, p.descricao order by count(fkVencedora);
</details>
