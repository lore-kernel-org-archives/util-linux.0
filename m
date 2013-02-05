Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:21457 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750842Ab3BEJh4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 5 Feb 2013 04:37:56 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r159bulM030980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 5 Feb 2013 04:37:56 -0500
Date: Tue, 5 Feb 2013 09:37:52 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Karel Zak <kzak@redhat.com>
Cc: libguestfs@redhat.com, berrange@redhat.com, util-linux@vger.kernel.org
Subject: Re: [Libguestfs] Should we always do wipefs before mkfs?  Discuss ...
Message-ID: <20130205093752.GT1543@rhmail.home.annexia.org>
References: <20130204182338.GA15222@rhmail.home.annexia.org>
 <20130205092003.GA5865@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130205092003.GA5865@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Feb 05, 2013 at 10:20:03AM +0100, Karel Zak wrote:
> On Mon, Feb 04, 2013 at 06:23:38PM +0000, Richard W.M. Jones wrote:
> > 
> > https://bugzilla.redhat.com/show_bug.cgi?id=907554
> 
>  All mkfs.<type> should be robust enough to wipe the device. I'm
>  currently working with guys around filesystems to improve mkfs.ext4
>  and mkfs.xfs
> 
>     https://bugzilla.redhat.com/show_bug.cgi?id=902512
> 
>  .. but nothing is perfect so explicitly call wipefs(8) from
>  installers or things like libguestfs is definitely good idea.
> 
> > We could change libguestfs's guestfs_mkfs (internally) so it always
> > does an implicit wipefs on the filesystem.  wipefs is not too onerous --
> > in particular I believe it only writes to a few chosen areas of the
> > disk.  Especially considering that we're about to run mkfs anyway
> > which for some filesystems writes a lot of blocks.
> 
>  wipefs(8) (or blkid_do_wipe() from the library) wipes only magic
>  strings to make the filesystem (raids or partition tables) invisible
>  for libblkid. It means very few bytes.
> 
> > Thoughts?
> 
>  Go ahead :-)

Thanks .  That was my conclusion when I looked at the wipefs code in
blkid last night: it's worth trying it, but we won't fail the whole
operation if for some reason the wipefs fails.

Here is my patch:

https://github.com/libguestfs/libguestfs/commit/72dd398679cd0bb803daf306d12558369615ba70

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW
