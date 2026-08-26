<x-trmnl::view>

    <x-trmnl::layout direction="col">

        <x-trmnl::item>

            <x-trmnl::label>
                Default
            </x-trmnl::label>

            <x-trmnl::value>
                123
            </x-trmnl::value>

        </x-trmnl::item>

        <x-trmnl::item>

            <x-trmnl::label>
                Small
            </x-trmnl::label>

            <x-trmnl::value size="small">
                123
            </x-trmnl::value>

        </x-trmnl::item>

        <x-trmnl::item>

            <x-trmnl::label>
                Large
            </x-trmnl::label>

            <x-trmnl::value size="large">
                123
            </x-trmnl::value>

        </x-trmnl::item>

        <x-trmnl::item>

            <x-trmnl::label>
                XLarge
            </x-trmnl::label>

            <x-trmnl::value size="xlarge">
                123
            </x-trmnl::value>

        </x-trmnl::item>

        <x-trmnl::item>

            <x-trmnl::label>
                XXLarge
            </x-trmnl::label>

            <x-trmnl::value size="xxlarge">
                123
            </x-trmnl::value>

        </x-trmnl::item>

        <x-trmnl::item>

            <x-trmnl::label>
                XXXLarge
            </x-trmnl::label>

            <x-trmnl::value
                size="xxxlarge"
                data-fit-value="true">
                123
            </x-trmnl::value>

        </x-trmnl::item>

    </x-trmnl::layout>

    <x-trmnl::title-bar
        title="Value Test"
        :instance="now()->format('H:i')" />

</x-trmnl::view>
