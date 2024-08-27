#!/usr/bin/env node
"use strict";

const asar = require("asar");
const fs = require("fs");
const util = require("util");
const exists = util.promisify(fs.exists);
const asar_path = "/Applications/RunJS.app/Contents/Resources/app.asar";
const resources_path = "/Applications/RunJS.app/Contents/Resources/";

(async () => {
	try {
		await exists(asar_path);
		asar.extractAll(asar_path, resources_path + "dist");
		const data = fs
			.readFileSync(resources_path + "dist/entry-bundle.js")
			.toString();
		const newJs = data
			.replace('const t=s.createVerify("SHA256")', "return true")
			.replace(
				"const t=u.hostname(),r=process.platform,n=await c();",
				`return  (f.set(v.autocomplete, !0),
   f.set(v.diagnostics, !0),
   f.set(h.hasValidLicense, !0),
   f.set(h.licenseKey, e),
   f.set(h.newMachineId, !0),
   (A.hasValidLicense = !0),
   w.emit("reload"),
   g.VALID);`
			);
		fs.writeFileSync(resources_path + "dist/entry-bundle.js", newJs);
		await asar.createPackage(
			resources_path + "dist",
			resources_path + "app.asar"
		);
		console.log("RunJS.app patched successfully");
	} catch (error) {
		console.log("RunJS.app not found");
	}
})();
