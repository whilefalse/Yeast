Yeast
=====

What is Yeast?
---

Every other web framework has a really simple way to create a new project. 
With Cake, it's "download this zip, unzip it, put this file here, change this value, etc..."

*This sucks, big time.*

Yeast is an attempt to fix this. It's a little bash script to manage your versions
of CakePHP and create projects easily.

Installation
----
Get the "yeast" (if using Unix) or "yeast.bat" (if using Windows) file, drop it in your path somewhere and make it executable.


Usage (Unix)
---

Install CakePHP 1.3 (cake code stored in /usr/lib/cakephp by default)

    sudo yeast install 1.3

Uninstall CakePHP 1.3

    sudo yeast uninstall 1.3

Show installed versions

    yeast list

Create a new project

    yeast create <project_path>


Usage (Windows)
---

NOTE: Install CakePHP 1.3 before running yeast (cake code referenced from C:\wamp\www\cakephp by default)


Open CMD and run the following command:
	yeast create <project_path>


If you need further usage instructions please run yeast with no parameters