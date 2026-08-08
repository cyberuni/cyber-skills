import * as path from 'node:path'
import { describe, expect, it } from 'vitest'
import { resolveRoot } from './cli-options.js'

// Regression (#315): a relative --root left as-is ends any ancestor walk on its first step
// (`path.dirname('.') === '.'`), making a command's result depend on the cwd it ran from.
describe('resolveRoot', () => {
	it('resolves a relative --root to an absolute path', () => {
		expect(path.isAbsolute(resolveRoot('.'))).toBe(true)
		expect(path.isAbsolute(resolveRoot('some/plugin'))).toBe(true)
	})

	it('resolves "." to the cwd', () => {
		expect(resolveRoot('.')).toBe(process.cwd())
	})

	it('falls back to the cwd when --root is omitted', () => {
		expect(resolveRoot()).toBe(process.cwd())
	})

	it('leaves an absolute --root untouched', () => {
		const abs = path.resolve('/tmp/some/plugin')
		expect(resolveRoot(abs)).toBe(abs)
	})
})
