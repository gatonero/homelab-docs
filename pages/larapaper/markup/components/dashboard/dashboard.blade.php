<x-trmnl::view>

    <x-trmnl::layout
        direction="col"
        stretch="default">

        {{ $slot }}

    </x-trmnl::layout>

    <x-trmnl::title-bar
        :title="$title"
        :instance="$instance" />

</x-trmnl::view>
