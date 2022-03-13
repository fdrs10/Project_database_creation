# Project_database_creation
<!-- You have some errors, warnings, or alerts. If you are using reckless mode, turn it off to see inline alerts.
* ERRORs: 0
* WARNINGs: 0
* ALERTS: 16 -->
<p>
</p>
<p>
</p>
<p>
Índice
</p>
<p>
</p>
<h2>Diagrama Entidad relación (ER)</h2>
<p>
Partiendo del siguiente enunciado se explican las diferentes fases en la
creación de la base de datos.
</p>
<p>
<em>Cada caso de corrupción tiene un nombre que lo diferencia de los demás
(Gurtel, ERES, Púnica Malaya, tarjetas black. Puyol,...), una breve
descripción, una estimación de los millones que se han desviado y el ámbito
(Banco, Ayuntamiento, Caja, Comunidad, Estado,...), un caso puede tener varios
ámbitos. Cada caso es investigado por un juez del que se conoce su nombre,
dirección, fecha de nacimiento y fecha en que comenzó a ejercer como juez. Una
vez concluida la investigación del caso se emite un dictamen del caso que se
registra.<br>En cada caso hay una serie de personas implicadas, cada una
de ellas con un cargo principal determinado en el momento en que se produjo el
caso. De cada uno de éstos se conoce su DNI, nombre, dirección y patrimonio.
La corrupción ha llegado a tal extremo que una persona puede estar implicada en
varios casos.<br>Nos va a interesar saber cuántos implicados son
familia, cada implicado puede ser familia de otro o más implicados, nos
interesa saber el parentesco.<br>Las personas pueden o no pertenecer a un
partido político determinado y, a veces, desempeñan un puesto en él. De cada
partido se conoce su nombre, dirección de la sede central y
teléfonos.<br>Cada caso de corrupción es descubierto por un periódico
en una fecha determinada. Del periódico sabemos el nombre, la dirección, si es
en papel o digital, página web si la tiene y ámbito (local, comarcal, nacional
o internacional). Cada periódico puede tener o no afinidad con un partido
político. Un partido político puede tener afinidad con varios periódicos o
con ninguno.<br>Nos interesará saber en qué ciudad hay el máximo
número de corruptos, total del dinero defraudado por partido político(se
contará si y sólo si la persona está afiliada al partido), periódico que
más casos ha descubierto, ... </em>
</p>
<p>

</p>
<h2>Entidades</h2>
<h3><strong>Juez</strong></h3>
<p>
    Mantiene una relación clara y directa con caso a al ser quien lo investiga.
Tiene como primary key el Id_juez. El resto de atributos engloban la información
principal. Cada caso es investigado por un juez del que se conoce su nombre,
dirección, fecha de nacimiento y fecha en que comenzó a ejercer como juez
</p>
<p>

</p>
<ul>
<li><strong>Juez </strong>(id_juez, nombre, direccion ,fecha_nac, fecha_prof)
</li>
</ul>
<h3><strong>Caso</strong></h3>
<p>
    Se trata de la entidad más importante del modelo y por ello se ha pretendido
preservar el hecho de que pueda tener definiciones asociadas pero distribuidas,
es por ello que derivan de caso dos entidades que ayudan a desconcentrar la
información en una única tabla (estado caso y dictamen), a la vez que permiten
cumplir con la segunda forma normal y al mismo tiempo quedan justificadas por la
necesidad de flexibilidad en el procedimiento administrativo judicial, de forma
que el modelo debe poder adaptar y recoger diferentes nomenclaturas en la
dinámica de evolución de un caso real.
</p>
<p>
    Cada caso de corrupción tiene un nombre que lo diferencia de los demás, una
breve descripción, una estimación de los millones que se han desviado y el
ámbito (Banco, Ayuntamiento, Caja, Comunidad, Estado,...), un caso puede tener
varios ámbitos.
</p>
<p>
    El atributo ámbitos caso se ha considerado como multivaluado, La primary key
es el Id_caso, el cual se prefiere para facilitar la creación de tablas y las
consultas. El resto son atributos simples con sus respectivos dominios.
</p>
<p>

</p>
<ul>
<li><strong>Caso</strong> (<span
style="text-decoration:underline;">id_caso</span>, nombre, descripcion,
est_desvio, fecha_estado_caso,Id_estado_caso, Id_dictamen)
</li>
</ul>
<h3><strong>Periódico</strong></h3>
<p>
    Cada caso de corrupción es descubierto por un periódico en una fecha
