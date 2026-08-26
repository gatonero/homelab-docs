<x-trmnl::view>

    <x-trmnl::layout
        direction="col"
        stretch="default">

        <x-trmnl::item>

            <x-trmnl::label>

                Dashboard Test

            </x-trmnl::label>

            <x-trmnl::value>

                91 %

            </x-trmnl::value>

        </x-trmnl::item>

    </x-trmnl::layout>

    <x-trmnl::title-bar
        title="Dashboard"
        :instance="now()->format('H:i')" />

</x-trmnl::view>
