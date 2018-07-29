Using Sphinx for technical writing
==================================

This website contains information and tutorials to set up `Sphinx <http://www.sphinx-doc.org/en/stable/>`__ for
continuous deployment (regular automated publishing of the docs) with totally free software.

The fundamental idea behind this approach is to treat documentation like code. Developers and DevOps have been
refining their workflows to deliver software. It only makes sense to me that technical writers should steal as much as
possible from their findings.

The idea of the workflow shown in this website is to solve the following problems.


Problem list
------------

- You are the only tech writer of your company and you do not have time to maintain the documentation platform and
  to write the docs.
- You want to enable developers to contribute to the docs.
- You still want to have full control over the docs to steer it in the right direction.
- You want to be able to write the docs too, or fix other contributors' documentation.
- You do not want to break the bank with licenses.
- You do not want to be forced to a proprietary format (vendor lock-in).


Solution
--------

The solution uses `GitHub <https://github.com/>`__, `Sphinx <http://www.sphinx-doc.org/en/stable/>`__ and
`Travis CI <https://github.com/>`__ but if you are using different tools, like Bitbucket, Jekyll and CircleCI, or a local
install of Git, Hugo and another deployment platform, this webside should still be meaningful.

Technical information related to technical writing is not easy to find on the internat so I hope this website can help some
other technical writers.

To see why I think Sphinx is one of the best generators (in my context), see :ref:`features`.

To see how to set it up for continuous deployment, see :ref:`deployment`.

Finally, if you are really new to "modern" technical writing based on lightweight markup languages and
static website generators, here is a quick recap.


Modern technical writing
------------------------

**What's a static website generator?**

It's a piece of software, generally free, that turns specific text files into a simple website.
Generators are generally open source, so you can modify anything, or use other people's modifications (extensions).
Most importantly, it's great because it's fast and simple. And you know... less is more.

**Why would you do that, some software is designed to write docs like MadCap Flare, oXygen, etc?**

This kind of software works but you depend on a heavy architecture that is generally slower, and harder to customize,
if possible at all.
They can even use a proprietary format, so migrating to another system becomes really hard.

Another issue is **licenses**. By design, these applications mean that only the chosen few colleagues can edit the docs,
typically technical writers.
If you work in software, the people with the knowledge are the developers since they write the code. Why would you want
to lock them out of the docs *by your choice of tooling*? If it is what you want, it should strictly be a workflow decision
that has nothing to do with anything else.

**Why Sphinx over other static website generators?**

You probably did your research and you're probably thinking that:

  - Jekyll is cool but it might be popular because it's been one of the first static website generator around.
  - Markdown is cool but it's not semantic and lacks a proper standard (CommonMark sounds great but is still lacking support).
  - Using these 2 together works well, but you'll likely end up with some HTML/MD mix that will be impossible to convert automatically
    (or expensive) the day you want to migrate to the next *cool* language/technology.
  - Hugo is blazing fast, but its support of reStructuredText is limited.
  - Other generators look really promising but the small community makes you feel that you should not use them for professional purposes.
  - Sphinx is not perfect either but I found that it provides more features than the other famous generators. More about this in the
    :ref:`features <features>` section.

For more information, there are plenty of very nice blog posts about this, here are a few links from blogs you should read:

- `Eric Holscher - Don't use markdown for technical docs <http://ericholscher.com/blog/2016/mar/15/dont-use-markdown-for-technical-docs/>`__
- `I'd rather be writing - 10 reasons for moving away from DITA <http://idratherbewriting.com/2015/01/28/10-reasons-for-moving-away-from-dita/>`__
- `I'd rather be writing - Jekyll vs DITA <http://idratherbewriting.com/2015/03/23/new-series-jekyll-versus-dita/>`__

Once again, this page offers a quick recap, not a comparison between traditional tooling and these lightweight tools.
Maybe these tools are not be applicable in your context.

.. rst-class:: hidden

.. toctree::
   :maxdepth: 2

   features.rst
   tools.rst
   continuousdeployment.rst


