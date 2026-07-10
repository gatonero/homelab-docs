@php
$online = true;
@endphp

<div style="padding:20px;font-family:sans-serif">

<h1>IF-Test</h1>

@if($online)

<p>Status: ONLINE</p>

@else

<p>Status: OFFLINE</p>

@endif

</div>
