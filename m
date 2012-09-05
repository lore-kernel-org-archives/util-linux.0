Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:22562 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751398Ab2IEJjL (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 5 Sep 2012 05:39:11 -0400
Date: Wed, 5 Sep 2012 11:39:07 +0200
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: su: (why not?) merged from latest coreutils
Message-ID: <20120905093907.GC32623@x2.net.home>
References: <504624F3.2020601@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <504624F3.2020601@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Sep 04, 2012 at 05:57:39PM +0200, Bernhard Voelker wrote:
> Hi Karel,
> 
> su has not been "merged from latest coreutils".

hmmm... it seems that Ludwig has used code from suse rather than the
latest upstream.

> If you look at su.c's history in the coreutils tree, then there are
> 25 changes before it has been removed from the project:
> 
>   $ git log --oneline v6.1-64-gd8049d7..v8.17-16-g928dd73 -- src/su.c
>   928dd73 su: remove program (util-linux is now the best source for it)
>   d787845 maint: use single copyright year range
>   a517386 maint: src/*.c: change remaining quotes (without embedded spaces)
>   101d120 maint: use new emit_try_help in place of equivalent fprintf
>   5111aa4 maint: update all copyright year number ranges
>   71b7ddc port to GNU hosts, where getuid and friends can fail
>   9d6231e maint: update all copyright year number ranges
>   1aa17dc maint: update all FSF copyright year lists to include 2010
>   1c59bb3 nice, nohup, su: detect write failure to stderr
>   c690047 maint: let gnulib provide environ
>   b6540b9 chroot, env, nice, su: use EXIT_CANCELED for internal failure
>   32f987a build: avoid compiler warnings on cygwin 1.5
>   5d4f09d doc: mention the texinfo documentation in --help
>   5e778f7 global: convert indentation-TABs to spaces
>   2232b4d maint: update all Copyright year lists to include 2009
>   9fdf584 maint: Clarify ambiguous refs to Linux kernels or GNU/Linux systems
>   22a2a43 build: add configure-time --enable-gcc-warnings option; avoid warnings
>   45e6718 remove redundant const directives
>   1463824 add "const" attribute, where possible
>   896b672 use gnulib's progname module
>   434258c declare program_name consistently
>   581b2e3 adjust copyright dates
>   b69b4cc convert single-author programs to use proper_name
>   3575545 Use EXIT_FAILURE, not EXIT_FAIL, now that EXIT_FAILURE is always 1.
>   71aa3ea Update all copyright notices to use the newer form.
>   33342c1 Change "version 2" to "version 3" in all copyright notices.
>   a0faff1 Help translators include translation team's web or email address.
> 
> 
> Many of the changes are minor ones regarding identation, internal error

 yep

> code fixes, copyright year number changes etc. but at least the following
> seem to be worth including:
> 
>   71b7ddc port to GNU hosts, where getuid and friends can fail
>   1c59bb3 nice, nohup, su: detect write failure to stderr

 Fixed.

> and these would be nice:
> 
>   a517386 maint: src/*.c: change remaining quotes (without embedded spaces)

 It seems that `foo' quotes is a generic problem in our code. Not sure
 why this is so important.

>   9fdf584 maint: Clarify ambiguous refs to Linux kernels or GNU/Linux systems

 no comment ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
