<script lang="ts">
	import { onMount } from 'svelte';
	import { tweened } from 'svelte/motion';
	import { animate, inView, scroll, timeline, stagger } from 'motion';
	import SplitType from 'split-type';
	import HorizontalSlides from '$lib/components/HorizontalSlides.svelte';

	let text: HTMLDivElement;

	onMount(() => {
		// Split the hero text and animate
		const splitText = new SplitType(text, { lineClass: 'overflow-hidden' });

		const rippleAnimation = [
			splitText.chars,
			{ y: ['0%', '-20%', '0%'] },
			{
				delay: stagger(0.05),
				duration: 0.5,
				at: '-0.5'
			}
		];
		timeline([rippleAnimation]);
		setInterval(() => {
			timeline([rippleAnimation]);
		}, 4400);
	});
</script>

<div class="mx-auto max-w-2xl pt-24">
	<div class="mx-auto max-w-2xl py-24">
		<div bind:this={text}>
			Duis in veniam aliqua irure cupidatat dolore do nulla nisi amet. Sint non dolor reprehenderit.
		</div>
	</div>
</div>

<HorizontalSlides />
