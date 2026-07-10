@php

$fahrzeuge = [
    [
        'name' => 'Megane',
        'akku' => 78,
        'reichweite' => 274,
    ],
    [
        'name' => 'Wohnmobil',
        'akku' => 100,
        'reichweite' => 820,
    ],
];

@endphp

<div style="padding:20px;font-family:sans-serif">

<h1>ARRAY-Test</h1>

<table style="width:100%;border-collapse:collapse">

<tr>
    <th align="left">Fahrzeug</th>
    <th align="left">Akku</th>
    <th align="left">Reichweite</th>
</tr>

@foreach($fahrzeuge as $fahrzeug)

<tr>
    <td>{{ $fahrzeug['name'] }}</td>
    <td>{{ $fahrzeug['akku'] }} %</td>
    <td>{{ $fahrzeug['reichweite'] }} km</td>
</tr>

@endforeach

</table>

</div>
