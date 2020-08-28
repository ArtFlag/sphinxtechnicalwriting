.. _docker:

Using Docker
============

Docker is a way to make any project easier and potentially faster to build.

In a nut shell, Docker allows you to build **images**. An image contains everything required by a project,
typically:

- The operating system, such as Linux.
- The dependencies, such as Python and sphinx and your sphinx extensions.
- Your source code (or docs files).

When you run an image, it turns into a virtual machine, called container, in which you can run your app. It might
sound a bit similar to the virtual environment mentioned in :ref:`config-env`, but it's completely stand alone.

It also offers other valuable features of caching/layering that help speed up your builds.
Read more about its main concepts on the `Docker website <docker_container_>`_.


Creating a Dockerfile
---------------------

The first step towards building our project with Docker is to create an image. This image defines what we need
to build our project. See the `Docker docs <images_>`_.

The standard name for a Docker file is ``Dockerfile`` (genius stuff).

Choosing the base image
+++++++++++++++++++++++

As mentioned earlier, we must choose the operating system first. There are many images for various operating
systems on `Docker Hub <https://hub.docker.com/search?q=linux&type=image>`_. These are called base images,
because they are the starting point of any Docker image.

We could install any of these images, and then install what we need, such as Python and our dependencies.
This is a task that all Python developers perform often, so in order to speed up the process,
the Python foundation already provides many images that contain Python. See the `list of images
<https://hub.docker.com/_/python>`_.

Let's pick a Python version, we want to use **Python 3.8.2**. This is somewhat arbitrary and more importantly, it is
used in our `Pipfile`_, so we have to match this version for coherence purposes.

The second choice is the type of Python image. As you can see, there are Buster images, Alpine images, and more.
These are different versions of Linux. Python cannot run on its own, it must run on an operating system so
these Python images are also based on other images (the Linux images).

To keep the choice simple, it's `good practice <article_>`_ to use the smallest image possible. Let's choose
``3.8.2-slim-buster``. It's a standard choice for a lot of Python projects and a rather lightweight image
that contains most of what we need.

To use it in our Dockerfile, we simply write:

.. code-block:: bash

   FROM python:3.8-slim-buster


Installing the dependencies
+++++++++++++++++++++++++++

We have a base image that runs Python on Linux (Debian). We can add our dependencies.

This is a more complicated step as we need to understand what's in the base image, and what's not.
In our case:

- we need everything from our `Pipfile <pipfile_>`_, so we install ``pipenv``.
- we want to use our `Makefile <makefile_>`_  to build the docs, so we install ``make``.

It's also good practice to install security updates and also get rid of cached files.

To do this, we use:

.. code-block:: bash

  RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y make && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir pipenv

The ``RUN`` instruction allows us to execute any command. These commands are standard Debian commands
to install packages.

.. note:: Without getting into too much detail, no caching is needed in a Docker image and the lighter the
    image the better, so we delete the cache using ``apt-get clean``, ``rm -rf /var/lib/apt/lists/*``, and
    ``no-cache-dir``.

.. note:: The ``RUN`` (as as all ``COPY`` and ``ADD``) instruction also creates `layers <layers_>`_. It's a
   topic in itself but Docker recommends to separate installation instructions from what almost never
   changes, to what changes more often to optimize build times. In your case, we don't need much,
   and these package never change so they come into the initial RUN instruction.

To modify what's installed in this image, you would typically add package names after ``make``.
The rest can stay if you require ``pipenv``.


Setting the work directory
++++++++++++++++++++++++++

Our image doesn't contain any of our files at the moment, only Linux and extra packages.
In the next step, we will copy files from our repository to the image, but now, let's set the working directory
to the name of the repository.

We do this with:

.. code-block:: bash

   WORKDIR /sphinxtechnicalwriting

This folder is now the default path for all the following commands we will run.

Copying files
+++++++++++++

The objective of the image is to install our project dependencies, they are listed in our Pipfile.
We have installed Pipenv, so before we can use it to install our dependencies, we must copy our Pipfile and Pipfile.lock files
to our image. If the image does not contain them, it will not be able to install anything.

We do this with:

.. code-block:: bash

   COPY Pipfile Pipfile.lock /sphinxtechnicalwriting/

Notice that we copy them to our working directory.

Installing the dependencies
+++++++++++++++++++++++++++

We have copied our dependency list to our image, we can now build them in our image.

We do this with:

.. code-block:: bash

   RUN pipenv install --system --deploy

This command is similar to what we used in :ref:`config-env` but slightly modified for Docker use. It
doesn't create a virtual environment but installs everything at system level and also install the packages
from the lock file. See the `Pipenv docs`_.


Building the image
------------------

We have the following Dockerfile:

.. literalinclude:: ../../Dockerfile

To build it, run:

.. code-block:: bash

   docker build -t sphinx_image .

This creates an image named ``sphinx_image``.


Using the image
---------------

Once you have built the image, you can run any command in it using:

``docker run sphinx_image <command>``

For example:

.. code-block:: bash

   docker run sphinx_image echo "hello"

prints ``hello``.

We created the image to build the docs so let's use our Makefile:

.. code-block:: bash

   docker run sphinx_image make html

This outputs ``make: *** No rule to make target 'html'.  Stop.``, which is normal since there is no makefile in
this image. There is only our dependencies.

Let's create a volume to share our repository with the docker image:

.. code-block:: bash

   docker run -v $(pwd):/sphinxtechnicalwriting sphinx_image make html

The docs are built and the output is in the same folder as when you run it locally.

Next steps
-----------

There's no real benefit in using Docker if you've already set up a local environment, but if you haven't
you can build the docs in 2 commands, which is great:

.. code-block:: bash

   docker build -t sphinx_image .
   docker run -v $(pwd):/sphinxtechnicalwriting sphinx_image make html


You can also use this image in your CI pipeline to get reproducible builds, and speed them up by using a Docker
image registry.


.. _pipenv docs: https://pipenv.pypa.io/en/latest/advanced/#using-pipenv-for-deployments
.. _layers: https://dzone.com/articles/docker-layers-explained
.. _makefile: https://github.com/ArtFlag/sphinxtechnicalwriting/blob/master/Makefile
.. _pipfile: https://github.com/ArtFlag/sphinxtechnicalwriting/blob/master/Pipfile
.. _docker_container: https://www.docker.com/resources/what-container
.. _images: https://docs.docker.com/engine/reference/commandline/images/
.. _article: https://pythonspeed.com/articles/base-image-python-docker-images/
