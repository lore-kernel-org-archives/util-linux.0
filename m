Return-Path: util-linux-owner@vger.kernel.org
Received: from li9-11.members.linode.com ([67.18.176.11]:49948 "EHLO
	imap.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751208Ab2IJWXZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 10 Sep 2012 18:23:25 -0400
Date: Mon, 10 Sep 2012 18:23:22 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: John Calcote <john.calcote@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: libblkid licensing patch
Message-ID: <20120910222322.GB13295@thunk.org>
References: <028201cd8f98$4e9522d0$ebbf6870$@gmail.com>
 <20120910220019.GA13295@thunk.org>
 <029701cd8fa1$d84639c0$88d2ad40$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <029701cd8fa1$d84639c0$88d2ad40$@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Sep 10, 2012 at 04:15:51PM -0600, John Calcote wrote:
> Thanks Ted - if you're still maintaining e2fsprogs, you might want to make
> similar changes to those two files on sf.net, plus tst_types.c.

Yes, it was on my TODO list to fix up e2fsprogs, and then send a patch
to util-linux.  I just got back from vacation today, though, and so
I'm still catching up on backlog; so thanks for putting together a
patch proposal for util-linux.  It wasn't quite in the right format
per the SubmittingPatches document, but Karel might deal with that
for you given that I've ack'ed the patch.  Normally you should have
put in the body of the patch something like this:

================================

Subject: libblkid: fix copyright noticed to be consistent (so all are LGPL)

The libblkid library was intended to be released under the LGPL.
There is very little significant code in version.c; just a version
parser, and the original copyright holder (Theodore Ts'o,
tytso@mit.edu) has confirmed that he had intended to relicense all of
the files under the LGPL during a time when he was the sole author.

Signed-off-by: John Calcote <john.calcote@gmail.com>

================================

.... where "Signed-off-by" has a distinct legal meeting documented in the
SubmittingPatches file in the Linux kernel sources.  Specifically:

    12) Sign your work

    To improve tracking of who did what, especially with patches that can
    percolate to their final resting place in the kernel through several
    layers of maintainers, we've introduced a "sign-off" procedure on
    patches that are being emailed around.

    The sign-off is a simple line at the end of the explanation for the
    patch, which certifies that you wrote it or otherwise have the right to
    pass it on as an open-source patch.  The rules are pretty simple: if you
    can certify the below:

            Developer's Certificate of Origin 1.1

            By making a contribution to this project, I certify that:

            (a) The contribution was created in whole or in part by me and I
                have the right to submit it under the open source license
                indicated in the file; or

            (b) The contribution is based upon previous work that, to the best
                of my knowledge, is covered under an appropriate open source
                license and I have the right under that license to submit that
                work with modifications, whether created in whole or in part
                by me, under the same open source license (unless I am
                permitted to submit under a different license), as indicated
                in the file; or

            (c) The contribution was provided directly to me by some other
                person who certified (a), (b) or (c) and I have not modified
                it.

    	(d) I understand and agree that this project and the contribution
    	    are public and that a record of the contribution (including all
    	    personal information I submit with it, including my sign-off) is
    	    maintained indefinitely and may be redistributed consistent with
    	    this project or the open source license(s) involved.

    then you just add a line saying

    	Signed-off-by: Random J Developer <random@developer.example.org>

    using your real name (sorry, no pseudonyms or anonymous contributions.)


Regards,

						- Ted
