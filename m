Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:3911 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751624Ab3KSR1Y (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 19 Nov 2013 12:27:24 -0500
Date: Tue, 19 Nov 2013 18:27:18 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: umount by uuid
Message-ID: <20131119172050.GL5572@x2.net.home>
References: <528A735A.9060606@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <528A735A.9060606@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 18, 2013 at 03:06:50PM -0500, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> It seems that you now can umount by uuid using the UUID= tag, but not
> with the -U switch, so it doesn't mirror mount.


 man umount:

    A file system is specified by giving the directory where it has been
    mounted.  Giving the special device on which the file system lives
    may also work, but is obsolete, mainly because it will fail in case
    this device was mounted on more than one directory.

 .. so umount by tag is supported (and will be supported) but I don't
 think we need to extend this functionality. Add -U and -L to umount
 seems like a bad idea.
 
> or is the -U form considered depreciated?

 That's a good question, I don't like -{U,L} because these options are
 tag specific. For example now we also support PARTUUID= and there is
 no a special command line option for this tag. Anyway, people use the
 -{U,L} options, so we will support it probably forever... (internally
 it does not matter as all is converted to tags).


 Note that I found a bug in mount and umount, mount and umount by TAG=
 does not work for non-root users since v2.23. Fixed in git tree.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
