ehtml
=====

Eiffel HTML Element Library

Purpose
=======

The primary purpose of the eHTML library is to provide a rapidly reusable framework capable of fast generation of HTML/JS response pages to browser requests on a RESTful model.

Primary Classes
===============
There are a number of primary classes to pay attention to. Most specifically: HTML_FACTORY

The factory class provides the primary means for fast generation of HTML/JS script code. On top of this library, one will want to build another library of reusable class modules where one can quickly assemble sophisticated web sites. Moreover, it is in the class libraries that one builds on top of eHTML that the full power of Eiffel, inheritance, Generics, Agents, Void-safety, and even SCOOP will carry the heaviest load of web site construction.

Compilation
===========

1. $ISE_USER_FILES Environment Variable: eHTML has a dependency on this environment variable to point at the "encoder" library, where it is stored in the IRON packages directory structure (e.g. $ISE_USER_FILES\14.05\iron\packages\ewf\text\encoder\encoder-safe.ecf). Remaining libraries are pathed with $ISE_EIFFEL or $ISE_LIBRARY.

To-Do's
=======

1. Page cache: Ability to cache created pages and re-serve them without regeneration.
2. HTTPS-enable: Ability to limit accessed by way of authentication.
3. P2P-com: Simple and framework-level coordination of page-to-page communication and response generation.
4. DB: Simple and framework-level data storage using the new ABEL and ABEL Extension libraries.

