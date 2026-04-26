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
        title: {
          name: "Cormorant Garamond",
          weights: [500, 600, 700],
        },
        header: {
          name: "Cormorant Garamond",
          weights: [500, 600, 700],
        },
        body: "Source Serif 4",
        code: "IBM Plex Mono",
      },
      colors: {
        lightMode: {
          light: "#ffffff",
          lightgray: "#ede9e4",
          gray: "#a89a8d",
          darkgray: "#4a3f36",
          dark: "#1c1410",
          secondary: "#c97030",
          tertiary: "#e8a050",
          highlight: "rgba(201, 112, 48, 0.08)",
          textHighlight: "rgba(201, 112, 48, 0.20)",
        },
        darkMode: {
          light: "#1d140e",
          lightgray: "#322217",
          gray: "#78614b",
          darkgray: "#d7c5af",
          dark: "#f3e7d6",
          secondary: "#d39f62",
          tertiary: "#a36135",
          highlight: "rgba(211, 159, 98, 0.14)",
          textHighlight: "#d39f6244",
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
