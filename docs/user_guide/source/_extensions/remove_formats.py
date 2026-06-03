"""
This extension is designed to remove the links to other formats
for the PDF and Word versions of the User Guide. It makes use
of the app env variable craeted and set in conf.py

See: https://gist.github.com/kakawait/9215487

To remove a file from the build it has to be 'removed' from:
 - the found documents
 - the lists of chnaged files
 - the table of contents (toctree)

 Each function below is run on the event trigger.
"""

from sphinx import addnodes


def setup(app):
    app.ignore = []
    app.connect('builder-inited', builder_inited)
    app.connect('env-get-outdated', env_get_outdated)
    app.connect('doctree-read', doctree_read)


docs_to_remove = ['formats']


def builder_inited(app):
    if app.env.config.buildername != 'html':
        app.env.found_docs.difference_update(docs_to_remove)


def env_get_outdated(app, env, added, changed, removed):
    if app.env.config.buildername != 'html':
        added.difference_update(docs_to_remove)
        changed.difference_update(docs_to_remove)
        removed.update(docs_to_remove)
    return []


def doctree_read(app, doctree):
    if app.env.config.buildername != 'html':
        for toctreenode in doctree.traverse(addnodes.toctree):
            for e in toctreenode['entries']:
                ref = str(e[1])
                if ref in docs_to_remove:
                    toctreenode['entries'].remove(e)
