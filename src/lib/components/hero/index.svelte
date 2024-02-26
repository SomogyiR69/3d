<script lang="ts">
	import { onMount } from 'svelte';

	import Renderer from './renderer';

	import Particles from './Particles.svelte';

	let renderer: Renderer;
	let canvasRef: HTMLCanvasElement;
	let height: number, width: number;

	onMount(() => {
		height = window.innerHeight;
		width = window.innerWidth;

		renderer = new Renderer();
		renderer.initialize(canvasRef);
		renderer.animate();
	});
</script>

<div class="fixed h-full w-full overflow-hidden">
	<div>
		<canvas class=" scale-150" bind:this={canvasRef}>
			{#if renderer != undefined}
				<Particles {renderer} {width} {height} depth={500} count={300} size={150} />
			{/if}
		</canvas>
	</div>
</div>
