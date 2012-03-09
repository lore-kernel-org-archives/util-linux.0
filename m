Return-Path: util-linux-owner@vger.kernel.org
Received: from damascus.uab.es ([158.109.168.135]:38374 "EHLO damascus.uab.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752541Ab2CIL2Q (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 9 Mar 2012 06:28:16 -0500
Received: from damascus.uab.es ([127.0.0.1])
 by damascus.uab.es (Sun Java System Messaging Server 6.1 HotFix 0.10 (built
 Jan  6 2005)) with ESMTP id <0M0M00BF35ZIJRD0@damascus.uab.es> for
 util-linux@vger.kernel.org; Fri, 09 Mar 2012 11:47:43 +0100 (CET)
Received: from aomail.uab.es ([158.109.65.1])
 by damascus.uab.es (Sun Java	System Messaging Server 6.1 HotFix 0.10 (builtJan
 6 2005)) with ESMTP id	<0M0M002XB5ZIHDD0@damascus.uab.es>
 forutil-linux@vger.kernel.org; Fri, 09 Mar 2012 11:47:42 +0100 (CET)
Date: Fri, 09 Mar 2012 12:48:55 +0100
From: Davidlohr Bueso <dave@gnu.org>
Subject: Re: [PATCH 09/17] lib: add fileutils function collection
In-reply-to: <CAG27Bk2LYb6h8djj0yom17oKtAy6Vvfh85Fu2k8+M9kPQGhPZg@mail.gmail.com>
To: kerolasa@gmail.com
Cc: util-linux@vger.kernel.org
Message-id: <1331293735.4092.3.camel@offworld>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
References: <20120305123847.GD486@x2.net.home>
 <"1330976334-10751-1-git-send-e mail-kerolasa"@iki.fi>
 <1330976334-10751-10-git-send-email-kerolasa@iki.fi>
 <"1 330984305.2953.25.camel"@offbook>
 <"CAG27Bk2LYb6h8djj0yom17oKtAy6Vvfh85Fu2k8+M 9kPQGhPZg"@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, 2012-03-09 at 08:56 +0100, Sami Kerola wrote:
> On Mon, Mar 5, 2012 at 22:51, Davidlohr Bueso <dave@gnu.org> wrote:
> > On Mon, 2012-03-05 at 20:38 +0100, Sami Kerola wrote:
> >>  create mode 100644 include/fileutils.h
> >>  create mode 100644 lib/fileutils.c
> >
> > Doesn't really make much sense creating two files for just one
> > function.  Couldn't xmkstemp() so somewhere else?  You might argue
> > that xgetpass also does that, I just think it's an overkill...
> 
> Hi Davidlohr,
> 
> You are right, at least partially.  The reason why I added the files
> is simply that non of the existing files felt correct to add this
> function.  IMHO xgetpass.c would be more strange file to have
> xmkstemp() than fileutils.c to contain xgetpass().

I'm just saying that xgetpass also just contains one function and that
it's an overkill, no big deal in any case.

> 
> >> +/* Create open temporary file in safe way.  Please notice that the
> >> + * file permissions are -rw------- by default. */
> >> +FILE *xmkstemp(char **tmpname)
> >
> > Returning the file descriptor seems a more flexible interface
> > instead of the FILE's representation; the user can always use
> > fdopen on his own.
> 
> If I need temporary file I rather have stream than file descriptor.
> Could you give example why flexibility is better than completeness.
> With completeness I mean service that the function provides.  If
> after every single occurrence of xmkstemp() there would be fdopen() I
> would argue adding flexibility did not do anything good.

I don't see how streams are more complete than descriptors - and no,
every call to mkstemp *does not* require a call to fdopen, that's
completely up to the user's use case.

Cheers,
Davidlohr

