<x-trmnl::view>

    <x-trmnl::layout direction="col">

        <x-trmnl::item>

            <x-trmnl::meta />

            <x-trmnl::content>

                <x-trmnl::label>
                    Default
                </x-trmnl::label>

                <x-trmnl::value>
                    123
                </x-trmnl::value>

            </x-trmnl::content>

        </x-trmnl::item>

        <x-trmnl::item>

            <x-trmnl::meta />

            <x-trmnl::content
                contentAlignment="center"
                textAlignment="center">

                <x-trmnl::label>
                    Center
                </x-trmnl::label>

                <x-trmnl::value>
                    456
                </x-trmnl::value>

            </x-trmnl::content>

        </x-trmnl::item>

        <x-trmnl::item>

            <x-trmnl::meta />

            <x-trmnl::content
                contentAlignment="center"
                textAlignment="center"
                gapSize="large">

                <x-trmnl::label>
                    Large Gap
                </x-trmnl::label>

                <x-trmnl::value size="large">
                    789
                </x-trmnl::value>

            </x-trmnl::content>

        </x-trmnl::item>

    </x-trmnl::layout>

    <x-trmnl::title-bar
        title="Content Test"
        :instance="now()->format('H:i')" />

</x-trmnl::view>
