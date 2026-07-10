<x-trmnl::view>

    <x-trmnl::layout direction="col">

        <x-trmnl::item>

            <x-trmnl::label>
                Label
            </x-trmnl::label>

            <x-trmnl::value size="large">
                42
            </x-trmnl::value>

        </x-trmnl::item>

        <x-trmnl::item>

            <x-trmnl::label>
                Zweites Item
            </x-trmnl::label>

            <x-trmnl::value>
                ABC
            </x-trmnl::value>

        </x-trmnl::item>

    </x-trmnl::layout>

    <x-trmnl::title-bar
        title="Component Test"
        :instance="now()->format('H:i')" />

</x-trmnl::view>