determinada. Del periódico sabemos el nombre, la dirección, si es en papel o
digital, página web si la tiene y ámbito (local, comarcal, nacional o
internacional).
</p>
<p>
    La primary key es Id_periodico. Se han contemplado los atributos
correspondientes a la descripción, destacando el atributo ámbito periodico que
se trata de un atributo multivaluado.
</p>
<p>

</p>
<ul>
<li><strong>periodico</strong> (<span
style="text-decoration:underline;">Id_periodico</span>, nombre, web, dir_sede,
ed_impreso, ed_digital)
</li>
</ul>
<h3><strong>Partido político</strong></h3>
<p>
    De cada partido se conoce su nombre, dirección de la sede central y
teléfonos.
</p>
<p>
    La primary Key es id_partido_pol, y tiene los atributos descritos,
destacando el teléfono que se considera multivaluado, dado que puede tener el
mismo partido diferentes números de teléfono al mismo tiempo.
</p>
<p>

</p>
<ul>
<li><strong>partido_político </strong>(<span
style="text-decoration:underline;">Id_partidopol</span>, nombre, dir_sede)
</li>
</ul>
<h3><strong>Implicado</strong></h3>
<p>
De cada uno de los implicados  se conoce su DNI, nombre, dirección y
patrimonio.
</p>
<p>
La primary key del implicado es Id_implicado y no DNI pues he interpretado que
los DNI serían de los implicados en España, mientras que nada nos hace pensar
que no puedan estar implicados individuos residentes en otros países. Aún así no
he querido complicar el modelo generalizando el documento de identificación y he
mantenido el DNI, pero podría generalizarse perfectamente con un atributo del
tipo Doc_id o similar, que junto con el de pais de residencia , daría la primary
key a la entidad. Lo que sí he incluido es el país de residencia.
</p>
<p>
Otro aspecto interesante de implicado es sus eventuales relaciones de
parentesco, las cuales he querido reflejar con la relación reflexiva
es_familiar.
</p>
<p>

</p>
<ul>
<li><strong>Implicado</strong> (<span style="text-decoration:underline;">Id
implicado</span>, DNI, nombre, direccion, pais_residencia, ciudad, patrimonio )
</li>
</ul>
<h3><strong>Estado caso</strong></h3>
<p>
Se ha desarrollado en tabla y conformado la entidad con la intención ya apuntada
de flexibilizar el modelo al procedimiento administrativo judicial, el cual
puede ser cambiante y ciertamente complejo, de ahí que se ha preferido disgregar
esa información del caso en una tabla diferente. La primary key es Id_estado
caso y el atributo descripción_estado define diferentes tipos de estados que
puede tener el procedimiento administrativo judicial.
</p>
<p>

</p>
<ul>
<li><strong>estado_caso </strong>(<span
style="text-decoration:underline;">Id_estado_caso</span>, descripcion_estado)
</li>
</ul>
<h3><strong>Dictamen</strong></h3>
<p>
De forma análoga al caso anterior, se pretende no cargar con listas muy largas
de datos y de valores NULL en todos aquellos casos que todavía no tengan
dictamen y al mismo tiempo se ha entendido que puede tener un recorrido y
definición el dictamen de un caso que debiera estar soportado por una entidad.
Una vez concluida la investigación del caso se emite un dictamen del caso que
se registra.La primary key es Id_dictamen y el atributo registrado puede tomar
dos valores prefijados.
</p>
<p>

</p>
<ul>
<li><strong>dictamen </strong>(<span
style="text-decoration:underline;">Id_dictamen</span>, registrado)
</li>
</ul>
<h2>Atributos multivaluados</h2>
<h3><strong>Ámbito</strong> <strong>caso</strong></h3>
<p>
Tendrá primary key Id_ambito y su relación con caso incorporando la primary key
de caso, Id_caso.
</p>
<ul>
<li><strong>ambito_caso </strong>(<span
style="text-decoration:underline;">Id_ambito</span>, descripcion_ambito,Id_caso)
</li>
</ul>
<h3><strong>Ámbito periódico</strong></h3>
<p>
Tendrá primary key Id_ambito_periodico y su relación con caso incorporando la
primary key de periodico, Id_periodico.
</p>
<ul>
<li><strong>ambito_periodico </strong>(<span
style="text-decoration:underline;">Id_ambito_periódico</span>,
descripcion_ambito_per, Id_periodico)
</li>
</ul>
<h3><strong>Teléfono</strong></h3>
<p>
Tendrá primary key telefono_num y su relación con caso incorporando la primary
key de partido político, Id_partidopol.
</p>
<ul>
<li><strong>telefono </strong>(<span
style="text-decoration:underline;">telefono_num</span>, tipo_num, Id_partidopol)
</li>
</ul>
<h2>Relaciones</h2>
<h3><strong>Investiga</strong>	Juez investiga caso => 1:N</h3>
<p>

