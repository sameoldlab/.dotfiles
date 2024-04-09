const outdir = '/tmp/ags.hypr/js'

try {
	await import(`file://${outdir}/src/main.js`)
} catch (error) {
	console.error(error)
	console.log(`run tsc or pnpm build in ${App.configDir} to build the config`)
}

export {}
