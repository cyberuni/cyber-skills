// @ts-check
import starlight from "@astrojs/starlight";
import tailwindcss from "@tailwindcss/vite";
import { defineConfig } from "astro/config";

export default defineConfig({
  site: "https://cyberuni.github.io",
  base: "/cyberplace/",
  vite: {
    plugins: [tailwindcss()],
    server: {
      watch: {
        usePolling: true,
      },
    },
  },
  integrations: [
    starlight({
      title: "cyberplace",
      description:
        "Opinionated skills, hooks, and workflows for AI agents — Claude Code, Cursor, Codex, and others.",
      social: [
        {
          icon: "github",
          label: "GitHub",
          href: "https://github.com/cyberuni/cyberplace",
        },
      ],
      customCss: ["./src/styles/global.css"],
      components: {
        SiteTitle: "./src/components/SiteTitle.astro",
      },
      sidebar: [
        {
          label: "Getting Started",
          items: [
            { label: "Introduction", slug: "getting-started/introduction" },
            { label: "Installation", slug: "getting-started/installation" },
            { label: "Supply Chain", slug: "getting-started/supply-chain" },
          ],
        },
        {
          label: "Agent Configuration",
          items: [
            { label: "Overview", slug: "agent-configuration/overview" },
            {
              label: "Instructions",
              items: [
                {
                  label: "Purpose",
                  slug: "agent-configuration/instruction-purpose",
                },
                {
                  label: "Target",
                  slug: "agent-configuration/instruction-target",
                },
              ],
            },
          ],
        },
        {
          label: "The Motive Model",
          items: [
            { label: "Overview", slug: "motive-model/overview" },
            {
              label: "Positions Are Not Roles",
              slug: "motive-model/positions-are-not-roles",
            },
            { label: "The Four Actors", slug: "motive-model/four-actors" },
            {
              label: "Two Faces and the Gate",
              slug: "motive-model/faces-and-the-gate",
            },
            {
              label: "Delegates and Surfaces",
              slug: "motive-model/delegates-and-surfaces",
            },
            {
              label: "Variants and How People Grow",
              slug: "motive-model/variants",
            },
            { label: "Scenarios", slug: "motive-model/scenarios" },
            { label: "Recursion", slug: "motive-model/recursion" },
            { label: "Glossary", slug: "motive-model/glossary" },
          ],
        },
        {
          label: "SDD Workflow",
          items: [
            { label: "Overview", slug: "sdd/overview" },
            { label: "Control Flow", slug: "sdd/control-flow" },
            { label: "The Fleet Metaphor", slug: "sdd/metaphor" },
            { label: "Scenario", slug: "sdd/scenario" },
            { label: "Spec Dependencies", slug: "sdd/spec-dependencies" },
            {
              label: "Spec-Driven Development",
              slug: "sdd/spec-driven-development",
            },
            {
              label: "Test-Driven Development",
              slug: "sdd/test-driven-development",
            },
            { label: "Use Case", slug: "sdd/use-case" },
          ],
        },
        {
          label: "CLI Reference",
          items: [
            { label: "Overview", slug: "cli/overview" },
            { label: "audit", slug: "cli/audit" },
            { label: "governance", slug: "cli/governance" },
            { label: "hook", slug: "cli/hook" },
            { label: "skill", slug: "cli/skill" },
          ],
        },
        {
          label: "Governances",
          items: [
            { label: "Overview", slug: "governances/overview" },
            { label: "Skill Design", slug: "governances/skill-design" },
            {
              label: "Skill Repo Structure",
              slug: "governances/skill-repo-structure",
            },
            {
              label: "Agent Tool Output",
              slug: "governances/agent-tool-output",
            },
            { label: "CLI Resolution", slug: "governances/cli-resolution" },
            { label: "Universal Plugin", slug: "governances/universal-plugin" },
          ],
        },
        {
          label: "Concepts",
          items: [
            {
              label: "Skills",
              items: [
                { label: "Overview", slug: "concepts/skills" },
                { label: "Responsibility", slug: "concepts/responsibility" },
                { label: "Commands", slug: "concepts/commands" },
                {
                  label: "Direct Invocation Skill",
                  slug: "concepts/direct-skill",
                },
                { label: "Gateway Skill", slug: "concepts/gateway-skill" },
                { label: "Persona", slug: "concepts/persona" },
                { label: "Governances", slug: "concepts/governances" },
                { label: "Disciplines", slug: "concepts/disciplines" },
              ],
            },
            { label: "Constraints", slug: "concepts/constraints" },
            { label: "Permissions", slug: "concepts/permissions" },
          ],
        },
        { label: "Glossary", slug: "glossary" },
        {
          label: "ACED",
          items: [
            { label: "Overview", slug: "aced/overview" },
            { label: "init-aced", slug: "aced/init-aced" },
            { label: "define-skill", slug: "aced/define-skill" },
            { label: "define-agent", slug: "aced/define-agent" },
            { label: "define-governance", slug: "aced/define-governance" },
            { label: "skillify", slug: "aced/skillify" },
            { label: "contribute-skill", slug: "aced/contribute-skill" },
            { label: "run", slug: "aced/run" },
            { label: "add-scenario", slug: "aced/add-scenario" },
            { label: "compare", slug: "aced/compare" },
            { label: "improve", slug: "aced/improve" },
            { label: "report", slug: "aced/report" },
          ],
        },
        {
          label: "Quill",
          items: [
            { label: "Overview", slug: "quill/overview" },
            { label: "init-quill", slug: "quill/init-quill" },
          ],
        },
        {
          label: "cyberlegion",
          items: [
            { label: "Overview", slug: "cyberlegion/overview" },
            {
              label: "CLI Architecture (target)",
              slug: "cyberlegion/architecture",
            },
          ],
        },
        {
          label: "cyberfleet",
          items: [
            { label: "Overview", slug: "cyberfleet/overview" },
            { label: "Pod", slug: "cyberfleet/pod" },
            { label: "Operator", slug: "cyberfleet/operator" },
            { label: "Crimp", slug: "cyberfleet/crimp" },
            { label: "Mechanic", slug: "cyberfleet/mechanic" },
          ],
        },
        {
          label: "Disciplines",
          items: [
            {
              label: "Commit Discipline",
              slug: "disciplines/commit-discipline",
            },
          ],
        },
        {
          label: "universal-plugin",
          items: [
            {
              label: "Introduction",
              slug: "universal-plugin/getting-started/introduction",
            },
            {
              label: "Installation",
              slug: "universal-plugin/getting-started/installation",
            },
            { label: "CLI Overview", slug: "universal-plugin/cli/overview" },
            { label: "build", slug: "universal-plugin/cli/build" },
          ],
        },
      ],
    }),
  ],
});
