Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:42692 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751038AbaIKCAH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 10 Sep 2014 22:00:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1XRtg4-0003up-Uy
	for util-linux@vger.kernel.org; Thu, 11 Sep 2014 04:00:05 +0200
Received: from 162.97.177.82 ([162.97.177.82])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Thu, 11 Sep 2014 04:00:04 +0200
Received: from calid1984 by 162.97.177.82 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Thu, 11 Sep 2014 04:00:04 +0200
To: util-linux@vger.kernel.org
From: Dylan Cali <calid1984@gmail.com>
Subject: Re: mount error message
Date: Thu, 11 Sep 2014 01:52:44 +0000 (UTC)
Message-ID: <loom.20140911T034049-77@post.gmane.org>
References: <540CA199.8070307@gmail.com> <20140910084732.GN21325@x2.net.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak <kzak@...> writes:

> 
> On Sun, Sep 07, 2014 at 01:19:05PM -0500, Bruce Dubbs wrote:
> > I have a user that complains that mount is giving an incorrect error message
> > under some circumstances.  For instance if mtab is symlinked to
> > /proc/self/mounts the command and /run is not in fstab:
> > 
> > $ mount /run
> > 
> > returns an error message:
> > 
> >   mount: /run: No such file or directory
> > 
> > However if mtab is a regular file, the error message is:
> > 
> >   mount: can't find /run in /etc/fstab
> 
> $ test -d /mnt/test && echo "yes" || echo "no"
> yes
> $ test -d /nothing && echo "yes" || echo "no"
> no
> 
> $ ls -l  /etc/mtab 
> lrwxrwxrwx 1 root root 12 Jun 17 15:42 /etc/mtab -> /proc/mounts
> 
> $ mount /mnt/test
> mount: can't find /mnt/test in /etc/fstab
> 
> $ mount /nothing
> mount: /nothing: No such file or directory
> 
> $ ls -l  /etc/mtab 
> -r--r--r-- 1 root root 2693 Sep 10 10:16 /etc/mtab
> 
> $ mount /mnt/test
> mount: can't find /mnt/test in /etc/fstab
> $ mount /nothing 
> mount: /nothing: No such file or directory
> 
> All works as expected.
> 
> Note that mount(8) sanitize paths specified by non-root users on
> command line, so the message "No such file or directory" is really
> expected and it's far before libmount starts to evaluate things in
> mtab/fstab.
> 
>     Karel
> 

Hello I'm the user in question.  The specific situation was a boot time
failure where /proc had failed to mount.  So to enumerate the conditions and
the result:

1) /proc is not mounted (or has failed to mount)
2) /etc/mtab is a symlink to /proc/mounts (or /proc/self/mounts)
3) /run is not in /etc/fstab
4) The directory /run exists on the filesystem

In this situation 'mount /run' results in: 
mount: /run: mount failed: No such file or directory

Obviously mount is referring to /etc/mtab not existing, so the error message
at present is misleading.