</p>
<p>
<strong>Juez </strong>(id_juez, nombre, direccion ,fecha_nac, fecha_prof)
</p>
<p>
<strong>investiga</strong> (Id_caso, Id_juez)
</p>
<p>
<strong>Caso</strong> (<span style="text-decoration:underline;">id_caso</span>,
nombre, descripcion, est_desvio, fecha_estado_caso,Id_estado_caso, Id_dictamen)
</p>
<h3><strong>Descubre	</strong>El periódico descubre el caso=> 1:N</h3>
<p>

</p>
<p>
<strong>periodico</strong> (<span
style="text-decoration:underline;">Id_periodico</span>, nombre, web, dir_sede,
ed_impreso, ed_digital)
</p>
<p>
<strong>descubre</strong>(<span
style="text-decoration:underline;">Id_caso</span>, Id_periodico, Fecha_descubre)
</p>
<p>
<strong>Caso</strong> (<span style="text-decoration:underline;">id_caso</span>,
nombre, descripcion, est_desvio, fecha_estado_caso,Id_estado_caso, Id_dictamen)
</p>
<h3><strong>Tiene estado	 </strong>El caso tiene estado => N:1. No genera
tabla</h3>
<p>

</p>
<p>
    <strong>Caso</strong> (<span
style="text-decoration:underline;">id_caso</span>, nombre, descripcion,
est_desvio, fecha_estado_caso,<strong>Id_estado_caso</strong>, Id_dictamen)
</p>
<p>
    <strong>estado_caso </strong>(<span
style="text-decoration:underline;">Id_estado_caso</span>, descripcion_estado)
</p>
<h3><strong>Tiene dictamen	 </strong>El caso tiene dictamen => N:1  No genera
tabla</h3>
<p>

</p>
<p>
    <strong>Caso</strong> (<span
style="text-decoration:underline;">id_caso</span>, nombre, descripcion,
est_desvio, fecha_estado_caso,Id_estado_caso, <strong>Id_dictamen</strong>)
</p>
<p>
    <strong>dictamen </strong>(<span
style="text-decoration:underline;">Id_dictamen</span>, registrado)<strong>
</strong>
</p>
<h3><strong>Es_afin</strong>	El periódico es afín al partido político =>
N:M</h3>
<p>

</p>
<p>
    <strong>periodico</strong> (<span
style="text-decoration:underline;">Id_periodico</span>, nombre, web, dir_sede,
ed_impreso, ed_digital)
</p>
<p>
    <strong>es</strong>_afin (<span
style="text-decoration:underline;">Id_periodico<code>, </code>
Id_partidopol</span>)

<p>
    <strong>partido_político </strong>(<span
style="text-decoration:underline;">Id_partidopol</span>, nombre, dir_sede)
</p>
<ul>
<li>
<li>
</li>
</ul>
<h3><strong>Envuelve	</strong>El caso envuelve implicados => N:M</h3>
<p>

</p>
<p>
    <strong>Caso</strong> (<span
style="text-decoration:underline;">id_caso</span>, nombre, descripcion,
est_desvio, fecha_estado_caso,Id_estado_caso, Id_dictamen)
</p>
<p>
    <strong>envuelve</strong>(<span
style="text-decoration:underline;">Id_caso</span>, <span
style="text-decoration:underline;">Id_implicado</span>, Fecha_inicio, Puesto)
</p>
<p>
    <strong>Implicado</strong> (<span style="text-decoration:underline;">Id
implicado</span>, DNI, nombre, direccion, pais_residencia, ciudad, patrimonio )
</p>
<h3><strong>Es familiar	</strong>El implicado es familiar => N:N</h3>
<p>

