import { QuartzConfig } from "./quartz/cfg"
import * as Plugin from "./quartz/plugins"

/**
 * Quartz 4 Configuration
 *
 * See https://quartz.jzhao.xyz/configuration for more information.
 */
const config: QuartzConfig = {
  configuration: {
    pageTitle: "Hingori Sutras",
    pageTitleSuffix: " - Hingori Sutras",
    enableSPA: true,
    enablePopovers: true,
    analytics: null,
    locale: "en-US",
    baseUrl: "rushi-jariwala.github.io/spiritual_wiki",
    ignorePatterns: ["private", "templates", ".obsidian"],
    defaultDateType: "modified",
    theme: {
      fontOrigin: "googleFonts",
      cdnCaching: true,
      typography: {
        header: "Lora",
        body: "Source Serif 4",
        code: "IBM Plex Mono",
      },
      colors: {
        lightMode: {
          light: "#fdf6e3",
          lightgray: "#e8e0d0",
          gray: "#b8a898",
          darkgray: "#4a3f35",
          dark: "#2d2420",
          secondary: "#8b5e3c",
          tertiary: "#c4956a",
          highlight: "rgba(139, 94, 60, 0.10)",
          textHighlight: "#c4956a44",
        },
        darkMode: {
          light: "#1a1510",
          lightgray: "#2d2420",
          gray: "#6b5a50",
          darkgray: "#c8b8a8",
          dark: "#e8ddd0",
          secondary: "#c4956a",
          tertiary: "#8b5e3c",
          highlight: "rgba(196, 149, 106, 0.15)",
          textHighlight: "#c4956a44",
        },
      },
    },
  },
  plugins: {
    transformers: [
      Plugin.FrontMatter(),
      Plugin.CreatedModifiedDate({
        priority: ["frontmatter", "git", "filesystem"],
      }),
      Plugin.SyntaxHighlighting({
        theme: {
          light: "github-light",
          dark: "github-dark",
        },
        keepBackground: false,
      }),
      Plugin.ObsidianFlavoredMarkdown({ enableInHtmlEmbed: false }),
      Plugin.GitHubFlavoredMarkdown(),
      Plugin.TableOfContents(),
      Plugin.CrawlLinks({ markdownLinkResolution: "shortest" }),
      Plugin.Description(),
      Plugin.Latex({ renderEngine: "katex" }),
    ],
    filters: [Plugin.RemoveDrafts()],
    emitters: [
      Plugin.AliasRedirects(),
      Plugin.ComponentResources(),
      Plugin.ContentPage(),
      Plugin.FolderPage(),
      Plugin.TagPage(),
      Plugin.ContentIndex({
        enableSiteMap: true,
        enableRSS: true,
      }),
      Plugin.Assets(),
      Plugin.Static(),
      Plugin.Favicon(),
      Plugin.NotFoundPage(),
      // Comment out CustomOgImages to speed up build time
      Plugin.CustomOgImages(),
    ],
  },
}

export default config
