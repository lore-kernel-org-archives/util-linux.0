Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:29094 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752053Ab3JaK5v (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 31 Oct 2013 06:57:51 -0400
Date: Thu, 31 Oct 2013 11:57:47 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Bind mounts record fstype of none
Message-ID: <20131031105747.GB1536@x2.net.home>
References: <527122AF.90003@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <527122AF.90003@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Oct 30, 2013 at 11:15:59AM -0400, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I came across an old bug filed in debian noting that mount records the
> fstype for bind mounts as 'none' and this causes df to suppress

 It was explicitly requested by Al Viro to use "none" for some 
 VFS operations years ago (c4966ccb16868fa748009a826340fac9d1b1ce39,
 0fae284a7a13d4d2dba7a908e0662a6d9c46f877).

 I think it's correct, because FS type does not make any sense there
 and it's waste of time to try to determine FS type for MS_BINS or
 MS_PROPAGATION operations.

> showing it.  This seems like an error to me.  The type should be what
> the actual filesystem type is, and if df wants to suppress showing
> bind mounts, it should do so based on the bind flag.

 Seems like you're victim of the mtab file. My Fedora 19:

    # mount --bind /home /mnt/test
    # mount | grep /mnt/test
    /dev/sda5 on /mnt/test type ext4 (rw,relatime,data=ordered)


   Karel
 
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
