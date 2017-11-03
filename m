Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47502 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752968AbdKCLAt (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 3 Nov 2017 07:00:49 -0400
Date: Fri, 3 Nov 2017 12:00:45 +0100
From: Karel Zak <kzak@redhat.com>
To: Joshua Watt <jpewhacker@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: History of Lazy and Force unmouting
Message-ID: <20171103110045.ubmpbq2jjnmznjqg@ws.net.home>
References: <1509399672.6057.30.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1509399672.6057.30.camel@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 30, 2017 at 04:41:12PM -0500, Joshua Watt wrote:
> I was hoping to get some background on why the util-linux umount
> command doesn't allow lazy unmounting (the -l flag) to be combined with
> force unmounting (the -f flag). If both flags are specified, umount
> only passes MNT_DETACH to the kernel instead of MNT_DETACH | MNT_FORCE.

The current libmount code follows the original mount(*) behavior. The
flag MNT_DETACH is supported since util-linux 2.11m (year 2001).

>  I looked through the kernel code, and it appears that the two flags
> are orthogonal, so you *should* be able to specify both? I tried
> looking back in the git history of util-linux, but it appears to have
> been that way since support for lazy unmounting was added in 2006.

2006 is time when the code was imported to the git. The important
tarball are older.

Anyway, does it make sense to use the both flags in the same time?

>From kernel code it seems that MNT_FORCE forces FS driver to kill all
resources (by op->umount_begin()) before the umount, so what do you 
expect from later MNT_DETACH?

The problem is that libmount prefers MNT_DETACH, so if you specify
both flags that MNT_FORCE is silently ignored. It would be better
prefer MNT_FORCE or accept both flags and don't try to be more smart
than kernel.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
