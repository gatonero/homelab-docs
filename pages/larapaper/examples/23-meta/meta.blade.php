<x-trmnl::view>

    <x-trmnl::layout direction="col">

        <x-trmnl::item>

            <x-trmnl::meta />

            <x-trmnl::label>
                Leeres Meta
            </x-trmnl::label>

        </x-trmnl::item>

        <x-trmnl::item>

            <x-trmnl::meta>
                M
            </x-trmnl::meta>

            <x-trmnl::label>
                Meta mit Text
            </x-trmnl::label>

        </x-trmnl::item>

        <x-trmnl::item>

            <x-trmnl::meta>
                ✓
            </x-trmnl::meta>

            <x-trmnl::label>
                Meta mit Symbol
            </x-trmnl::label>

        </x-trmnl::item>

    </x-trmnl::layout>

    <x-trmnl::title-bar
        title="Meta Test"
        :instance="now()->format('H:i')" />

</x-trmnl::view>
