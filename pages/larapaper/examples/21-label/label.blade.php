<x-trmnl::view>

    <x-trmnl::layout direction="col">

        <x-trmnl::item>

            <x-trmnl::label>
                Default
            </x-trmnl::label>

        </x-trmnl::item>

        <x-trmnl::item>

            <x-trmnl::label variant="primary">
                Primary
            </x-trmnl::label>

        </x-trmnl::item>

        <x-trmnl::item>

            <x-trmnl::label variant="secondary">
                Secondary
            </x-trmnl::label>

        </x-trmnl::item>

        <x-trmnl::item>

            <x-trmnl::label variant="underline">
                Underline
            </x-trmnl::label>

        </x-trmnl::item>

        <x-trmnl::item>

            <x-trmnl::label variant="inverted">
                Inverted
            </x-trmnl::label>

        </x-trmnl::item>

    </x-trmnl::layout>

    <x-trmnl::title-bar
        title="Label Test"
        :instance="now()->format('H:i')" />

</x-trmnl::view>