</p>
<p>
    <strong>Implicado</strong> (<span style="text-decoration:underline;">Id
implicado</span>, DNI, nombre, direccion, pais_residencia, ciudad, patrimonio )
</p>
<p>
    <strong>esFamiliar</strong> (<span
style="text-decoration:underline;">Id_implicado_1,</span> <span
style="text-decoration:underline;">Id_implicado_2, </span>parentesco)
</p>
<h3><strong>Es afiliado	</strong>El implicado es afiliado al partido político =>
N:1</h3>
<p>

</p>
<p>
    <strong>Implicado</strong> (<span style="text-decoration:underline;">Id
implicado</span>, DNI, nombre, direccion, pais_residencia, ciudad, patrimonio )
</p>
<p>
    <strong>es_afiliado (<span style="text-decoration:underline;">Id
implicado</span></strong>, <span
style="text-decoration:underline;">Id_partidopol</span>, cargo_partido)
</p>
<p>
    <strong>partido_político </strong>(<span
style="text-decoration:underline;">Id_partidopol</span>, nombre, dir_sede)
</p>
<ul>
<li><span style="text-decoration:underline;">_</span>
</li>
</ul>
<p>
</p>
<h2>Modelo relacional </h2>
<p>
    <strong>		dictamen </strong>(<span
style="text-decoration:underline;">Id_dictamen</span>, registrado)<strong>
</strong>
</p>
<p>
    <strong>		estado_caso </strong>(<span
style="text-decoration:underline;">Id_estado_caso</span>, descripcion_estado)
</p>
<p>
<strong>Caso</strong> (<span style="text-decoration:underline;">id_caso</span>,
nombre, descripcion, est_desvio, fecha_estado_caso,Id_estado_caso, Id_dictamen)
</p>
<p>
<strong>		ambito_caso </strong>(<span
style="text-decoration:underline;">Id_ambito</span>, descripcion_ambito,Id_caso)
</p>
<p>
<strong>investiga</strong> (<span
style="text-decoration:underline;">Id_caso</span>, Id_juez)
</p>
<p>
<strong>Juez </strong>(<span style="text-decoration:underline;">id_juez</span>,
nombre, direccion ,fecha_nac, fecha_prof)
</p>
<p>
<strong>		 </strong>
</p>
<p>
<strong>		descubre</strong>(<span
style="text-decoration:underline;">Id_caso</span>, Id_periodico, Fecha_descubre)
</p>
<p>
<strong>		periodico</strong> (<span
style="text-decoration:underline;">Id_periodico</span>, nombre, web, dir_sede,
ed_impreso, ed_digital)
</p>
<p>
<strong>		ambito_periodico </strong>(<span
style="text-decoration:underline;">Id_ambito_periódico</span>,
descripcion_ambito_per, Id_periodico)
</p>
<p>
    <strong>		es</strong>_afin (<span
style="text-decoration:underline;">Id_periodico<code>, </code>
Id_partidopol</span>)

<p>
    <strong>		partido_político </strong>(<span
style="text-decoration:underline;">Id_partidopol</span>, nombre,
dir_sede)<strong>	</strong>
</p>
<p>
<strong>			telefono </strong>(<span
style="text-decoration:underline;">telefono_num</span>, tipo_num, Id_partidopol)
</p>
<p>
    <strong>			es_afiliado (<span style="text-decoration:underline;">Id
implicado</span></strong>, <span
style="text-decoration:underline;">Id_partidopol</span>, cargo_partido)
</p>
<p>
    <strong>	</strong>		<strong>Implicado</strong> (<span
style="text-decoration:underline;">Id implicado</span>, DNI, nombre, direccion,
pais_residencia, ciudad, patrimonio )
</p>
<p>
    <strong>			esFamiliar</strong> (<span
style="text-decoration:underline;">Id_implicado_1,</span> <span
style="text-decoration:underline;">Id_implicado_2, </span>parentesco)
</p>
<p>
    	    		<strong>envuelve</strong>(<span
style="text-decoration:underline;">Id_caso</span>, <span
style="text-decoration:underline;">Id_implicado</span>, Fecha_inicio, Puesto)
</p>
<p>
</p>
<h2>Código SQL</h2>
<h2>Entidades</h2>
<h3><strong>Juez</strong></h3>
<ul>
<li><strong>Juez </strong>(id_juez, nombre, direccion ,fecha_nac, fecha_prof)
</li>
</ul>


