Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pb0-f46.google.com ([209.85.160.46]:53727 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257Ab2IJWPz (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 10 Sep 2012 18:15:55 -0400
Received: by pbbrr13 with SMTP id rr13so3120782pbb.19
        for <util-linux@vger.kernel.org>; Mon, 10 Sep 2012 15:15:55 -0700 (PDT)
From: "John Calcote" <john.calcote@gmail.com>
To: "'Theodore Ts'o'" <tytso@mit.edu>
Cc: <util-linux@vger.kernel.org>
References: <028201cd8f98$4e9522d0$ebbf6870$@gmail.com> <20120910220019.GA13295@thunk.org>
In-Reply-To: <20120910220019.GA13295@thunk.org>
Subject: RE: libblkid licensing patch
Date: Mon, 10 Sep 2012 16:15:51 -0600
Message-ID: <029701cd8fa1$d84639c0$88d2ad40$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Thanks Ted - if you're still maintaining e2fsprogs, you might want to make
similar changes to those two files on sf.net, plus tst_types.c.

--john

> -----Original Message-----
> From: Theodore Ts'o [mailto:tytso@mit.edu]
> Sent: Monday, September 10, 2012 4:00 PM
> To: John Calcote
> Cc: util-linux@vger.kernel.org
> Subject: Re: libblkid licensing patch
> 
> On Mon, Sep 10, 2012 at 03:07:35PM -0600, John Calcote wrote:
> > Hello util-linux maintainers -
> >
> > We'd like to use libblkid, but our lawyers are pedantic. Please accept
> > this patch, which changes two of the comment headers in libblkid to
> > reflect the license specified in libblkid/COPYING file.
> >
> > Summary: Two files, one line each.
> 
> Acked-by: "Theodore Ts'o" <tytso@mit.edu>
> 
> The intention was to relicense blkid under the LGPL, and this was done
when
> I was the sole author of the files in question.  I just overlooked these
two
> files.
> 
> 						- Ted

