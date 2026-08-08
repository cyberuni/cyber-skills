import * as fs from 'node:fs'
import * as os from 'node:os'
import * as path from 'node:path'
import { afterEach, beforeEach, describe, expect, it } from 'vitest'
import { discoverWorkspace } from './fs.js'

let monorepo: string

beforeEach(() => {
	monorepo = fs.realpathSync(fs.mkdtempSync(path.join(os.tmpdir(), 'universal-plugin-ws-')))
	fs.writeFileSync(path.join(monorepo, 'pnpm-workspace.yaml'), 'packages:\n  - "packages/*"\n  - "plugins/*"\n')
	fs.mkdirSync(path.join(monorepo, 'packages', 'cyberplace'), { recursive: true })
	fs.writeFileSync(
		path.join(monorepo, 'packages', 'cyberplace', 'package.json'),
		JSON.stringify({ name: 'cyberplace', version: '0.1.0' }),
	)
	fs.mkdirSync(path.join(monorepo, 'plugins', 'aced'), { recursive: true })
})

afterEach(() => {
	fs.rmSync(monorepo, { recursive: true, force: true })
})

// Regression (#315): the same bundle operation must resolve the same workspace whatever cwd it was
// invoked from — a plugin dir walks up to the monorepo root instead of resolving to nothing.
describe('discoverWorkspace — cwd independence', () => {
	it('walks up from a nested plugin dir to the monorepo root', () => {
		const workspace = discoverWorkspace(path.join(monorepo, 'plugins', 'aced'))

		expect(workspace.get('cyberplace')).toBe('0.1.0')
	})

	it('resolves the same members from the monorepo root and from a plugin dir', () => {
		const fromRoot = discoverWorkspace(monorepo)
		const fromPlugin = discoverWorkspace(path.join(monorepo, 'plugins', 'aced'))

		expect([...fromPlugin.entries()].sort()).toEqual([...fromRoot.entries()].sort())
	})

	it('walks up from a relative root', () => {
		const cwd = process.cwd()
		process.chdir(path.join(monorepo, 'plugins', 'aced'))
		try {
			expect(discoverWorkspace('.').get('cyberplace')).toBe('0.1.0')
		} finally {
			process.chdir(cwd)
		}
	})
})