<pre class="prettyprint">CREATE TABLE Juez(

Id_juez int NOT NULL,

nombre varchar (30) NOT NULL,

direccion varchar (100),
	fecha_nac date,

fecha_pro date,

PRIMARY KEY (Id_juez)
);
</pre>
<h3><strong>Caso</strong></h3>
<ul>
<li><strong>Caso</strong> (<span
style="text-decoration:underline;">id_caso</span>, nombre, descripcion,
est_desvio, fecha_estado_caso,Id_estado_caso, Id_dictamen)


<pre class="prettyprint">CREATE TABLE caso(

Id_caso int NOT NULL , 

nombre varchar(30) NOT NULL, 

descripcion varchar(150),

est_desvio int unsigned,

fecha_estado_caso Date,
	Id_estado_caso int,

Id_dictamen int,
PRIMARY KEY (Id_caso),
FOREIGN KEY (Id_estado_caso) REFERENCES estado_caso(Id_estado_caso) 
ON DELETE CASCADE ON UPDATE CASCADE
FOREIGN KEY (Id_dictamen) REFERENCES dictamen(Id_dictamen) 
ON DELETE CASCADE ON UPDATE CASCADE
);

</li>
</ul></pre>
<h3><strong>Periódico</strong></h3>
<ul>
<li><strong>periodico</strong> (<span
style="text-decoration:underline;">Id_periodico</span>, nombre, web, dir_sede,
ed_impreso, ed_digital)


<pre class="prettyprint">CREATE TABLE periodico(
 
Id_periodico int NOT NULL ,
 
nombre varchar (30) NOT NULL, 
 
web varchar (50), 
 
dir_sede varchar (100), 
 
ed_impreso tinyint NOT NULL, 
 
ed_digital tinyint NOT NULL,
 PRIMARY KEY (Id_periodico)
 );

</li>
</ul></pre>
<h3><strong>Partido político</strong></h3>
<ul>
<li><strong>partido_político </strong>(<span
style="text-decoration:underline;">Id_partidopol</span>, nombre,
dir_sede)


<pre
class="prettyprint">CREATE TABLE partido_politico (
 
Id_partidopol int NOT NULL,
 
nombre varchar (30),
 
dir_sede varchar (100),
 PRIMARY KEY (Id_partidopol)
 );

</li>
</ul></pre>
<h3><strong>Implicado</strong></h3>
<ul>
<li><strong>Implicado</strong> (<span style="text-decoration:underline;">Id
implicado</span>, DNI, nombre, direccion, pais_residencia, ciudad, patrimonio
)


<pre class="prettyprint">CREATE TABLE implicado(
 
Id_implicado int NOT NULL ,
 
DNI varchar (9) NOT NULL ,
 
nombre varchar(30) NOT NULL,
 
direccion varchar (100),
 
pais_residencia varchar (50) NOT NULL,
 
ciudad varchar (50) NOT NULL,
 
patrimonio int,
 PRIMARY KEY (Id_implicado)
 );

</li>
</ul></pre>
<h3><strong>Estado caso</strong></h3>
<ul>
<li><strong>estado_caso </strong>(<span
style="text-decoration:underline;">Id_estado_caso</span>,
descripcion_estado)


<pre class="prettyprint">CREATE TABLE estado_caso(

Id_estado_caso int NOT NULL,

descripcion_estado varchar (100),
PRIMARY KEY (Id_estado_caso)
);

</li>
</ul></pre>
<h3><strong>Dictamen</strong></h3>
<ul>
<li><strong>dictamen </strong>(<span
style="text-decoration:underline;">Id_dictamen</span>,
registrado)


<pre class="prettyprint">CREATE TABLE dictamen(

Id_dictamen int NOT NULL,

registrado ENUM ('Sí registrado','No registrado'),
PRIMARY KEY (Id_dictamen)
);

</li>
</ul></pre>
<h2>Atributos</h2>
<h3><strong>Ámbito</strong> <strong>caso</strong></h3>
<ul>
<li><strong>ambito_caso </strong>(<span
style="text-decoration:underline;">Id_ambito</span>, descripcion_ambito,Id_caso)
</li>
</ul>


