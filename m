Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:61113 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751491Ab3JaQxw (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 31 Oct 2013 12:53:52 -0400
Date: Thu, 31 Oct 2013 17:53:48 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Bind mounts record fstype of none
Message-ID: <20131031165348.GK1536@x2.net.home>
References: <527122AF.90003@ubuntu.com>
 <20131031105747.GB1536@x2.net.home>
 <527266B0.7040201@ubuntu.com>
 <20131031151001.GH1536@x2.net.home>
 <52727739.70301@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52727739.70301@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Oct 31, 2013 at 11:28:57AM -0400, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 10/31/2013 11:10 AM, Karel Zak wrote:
> > There is *many disadvantages* when you use mtab, not sure if it
> > make sense to fix the issues especially when mtab is currently
> > unused by (almost) all distributions.
> > 
> > Maybe we can keep the fstype and not replace it with "none" for
> > mtab, but is it so important when we use "none" since 2009 and mtab
> > is almost dead?
> 
> I know there were a number of issues with this transition, have they
> all been worked out at this point?  Is all you need to do to make the
> switch is replace /etc/mtab with a symlink to /proc/mounts?  Maybe
> I'll try doing that.

 ... and it's also good to link mount.nfs from nfs-utils with libmount
 as NFS maintains some mount options in userspace (in this case we use
 private library /run/mount/utab file).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
