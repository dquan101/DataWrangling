---
output:
  pdf_document: default
  html_document: default
---
Reporte Lab07
================
Diego Quan
9/22/2019

## Estado 2017

Las gananacias en el año 2017 fueron de:

``` r
ingresos <- sum(molten_real$factura)
costos <- sum(molten_real$costo_total)
ganancias <- ingresos - costos
ganancias
```

    ## [1] 8514077

mientras que los ingresos y costos fueron de:

``` r
ingresos
```

    ## [1] 36688096

``` r
costos
```

    ## [1] 28174019

El estado de ingresos y costos por tipo de transporte en el 2017 fueron
de:

``` r
total_unidad <- aggregate(x = molten_real$factura, by=list(molten_real$tipo_transporte), sum)
colnames(total_unidad)<-c('Unidad', 'Ingresos')
formattable(total_unidad)
```

<table class="table table-condensed">

<thead>

<tr>

<th style="text-align:right;">

Unidad

</th>

<th style="text-align:right;">

Ingresos

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:right;">

Camion\_5

</td>

<td style="text-align:right;">

11461980.2

</td>

</tr>

<tr>

<td style="text-align:right;">

Pickup

</td>

<td style="text-align:right;">

24502084.2

</td>

</tr>

<tr>

<td style="text-align:right;">

Moto

</td>

<td style="text-align:right;">

724031.9

</td>

</tr>

</tbody>

</table>

``` r
costo_unidad <- aggregate(x = molten_real$costo_total, by=list(molten_real$tipo_transporte), sum)
colnames(costo_unidad)<-c('Unidad', 'Ingresos')
formattable(costo_unidad)
```

<table class="table table-condensed">

<thead>

<tr>

<th style="text-align:right;">

Unidad

</th>

<th style="text-align:right;">

Ingresos

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:right;">

Camion\_5

</td>

<td style="text-align:right;">

8658363.2

</td>

</tr>

<tr>

<td style="text-align:right;">

Pickup

</td>

<td style="text-align:right;">

19121908.2

</td>

</tr>

<tr>

<td style="text-align:right;">

Moto

</td>

<td style="text-align:right;">

393747.9

</td>

</tr>

</tbody>

</table>

## Tarifario por unidad

El tarifario estimado por unidad fue de una media
de:

``` r
tarifa_unidad <- aggregate(x = molten_real$costo_total, by=list(molten_real$tipo_transporte), mean) #tarifa por unidad
colnames(tarifa_unidad)<-c('Unidad', 'Tarifa')
formattable(tarifa_unidad)
```

<table class="table table-condensed">

<thead>

<tr>

<th style="text-align:right;">

Unidad

</th>

<th style="text-align:right;">

Tarifa

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:right;">

Camion\_5

</td>

<td style="text-align:right;">

139.05220

</td>

</tr>

<tr>

<td style="text-align:right;">

Pickup

</td>

<td style="text-align:right;">

97.69384

</td>

</tr>

<tr>

<td style="text-align:right;">

Moto

</td>

<td style="text-align:right;">

68.77693

</td>

</tr>

</tbody>

</table>

## Tarifas aceptables por los clientes:

A raíz de los motivos por los cuales eran solicitados nuestros servicios
podemos precisar que los clientes no estan disatisfechos con nuestras
tarifas, ninguno muestra algun indicio de lo contrario, y a razón de las
ganancias podemos declarar que no estamos en números rojos, ya que estas
son positivas. Q.8.51407710^{6}.

``` r
unique <- distinct(molten_real, Cod)
colnames(unique) <- c('Motivos')
formattable(unique)
```

<table class="table table-condensed">

<thead>

<tr>

<th style="text-align:right;">

Motivos

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:right;">

REVISION\_TRANSFORMADOR

</td>

</tr>

<tr>

<td style="text-align:right;">

REVISION

</td>

</tr>

<tr>

<td style="text-align:right;">

VERIFICACION\_INDICADORES

</td>

</tr>

<tr>

<td style="text-align:right;">

VISITA\_POR\_CORRECCION

</td>

</tr>

<tr>

<td style="text-align:right;">

CAMBIO\_CORRECTIVO

</td>

</tr>

<tr>

<td style="text-align:right;">

OTRO

</td>

</tr>

<tr>

<td style="text-align:right;">

VERIFICACION\_MEDIDORES

</td>

</tr>

<tr>

<td style="text-align:right;">

CAMBIO\_FUSIBLE

</td>

</tr>

<tr>

<td style="text-align:right;">

CAMBIO\_PUENTES

</td>

</tr>

<tr>

<td style="text-align:right;">

VISITA

</td>

</tr>

</tbody>

</table>
