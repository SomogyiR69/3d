<script lang="ts">
	import { timeline, scroll, animate } from 'motion';
	import { onMount } from 'svelte';
	import { clamp, mapLinear } from 'three/src/math/MathUtils.js';
	import Lenis from '@studio-freight/lenis';
	import { cn } from '$lib/utils';

	onMount(() => {
		const lenis = new Lenis();

		lenis.on('scroll', (e: any) => {
			/* console.log(e); */
		});
		function raf(time: any) {
			lenis.raf(time);
			requestAnimationFrame(raf);
		}

		requestAnimationFrame(raf);
	});

	let items: HTMLLIElement[] = [];
	let headers: HTMLElement[] = [];
	let ul: HTMLUListElement;
	let section: HTMLElement;
	let li1: HTMLLIElement;
	let li2: HTMLLIElement;
	let li3: HTMLLIElement;
	let li4: HTMLLIElement;
	let li5: HTMLLIElement;
	let h1: HTMLElement;
	let h2: HTMLElement;
	let h3: HTMLElement;
	let h4: HTMLElement;
	let h5: HTMLElement;
	let progress: HTMLDivElement;

	onMount(() => {
		items = [li1, li2, li3, li4, li5];
		headers = [h1, h2, h3, h4, h5];
		// Image parallax

		scroll(
			animate(ul, {
				transform: ['none', `translateX(-${items.length - 1}00vw)`]
			}),
			{ target: section }
		);

		scroll(animate(progress, { scaleX: [0, 1] }), {
			target: section
		});

		// Image title parallax
		const segmentLength = 1 / items.length;

		items.forEach((item, i) => {
			const header = headers[i];
			scroll(animate(header, { x: [600, -600] }), {
				target: section,
				offset: [
					[i * segmentLength, 1],
					[(i + 1) * segmentLength, 0]
				]
			});
		});
	});
</script>

<article>
	<header class="flex h-[80vh] items-center justify-center bg-red-500 text-white">
		<h1 class="text-5xl font-bold">Paintings from Unsplash</h1>
	</header>
	<section bind:this={section} class="relative h-[500vh]">
		<ul bind:this={ul} class="sticky top-0 flex">
			<li
				bind:this={li1}
				class="flex-stuff flex h-screen w-screen flex-col items-center justify-center overflow-hidden"
			>
				<img
					class="h-96 w-80 rounded-2xl object-cover"
					alt=""
					src="https://images.unsplash.com/photo-1553949345-eb786bb3f7ba?q=80&w=2370&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
				/>
				<h2 class="relative bottom-6 text-5xl font-bold text-red-500" bind:this={h1}>#001</h2>
			</li>
			<li
				bind:this={li2}
				class="flex-stuff flex h-screen w-screen flex-col items-center justify-center overflow-hidden"
			>
				<img
					class="h-96 w-80 rounded-2xl object-cover"
					alt=""
					src="https://images.unsplash.com/photo-1549834185-bd9f078a5dfe?q=80&w=2370&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
				/>
				<h2 class="relative bottom-6 text-5xl font-bold text-red-500" bind:this={h2}>#002</h2>
			</li>
			<li
				bind:this={li3}
				class="flex-stuff flex h-screen w-screen flex-col items-center justify-center overflow-hidden"
			>
				<img
					class="h-96 w-80 rounded-2xl object-cover"
					alt=""
					src="https://images.unsplash.com/photo-1615184697985-c9bde1b07da7?q=80&w=2274&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
				/>
				<h2 class="relative bottom-6 text-5xl font-bold text-red-500" bind:this={h3}>#003</h2>
			</li>
			<li
				bind:this={li4}
				class="flex-stuff flex h-screen w-screen flex-col items-center justify-center overflow-hidden"
			>
				<img
					class="h-96 w-80 rounded-2xl object-cover"
					alt=""
					src="https://images.unsplash.com/photo-1578301978018-3005759f48f7?q=80&w=2344&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
				/>
				<h2 class="relative bottom-6 text-5xl font-bold text-red-500" bind:this={h4}>#004</h2>
			</li>
			<li
				bind:this={li5}
				class="flex-stuff flex h-screen w-screen flex-col items-center justify-center overflow-hidden"
			>
				<img
					class="h-96 w-80 rounded-2xl object-cover"
					alt=""
					src="https://images.unsplash.com/photo-1578301978693-85fa9c0320b9?q=80&w=2519&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
				/>
				<h2 class="relative bottom-6 text-5xl font-bold text-red-500" bind:this={h5}>#005</h2>
			</li>
		</ul>
		<div bind:this={progress} class="progress"></div>
	</section>
	<footer class="flex h-[80vh] items-center justify-center bg-red-500 text-white">
		<p>
			Photos rented from
			<a class="text-lg hover:underline" target="_blank" href="https://unsplash.com">Unsplash</a>
		</p>
	</footer>
</article>

<style>
	.flex-stuff {
		flex: 0 0 auto;
	}
	.progress {
		position: fixed;
		left: 0;
		right: 0;
		height: 5px;
		background: rgb(239 68 68 / var(--tw-bg-opacity));
		bottom: 50px;
		transform: scaleX(0);
	}
</style>
