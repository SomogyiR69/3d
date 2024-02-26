<script lang="ts">
	import Hero from '$lib/components/hero/index.svelte';
	import { Canvas, T } from '@threlte/core';
	import Wine from '$lib/components/hero/Wine.svelte';
	import { OrbitControls } from '@threlte/extras';
	import { timeline, scroll, animate } from 'motion';
	import { onMount } from 'svelte';
	import ScrollTrigger from '$lib/components/ScrollTrigger.svelte';
	import { smootherstep } from 'three/src/math/MathUtils.js';
	import Lenis from '@studio-freight/lenis';
	import { fly } from 'svelte/transition';

	onMount(() => {
		const lenis = new Lenis();

		/* lenis.on('scroll', (e) => {
			console.log(e);
		}); */
		function raf(time: number) {
			lenis.raf(time);
			requestAnimationFrame(raf);
		}

		requestAnimationFrame(raf);
	});

	let ref;
	let bottle: Element;
	let showBottle = false;
	let logo: SVGElement;
	let text: HTMLDivElement;
	let text2: HTMLDivElement;
	let firstImg: HTMLImageElement;
	let firstText: HTMLParagraphElement;
	let secondImg: HTMLImageElement;
	let secondText: HTMLParagraphElement;

	let z = -Math.PI / 2;
	let x = 0;
	let y = 0;
	let xx = 0;
	let yy = 0;
	let scrollY = 0;
	let clip = 0;

	onMount(() => {
		animate(
			logo,
			{ transform: ['translateY(-400%)', 'translateY(0)'] },
			{ delay: 0.5, duration: 1.5 }
		).finished.then(() => {
			showBottle = true;
		});

		scroll(
			(info) => {
				/* console.log(info.y); */
				console.log('math', Math.sin(info.y.current) * 3);

				z = 0;
				x = 0;
				y = 0;
				scrollY = info.y.current;
				y = 0;
				if (scrollY < (info.y.scrollLength / 4) * 2) {
					xx =
						-info.x.targetLength / 6 +
						(info.x.targetLength / 3) * smootherstep(Math.sin(info.y.current / 1200), 0, 0.7); //-info.x.targetLength / 3 + info.y.current;
				} else {
					yy = info.y.current - (info.y.scrollLength / 4) * 2 + Math.sin(100);
				}
				if (scrollY > (info.y.scrollLength / 4) * 1.08) {
					y = Math.sin(info.y.current / 1360) * 30;
				}
			}
			/* { target: bottle, offset: ['0 0.7', '1 0'] } */
		);
		scroll(
			animate(text, {
				scale: [1, 2],
				borderRadius: ['0', '2rem'],
				opacity: [0.8, 1]
			}),
			{
				target: text,
				offset: ['0 0.8', '0 0.5']
			}
		);
		scroll(
			animate(text2, {
				x: ['-300%', '0']
			}),
			{
				target: text2,
				offset: ['0 1', '0 0.5']
			}
		);

		scroll(
			animate(firstImg, { width: ['25%', '100%'], height: ['25%', '110%'], left: ['3rem', 0] }),
			{
				target: firstImg,
				offset: ['0 1', '0 0.5']
			}
		);
		scroll(animate(secondImg, { width: ['25%', '100%'], right: ['3rem', 0] }), {
			target: secondImg,
			offset: ['0 1', '0 0.5']
		});
		scroll(animate(firstText, { fontSize: ['1rem', '3rem'] }), {
			target: firstText,
			offset: ['0 1', '0 0.5']
		});
		scroll(animate(secondText, { fontSize: ['1rem', '3rem'] }), {
			target: secondText,
			offset: ['0 1', '0 0.5']
		});
	});
</script>

<div class="relative h-[300vh]">
	<p class="fixed">{scrollY}</p>
	<Hero />

	{#if showBottle}
		<div in:fly={{ x: -200, duration: 700 }} class="fixed inset-0 z-10">
			<Canvas>
				<div class="w-32">
					<T.AmbientLight />
					<T.PerspectiveCamera position={[0, 0, 5]} fov={3000}>
						<OrbitControls
							enableZoom={false}
							autoRotate={true}
							enablePan={true}
							enableRotate={true}
						/>
					</T.PerspectiveCamera>

					<T.DirectionalLight position={[10, 10, 5]} />
					<Wine bind:this={bottle} rotation={[x, y, z]} position={[xx, yy, -300]} />
				</div>
			</Canvas>
		</div>
	{/if}

	<div class=" grid h-screen place-content-center bg-[#780000]">
		<svg
			bind:this={logo}
			class="mx-auto w-96"
			xmlns="http://www.w3.org/2000/svg"
			viewBox="0 0 1260 454"
			><path
				d="M475.753 0L226.8 453.6L0 453.6L194.392 99.4116C224.526 44.5081 299.724 0 362.353 0L475.753 0Z"
				stroke="none"
			></path><path
				d="M1031.93 113.4C1031.93 50.7709 1082.7 0 1145.33 0C1207.96 0 1258.73 50.7709 1258.73 113.4C1258.73 176.029 1207.96 226.8 1145.33 226.8C1082.7 226.8 1031.93 176.029 1031.93 113.4Z"
				stroke="none"
			></path><path d="M518.278 0L745.078 0L496.125 453.6L269.325 453.6L518.278 0Z" stroke="none"
			></path><path
				d="M786.147 0L1012.95 0L818.555 354.188C788.422 409.092 713.223 453.6 650.594 453.6L537.194 453.6L786.147 0Z"
				stroke="none"
			></path></svg
		>
	</div>
	<div class="grid h-screen place-content-center bg-[#6a040f]">
		<div bind:this={text} class="z-50 bg-gray-500 px-24 py-16">
			<p class="h-fit font-bold text-white">hi</p>
		</div>
	</div>
	<div class="grid h-screen place-content-center bg-[#9d0208]">
		<div bind:this={text2} class="z-50 bg-gray-500 px-24 py-16">
			<p class="h-fit font-bold text-white">bi</p>
		</div>
	</div>
</div>
<div>
	<div class="relative grid h-screen place-content-center overflow-hidden bg-[#9b2226]">
		<p bind:this={firstText} class="z-20 h-fit font-bold text-white">di</p>
		<img
			bind:this={firstImg}
			class="absolute left-12 top-1/2 z-10 w-1/4 -translate-y-1/2 object-cover"
			src="https://images.unsplash.com/photo-1553949345-eb786bb3f7ba?q=80&w=2370&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
			alt=""
		/>
	</div>
	<div class="relative grid h-screen place-content-center overflow-hidden bg-[#370617]">
		<p bind:this={secondText} class="z-20 h-fit font-bold text-white">si</p>
		<img
			bind:this={secondImg}
			class="absolute right-12 top-1/2 z-10 w-1/4 -translate-y-1/2 object-contain"
			src="https://images.unsplash.com/photo-1549834185-bd9f078a5dfe?q=80&w=2370&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
			alt=""
		/>
	</div>
</div>
