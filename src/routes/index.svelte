<!-- src/routes/index.svelte -->
<svelte:head>
	<title>Welcome</title>
</svelte:head>

<h1>Hello and welcome to my site!</h1>
<script>
    	import { goto } from '$app/navigation';
	goto('#about');
</script>