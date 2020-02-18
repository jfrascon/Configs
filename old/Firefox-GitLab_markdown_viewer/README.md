Name: [GitLab markdown viewer](https://addons.mozilla.org/en-GB/firefox/addon/gitlab-markdown-viewer/?src=search)  

[GitHub's project page](https://github.com/painyeph/GitLabMarkdownViewer)  

## Installing on Linux

Firefox on Linux may not know how to handle markdown files by default.
A workaround for this is to add a new MIME type for markdown file extensions.
Add the following XML file to `~/.local/share/mime/packages/text-markdown.xml`:

```
<?xml version="1.0"?>
<mime-info xmlns='http://www.freedesktop.org/standards/shared-mime-info'>
  <mime-type type="text/plain">
    <glob pattern="*.md"/>
    <glob pattern="*.mkd"/>
    <glob pattern="*.mkdn"/>
    <glob pattern="*.mdwn"/>
    <glob pattern="*.mdown"/>
    <glob pattern="*.markdown"/>
  </mime-type>
</mime-info>
```

Then run in the terminal:

```
$ update-mime-database ~/.local/share/mime
```
