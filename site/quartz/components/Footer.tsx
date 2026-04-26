import { FullSlug, joinSegments, pathToRoot } from "../util/path"
import { QuartzComponent, QuartzComponentConstructor, QuartzComponentProps } from "./types"
import style from "./styles/footer.scss"

interface Options {
  links: Record<string, string>
}

export default ((opts?: Options) => {
  const Footer: QuartzComponent = ({ displayClass, cfg, fileData }: QuartzComponentProps) => {
    const links = opts?.links ?? []
    const baseDir = pathToRoot(fileData.slug!)

    const resolveHref = (link: string) => {
      if (/^(?:[a-z]+:)?\/\//i.test(link) || link.startsWith("#")) {
        return link
      }

      return joinSegments(baseDir, link as FullSlug)
    }

    return (
      <footer class={`${displayClass ?? ""}`}>
        <p class="footer-copy">{cfg.pageTitle}</p>
        <ul>
          {Object.entries(links).map(([text, link]) => (
            <li>
              <a href={resolveHref(link)}>{text}</a>
            </li>
          ))}
        </ul>
        <p class="footer-note">
          Concepts, stories, practices, source pages, and cross-source syntheses gathered into one
          reading path.
        </p>
      </footer>
    )
  }

  Footer.css = style
  return Footer
}) satisfies QuartzComponentConstructor
