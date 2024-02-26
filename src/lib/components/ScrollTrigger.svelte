<script lang="ts">
	import { cn } from '$lib/utils';

	export let top = 64;
	export let bottom = 64;
	export let show = true;
</script>

<div
	style={`height: calc(100vh - ${top}px - ${bottom}px); margin-top: ${top}px; margin-bottom: ${bottom}px;`}
	class={cn(show ? ' w-32 border-y border-blue-300' : ' w-0 border-0')}
>
	a
</div>
