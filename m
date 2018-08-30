Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48682 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727089AbeH3NVc (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 30 Aug 2018 09:21:32 -0400
Date: Thu, 30 Aug 2018 11:20:17 +0200
From: Karel Zak <kzak@redhat.com>
To: L A Walsh <lkml@tlinx.org>
Cc: util-linux@vger.kernel.org
Subject: Re: why do I get this:/bin/findmnt.suse: /lib64/libsmartcols.so.1:
 version `SMARTCOLS_2.25' not found (required by /bin/findmnt.suse)
Message-ID: <20180830092017.lohro7xazv4fmie5@ws.net.home>
References: <5B838BAE.1010706@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5B838BAE.1010706@tlinx.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Aug 26, 2018 at 10:27:10PM -0700, L A Walsh wrote:
> when smartcols.sym has a whole section with 2.25 syms in it.
> 
> What is the point of embedding mixing symbols with versions if they don't
> work?

?

> I.e. the 2.25 version of the symbols is in the lib, but findmnt linked
> against 2.25 doesn't work cuz it can't access that specific label. (sources
> from
> 2.32.1).

Not sure if I understand. findmnt with symbols from 2.25 will work
with library from 2.32 as the library provides all previous versions
too.

For example:

 LD_LIBRARY_PATH=/home/projects/util-linux/util-linux/.libs/ /usr/bin/findmnt

allows me to run old findmnt 2.30.2 (fedora 27) against library from
current git tree (v2.33).


> I don't understand why the symbols are versioned in a library that doesn't
> appear to have anything other than a normal symbol table.

* list of symbols defines the library API. It's better to have
  explicit list in the .sym file than depend on static/extern keywords
  in the code.

* symbols versioning is fine grained solution. The library does not need to 
  change library soname version; symbols versioning provides the same 
  functionality on symbols level.

* library is ready for future incompatible changes

* versioned symbols allow to create explicit dependence between binary
  and library. This is used for example by distribution packaging
  systems (e.g. rpm) where package with binary requires specific
  symbols and package with library provides the symbols. It's better
  than dependence on library soname.

* binary with new symbols will not executed against library with old
  symbols only.

> So why are these symbols versioned if they don't work?  They seem to prevent
> earlier versions of programs from working with later libs even though they
> are compatible.

It's not true if the library provides old versions too.

See excellent Ulrich's shared library howto for more details (chapter 3.3):
https://software.intel.com/sites/default/files/m/a/1/e/dsohowto.pdf

   Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