<pre class="prettyprint">CREATE TABLE ambito_caso(

Id_ambito int NOT NULL AUTO_INCREMENT,

descripcion_ambito varchar (100),
	Id_caso int,

PRIMARY KEY (Id_ambito),

FOREIGN KEY (Id_caso) REFERENCES caso(Id_caso) ON DELETE CASCADE ON UPDATE CASCADE 
);
</pre>
<h3><strong>Ámbito periódico</strong></h3>
<ul>
<li><strong>ambito_periodico </strong>(<span
style="text-decoration:underline;">Id_ambito_periódico</span>,
descripcion_ambito_per, Id_periodico)
</li>
</ul>


<pre class="prettyprint">CREATE TABLE ambito_periodico(

Id_ambito_periodico int NOT NULL ,

descripcion_ambito_per varchar (50),

Id_periodico int,

PRIMARY KEY (Id_ambito_periodico),

FOREIGN KEY (Id_periodico) REFERENCES periodico(Id_periodico) ON DELETE CASCADE ON 
UPDATE CASCADE
);
</pre>
<h3><strong>Teléfono</strong></h3>
<ul>
<li><strong>telefono </strong>(<span
style="text-decoration:underline;">telefono_num</span>, tipo_num,
Id_partidopol)


<pre class="prettyprint">CREATE TABLE telefono(

telefono_num int NOT NULL,

tipo_num varchar (50),

Id_partidopol int,
PRIMARY KEY (telefono_num),
FOREIGN KEY (Id_partidopol) REFERENCES partido_politico(Id_partidopol) 
ON DELETE CASCADE ON UPDATE CASCADE
);

</li>
</ul></pre>
<h2>Relaciones</h2>
<h3><strong>Investiga</strong>	Juez investiga caso => 1:N</h3>
<p>
<strong>Juez </strong>(id_juez, nombre, direccion ,fecha_nac, fecha_prof)
</p>
<p>
<strong>investiga</strong> (Id_caso, Id_juez)
</p>
<p>
<strong>Caso</strong> (<span style="text-decoration:underline;">id_caso</span>,
nombre, descripcion, est_desvio, fecha_estado_caso,Id_estado_caso, Id_dictamen)
</p>


<pre class="prettyprint">CREATE TABLE investiga (

Id_caso int ,

Id_juez int ,
PRIMARY KEY (Id_caso),
FOREIGN KEY (Id_caso) REFERENCES caso(Id_caso) 
ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (Id_juez) REFERENCES juez(Id_juez) 
ON DELETE CASCADE ON UPDATE CASCADE
);
</pre>
<h3><strong>Descubre	</strong>El periódico descubre el caso=> 1:N</h3>
<p>
<strong>periodico</strong> (<span
style="text-decoration:underline;">Id_periodico</span>, nombre, web, dir_sede,
ed_impreso, ed_digital)
</p>
<p>
<strong>descubre</strong>(<span
style="text-decoration:underline;">Id_caso</span>, Id_periodico, Fecha_descubre)
</p>
<p>
<strong>Caso</strong> (<span style="text-decoration:underline;">id_caso</span>,
nombre, descripcion, est_desvio, fecha_estado_caso,Id_estado_caso, Id_dictamen)
</p>


<pre class="prettyprint">CREATE TABLE descubre (

Id_caso int,
	Id_periodico int,

Fecha_descubre date, 
PRIMARY KEY (Id_caso),
FOREIGN KEY (Id_caso) REFERENCES caso(Id_caso) 
ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (Id_periodico) REFERENCES periodico(Id_periodico) 
ON DELETE CASCADE ON UPDATE CASCADE
);
</pre>
<h3><strong>Tiene estado	 </strong>El caso tiene estado => N:1</h3>
<p>
    <strong>Caso</strong> (<span
style="text-decoration:underline;">id_caso</span>, nombre, descripcion,
est_desvio, fecha_estado_caso,<strong>Id_estado_caso</strong>, Id_dictamen)
</p>
<p>
    <strong>estado_caso </strong>(<span
style="text-decoration:underline;">Id_estado_caso</span>, descripcion_estado)
</p>
<h3><strong>Tiene dictamen	 </strong>El caso tiene dictamen => N:1</h3>
<p>
    <strong>Caso</strong> (<span
style="text-decoration:underline;">id_caso</span>, nombre, descripcion,
est_desvio, fecha_estado_caso,Id_estado_caso, <strong>Id_dictamen</strong>)
</p>
<p>
    <strong>dictamen </strong>(<span
style="text-decoration:underline;">Id_dictamen</span>, registrado)<strong>
</strong>
</p>
<h3><strong>Es_afin</strong>	El periódico es afín al partido político =>
N:M</h3>
<p>
    <strong>periodico</strong> (<span
style="text-decoration:underline;">Id_periodico</span>, nombre, web, dir_sede,
ed_impreso, ed_digital)
</p>
<p>
    <strong>es</strong>_afin (<span
style="text-decoration:underline;">Id_periodico<code>, </code>
Id_partidopol</span>)

