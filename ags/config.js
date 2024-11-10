const outdir = App.configDir + '/build'
console.log(outdir)
try {
	await import(`file://${outdir}/main.js`)
} catch (error) {
	console.error(error)
	console.warn(`run tsc or pnpm build in ${App.configDir} to build the config`)
}

export { }
