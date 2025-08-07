# Open Systems Lab Homepage

Homepage for Open Systems Lab - AI Infrastructure Consulting & Cloud Solutions

## Overview

This website showcases Open Systems Lab's expertise in AI infrastructure consulting, Kubernetes, cloud solutions, and DevOps automation. Built with Hugo and the PaperMod theme for optimal performance and professional presentation.

## Technical Details

- **Static Site Generator**: Hugo v0.148.2 (extended)
- **Theme**: PaperMod
- **Deployment**: Netlify with GitHub Actions
- **Build Time**: ~40ms (optimized)

## Quick Start

### Prerequisites

- Hugo v0.148.2+ (extended version)
- Git

### Installation

```bash
# Clone the repository
git clone https://github.com/opensystemslab/homepage.git
cd homepage

# Initialize theme submodule
git submodule update --init --recursive

# Start development server
hugo server --buildDrafts --buildFuture
```

Site will be available at `http://localhost:1313`

### Production Build

```bash
# Build optimized site
hugo --minify --environment production
```

## Deployment

### Automatic Deployment (Recommended)

The site automatically deploys to Netlify via GitHub Actions on pushes to the `master` branch.

**Required Secrets** (in GitHub repository settings):
- `NETLIFY_AUTH_TOKEN`: Your Netlify authentication token
- `NETLIFY_SITE_ID`: Your Netlify site ID

### Manual Deployment

1. **Netlify**: Connect repository and set build command to `hugo --minify`
2. **Vercel**: Zero-config deployment from GitHub
3. **GitHub Pages**: Enable Pages in repository settings

## Site Structure

- `content/_index.md` - Homepage
- `content/services.md` - Services overview
- `content/case-studies.md` - Project case studies
- `content/about.md` - Company information
- `config.toml` - Hugo configuration
- `netlify.toml` - Netlify deployment settings

## Performance

- **Build Time**: ~40ms
- **Page Count**: 11 pages
- **Optimizations**: Minified CSS/JS, caching headers, theme optimizations

## Support

For technical issues or content updates:
- Create GitHub issue
- Email: hello@opensystemslab.com
