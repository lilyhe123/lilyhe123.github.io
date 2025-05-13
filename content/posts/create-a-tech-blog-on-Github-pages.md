---
date: "2025-05-05"
title: "Create a Tech Blog on GitHub Pages"
summary: "I kicked things off with a post about how to set up a blog site — seems like a good place to start!"
description: ""
showtoc: true
readTime: true
autonumber: true
math: true
tags: ["tutorial"]
categories:
showTags: false
hideBackToTop: false
cover:
  image: "https://picsum.photos/id/20/200/100"
  alt: ""
  caption: ""
  relative: false
---
## Why I’m Writing This

I wanted to set up a tech blog hosted on GitHub Pages. After a quick search, it seemed like the process would be straightforward — something I could get done in minutes. I found some tutorials, like [this one](https://chirpy.cotes.page/posts/getting-started/) for the Chirpy theme. I followed the steps closely… but I just couldn’t get it to work. And the real issue was I had no idea how to fix it. That led to a few days of digging, debugging, learning, and experimenting. Eventually, I got the blog up and running on GitHub Pages. Now I want to put together some takeaways.

> When a tutorial breaks, understanding begins.

## What is GitHub Pages?
Let’s start with the basics.

[GitHub Pages](https://docs.github.com/en/pages) is a free static site hosting service offered by GitHub. It lets you publish a static website directly from a GitHub repository.

So, what’s a static website? And are static sites still relevant?

As a backend engineer, I’m used to building web apps that render pages dynamically on the server side. Static sites, in contrast, don’t need a backend. All HTML, CSS, and JavaScript files are pre-rendered and simply served as-is and remain unchanged until redeployed. It’s almost like going back to the early days of the web.

This simplicity has its perks - static sites are fast, secure, and easy to scale. Since serving a request is just sending a file, there’s no server-side code or database query involved. But, I wondered: What about interactivity, personalization, or real-time features? For a tech blog, where content is mostly fixed, this seemed ok. But could it handle features like comments or search? Let’s explore.

## Building a Static Site
There are two main ways to create a static site:
1. Manual Approach: Craft HTML, CSS, and JavaScript files by hand. A typical file structure looks like this:

```python
my-static-site/
├── index.html              # Homepage
├── about.html              # Other static pages
├── contact.html
├── assets/                 # Images, fonts, etc.
│   ├── img/
│   └── fonts/
├── css/                    # Stylesheets
│   └── style.css
├── js/                     # JavaScript
│   └── main.js
├── blog/                   # Blog posts
│   ├── post1.html
│   └── post2.html
└── sitemap.xml             # SEO sitemap
```

This is ideal for front-end enthusiasts or those learning web development. Once files are ready, publish them to GitHub Pages following [GitHub Pages’s branch-based method](https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site#publishing-from-a-branch). You just specify which branch and which folder in your repo should serve as the website root.

2. Static Site Generator (SSG): Writing HTML manually isn’t for everyone. That’s where SSGs come in. With SSGs, you write content in Markdown, define templates and layouts, and let the tool generate static files for you. A project using a SSG might look like this:

```python
my-site/
├── posts/                # Markdown files (e.g. for posts)
│   └── post1.md
│   └── post2.md
├── layouts/                # Templates to structure HTML output
├── static/                 # Static files copied as-is to output
├── public/                 # Generated site (output folder)
├── config.toml             # Site configuration
└── themes/                 # Reusable theme templates
```
SSGs simplify blogging by handling repetitive tasks, making them ideal for non-coders. Popular SSGs include Jekyll, Hugo, Eleventy, and Astro.

There are two common ways to publish this kind of project to GitHub Pages:

1. Publish from a branch: Generate static files locally, then commit them (often in a separate branch) and configure GitHub Pages to serve from that branch.
2. Use GitHub Actions: Automate the build and deploy process.

## What is GitHub Actions?

[GitHub Actions](https://docs.github.com/en/actions) is a CI/CI platform that automates workflows, like building, testing, and deploying.

To use it for your blog, you need to provide a workflow file, usually a YAML file stored in `.github/workflows/` folder. Everytime you push a change to your repository, the workflow is triggered and run on a GitHub-hosted virtual machine, builds the site using the SSG, and deploys it to GitHub Pages. This approach keeps your repository clean by avoiding generated files, as the build happens on-the-fly when you push changes.

Here's a sample workflow for deploying a Hugo site:
```yaml
name: Deploy to GitHub Pages
on:
  push:
    branches:
      - main
  workflow_dispatch:
permissions:
  contents: read
  pages: write
  id-token: write
env:
  HUGO_VERSION: 0.136.5
jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          submodules: true
      - uses: peaceiris/actions-hugo@v3
        with:
          hugo-version: ${{ env.HUGO_VERSION }}
          extended: true
      - run: hugo --minify
      - uses: actions/upload-pages-artifact@v3
        with:
          path: ./public
      - uses: actions/deploy-pages@v4
```
Writing a workflow file is a bit trickier for biginners, due to YAML’s syntax and the mix of actions and shell commands, but many SSGs provide prebuilt workflow files to get you started.

## Choose a Static Site Generator (SSG)
There are tons of SSGs out there, even just for personal blogs. Here are some popular ones:
- Jekyll – Ruby-based, integrated with GitHub Pages
- Hugo – Go-based, super fast, great theme ecosystem
- Eleventy – JavaScript-based, simple and flexible
- Pelican – Python-based
- Next.js / Gatsby / Astro – More advanced, React/Vue-based

I went with Hugo for its blazing speed and beautiful theme options. Plus, it gave me a good excuse to explore Go. Following [Hugo's quick start](https://gohugo.io/getting-started/quick-start/), I set up my site efficiently, then focused on customizing a theme to match my preferred style. The process was largely smooth, though experimenting with different themes did lead to one deployment failure. This occured because a particular theme required a more recent version of Hugo. If Actions failed, go to the Actions tab to check outputs and mostly it will give you some clue.

## Are Static Sites Still Relevant?

Absolutely. For blogs, portfolios, and documentation sites, static sites are a great fit because of security (no backend = fewer attack surfaces), performance (pre-rendered HTML is lightning fast) and simplicity (no servers or databases to manage).

And they’re not as limited as they once were. Thanks to JAMstack (JavaScript, APIs, Markup) architecture, you can still build rich, dynamic experiences by adding interactivity via client-side JavaScript and third-party APIs. For example, to add search function, pre-generate a search index and use client-side JS to filter it. To add comment section, use services like Disqus or Hyvor Talk. Many SSG themes come with built-in support for these features, saving you time and effort.

I’ll probably cover JAMstack more in a future post—it’s a powerful model for modern web development.

## Takeaways
Having a solid grasp of the fundamentals and what's happening "under the hood" equips you with the confidence and understanding necessary to tackle and fix issues when they occur. This still resonates in AI age. With AI-powered tools and automation, it’s tempting to rely entirely on abstractions — letting the tool do the thinking while you follow along. But when something breaks or behaves unpredictably (and it will), you’re left in the dark unless you actually understand the system beneath the surface.