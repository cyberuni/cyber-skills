import * as path from 'node:path'
import { Option } from 'commander'

/** Repo root; resolves to cwd when omitted. */
export const ROOT_OPTION = new Option('--root <path>', 'Plugin root directory')

/** Resolves `--root` to an absolute path (cwd when omitted). Absolute is the contract: a relative
 *  root such as `.` breaks any ancestor walk downstream (`path.dirname('.') === '.'` terminates the
 *  walk on its first step), which would make the same operation behave differently depending on the
 *  cwd it was invoked from. */
export function resolveRoot(root?: string): string {
	return root === undefined ? process.cwd() : path.resolve(root)
}