<p>
    <strong>partido_político </strong>(<span
style="text-decoration:underline;">Id_partidopol</span>, nombre, dir_sede)
</p>


<pre class="prettyprint">CREATE TABLE es_afin (

Id_periodico int,

Id_partidopol int,
PRIMARY KEY (Id_periodico,Id_partidopol),
FOREIGN KEY (Id_periodico) REFERENCES periodico(Id_periodico) 
ON DELETE CASCADE ON 
UPDATE CASCADE,
FOREIGN KEY (Id_partidopol) REFERENCES partido_politico(Id_partidopol) 
ON DELETE CASCADE ON UPDATE CASCADE
 );
</pre>
<ul>
<li>
</li>
</ul>
<h3><strong>Envuelve	</strong>El caso envuelve implicados => N:M</h3>
<p>
    <strong>Caso</strong> (<span
style="text-decoration:underline;">id_caso</span>, nombre, descripcion,
est_desvio, fecha_estado_caso,Id_estado_caso, Id_dictamen)
</p>
<p>
    <strong>envuelve</strong>(<span
style="text-decoration:underline;">Id_caso</span>, <span
style="text-decoration:underline;">Id_implicado</span>, Fecha_inicio, Puesto)
</p>
<p>
    <strong>Implicado</strong> (<span style="text-decoration:underline;">Id
implicado</span>, DNI, nombre, direccion, pais_residencia, ciudad, patrimonio )
</p>


<pre class="prettyprint">CREATE TABLE envuelve (

Id_caso int,
	Id_implicado int,

Fecha_inicio date,

Puesto varchar (30),
PRIMARY KEY (Id_caso, Id_implicado),
FOREIGN KEY (Id_caso) REFERENCES caso(Id_caso) 
ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (Id_implicado) REFERENCES implicado(Id_implicado) 
ON DELETE CASCADE ON UPDATE CASCADE
 );
</pre>
<h3><strong>Es familiar	</strong>El implicado es familiar => N:N</h3>
<p>
    <strong>Implicado</strong> (<span style="text-decoration:underline;">Id
implicado</span>, DNI, nombre, direccion, pais_residencia, ciudad, patrimonio )
</p>
<p>
    <strong>esFamiliar</strong> (<span
style="text-decoration:underline;">Id_implicado_1,</span> <span
style="text-decoration:underline;">Id_implicado_2, </span>parentesco)
</p>


<pre class="prettyprint">CREATE TABLE esFamiliar(

Id_implicado_1 int,
	Id_implicado_2 int,

parentesco varchar(30) ,
PRIMARY KEY (Id_implicado_1,Id_implicado_2),
FOREIGN KEY (Id_implicado_1) REFERENCES implicado(Id_implicado)
ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (Id_implicado_2) REFERENCES implicado(Id_implicado)
ON DELETE CASCADE ON UPDATE CASCADE
);
</pre>
<h3><strong>Es afiliado	</strong>El implicado es afiliado al partido político =>
N:1</h3>
<p>
    <strong>Implicado</strong> (<span style="text-decoration:underline;">Id
implicado</span>, DNI, nombre, direccion, pais_residencia, ciudad, patrimonio )
</p>
<p>
    <strong>es_afiliado (<span style="text-decoration:underline;">Id
implicado</span></strong>, <span
style="text-decoration:underline;">Id_partidopol</span>, cargo_partido)
</p>
<p>
    <strong>partido_político </strong>(<span
style="text-decoration:underline;">Id_partidopol</span>, nombre, dir_sede)
</p>


<pre class="prettyprint">CREATE TABLE es_afiliado (

Id_implicado int,
	Id_partidopol int,

Cargo_partido varchar  (30),
PRIMARY KEY (Id_implicado,Id_partidopol),
FOREIGN KEY (Id_implicado) REFERENCES implicado(Id_implicado) 
ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (Id_partidopol) REFERENCES partido_politico(Id_partidopol) 
ON DELETE CASCADE ON UPDATE CASCADE

