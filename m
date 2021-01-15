Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C23C433E9
	for <util-linux@archiver.kernel.org>; Fri, 15 Jan 2021 22:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D12023A56
	for <util-linux@archiver.kernel.org>; Fri, 15 Jan 2021 22:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbhAOWAu (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 15 Jan 2021 17:00:50 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56450 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725918AbhAOWAu (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 15 Jan 2021 17:00:50 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 10FLxuKs009590
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jan 2021 16:59:57 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 795BF15C399F; Fri, 15 Jan 2021 16:59:56 -0500 (EST)
Date:   Fri, 15 Jan 2021 16:59:56 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Jonny Grant <jg@jguk.org>, util-linux@vger.kernel.org
Subject: Re: fsck needs /dev in path to check an ext4 partition
Message-ID: <YAIQXILhhLfRupPY@mit.edu>
References: <5483a74b-106e-1c6c-0265-55ed960826d8@jguk.org>
 <4930f03e-dbd0-7a2f-4b56-9f7cef88d9d2@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4930f03e-dbd0-7a2f-4b56-9f7cef88d9d2@physik.fu-berlin.de>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Jan 15, 2021 at 09:15:02PM +0100, John Paul Adrian Glaubitz wrote:
> Hello Jonny!
> 
> On 1/15/21 9:06 PM, Jonny Grant wrote:
> > Apologies I am not using 2.36.1 yet. I'm on latest Ubuntu LTS, but it's using 2.34
> > 
> > I noticed fsck only works if I write as "/dev/sdb1" not just "sdb1" I was in /dev/ as
> > root, so it shouldn't need long path?
> > 
> > These work as expected when called from /dev/ as user root
> > 
> > # fsck.ext4 sdb1  
> > # fsck.ext4 /dev/sdb1  
> > 
> > This does not work:
> > # fsck sdb1
> 
> That's because it must be:
> 
> # fsck.ext4 ./sdb1
> 
> Filenames are expanded by your shell in this case, not by the fsck utilities.

That's not what is going on --- and it has nothign to do with PATH
searching.  The way fsck parses its arguments is that it has to
distinguish between:

* device names ("/dev/sdb1")
* label or UUID specifiers (e.g., "LABEL=backup")
* options to be interpreted by fsck (e.g., "-N")
* options to be interpreted by the fsck.XXX driver (e.g., "-f")
* arguments to fsck.XXX's options (e.g.,"discard" in  "-E discard")

The generic fsck driver doesn't know that for fsck.ext4 (aka e2fsck)
that -E takes an argument.  So when you run something like "fsck -E
discard /dev/sdb1", fsck can't distinguish between the file "discard"
in your current working directory, and passing in multiple devices
which are designed to be running in parallel, e.g.: "fsck -p /dev/sda3
/dev/sdb1".

The bottom line is if you want to pass a pathname to a device, it must
not be a relative pathname.

It also means that if you need to pass in an argument to a pathname, e.g.:

	/sbin/e2fsck -j /dev/VG/ext-journal /dev/VG/filesystem

you can't just do something like:

	/sbin/fsck -j /dev/VG/ext-journal /dev/VG/filesystem

since /dev/VG/ext-journal won't be interpreted as an argument to the
-j option.   You could do something like:

	/sbin/fsck /dev/VG/filesystem -- -j /dev/VG/ext-journal

But honestly, you're probably better just explicitly specifying the
file system driver specifier (e.g., /sbin/fsck.ext4 or /sbin/e2fsck)
instead of using the fsck front-end.

The original use of fsck was so we could run multiple fsck processes
in parallel.  With distributions which use systemd, the only real
value which fsck adds is that it will automatically figure out the
file system type.  But if you're manually running fsck, most of the
time you know the file system type --- and if you are using filesystem
type specific option, you really do know the file system type ahead of
time, so you might as well skip using the fsck front-end.

Cheers,

            	     	      	   - Ted
			   
