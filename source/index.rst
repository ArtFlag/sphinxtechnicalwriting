Using Sphinx for technical writing
==================================


This website is mostly a tutorial on how to setup Sphinx for continuous deployment with totally free software.

The setup presented here is great to solve the following problems:

- You are the only tech writer of your company and cannot keep up with the software production (1 TW for 6+ dev teams)
- You must wear the PM hat, the tech writer hat, and the QA hat: let's automate the QA part.
- You want to enable developers to contribute to the docs.
- You still want to have full control over the docs to steer it in the right direction.
- You want to be able to write the docs too, or fix other contributors' documentation.
- You do not want to break the bank with licenses.

The solution uses GitHub, Travis CI and Sphinx but if you are using different tools, like Bitbucket and Jekyll,
or a local setup of Git and Hugo, the examples should still be meaningful.

Before I created this set up, I looked for information and it turned out that it is difficult to find information about Sphinx
that comes from technical writers.

In order to fill this gap, I decided to create this website to share some tips and tricks that, hopefully,
will be useful to some of you, fellow tech writers.

To see why I think Sphinx is one of the best generators (in my context), refer to :ref:`features`.

To see how to set it up for continuous deployment, refer to :ref:`deployment`.

Finally, if you are really new to modern technical writing based on lightweight markup languages and
static website generators, here is a quick recap.

A recap on modern technical writing
-----------------------------------

**What's a static website generator?**

It's a piece of software, generally free, that turns text files into a simple website (static, as in "no script").
It's up to you to hack it to modify the theme of the website, or the features of the generator.
Other people have already done it, so you can just use what they created (or improve it).
Most importantly, it's great because it's fast and simple. And you know... less is more.

**Why would you do that, some software is designed to write docs like MadCap Flare, oXygen, etc?**

This kind of software works, but you depend on a heavy architecture that is generally slower, and harder to customize.
They can even use a proprietary format, so migrating to another system becomes really hard

Another issue is **licenses**. From the start, these applications mean that only the chosen few can edit the docs.
If you work in software, the people with the knowledge are the developers since they write the code. Why would you want
to lock them out of the docs *by tooling*? If it is what you want, it should strictly be a workflow decision.

**Why Sphinx over other static website generators?**

You probably did your research and you're probably thinking that:

  - Jekyll is cool but it might be popular because it's been one of the first static website generator around.
  - Markdown is cool but it's not semantic and lacks a proper standard (CommonMark sounds great but is still lacking support).
  - Using these 2 together works well, but you'll likely end up with some HTML/MD mix that will be impossible to convert automatically
    (or expensive) the day you want to migrate to the next *cool* language/technology.
  - Hugo is blazing fast, but its support of reStructuredText is limited.
  - Other generators look really promising but the small community makes you feel that you should not use them for professional purposes.

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
   basicsetup.rst


