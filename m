Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44617 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751357AbaIJIrg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 10 Sep 2014 04:47:36 -0400
Date: Wed, 10 Sep 2014 10:47:32 +0200
From: Karel Zak <kzak@redhat.com>
To: Bruce Dubbs <bruce.dubbs@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: mount error message
Message-ID: <20140910084732.GN21325@x2.net.home>
References: <540CA199.8070307@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <540CA199.8070307@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Sep 07, 2014 at 01:19:05PM -0500, Bruce Dubbs wrote:
> I have a user that complains that mount is giving an incorrect error message
> under some circumstances.  For instance if mtab is symlinked to
> /proc/self/mounts the command and /run is not in fstab:
> 
> $ mount /run
> 
> returns an error message:
> 
>   mount: /run: No such file or directory
> 
> However if mtab is a regular file, the error message is:
> 
>   mount: can't find /run in /etc/fstab


$ test -d /mnt/test && echo "yes" || echo "no"
yes
$ test -d /nothing && echo "yes" || echo "no"
no


$ ls -l  /etc/mtab 
lrwxrwxrwx 1 root root 12 Jun 17 15:42 /etc/mtab -> /proc/mounts

$ mount /mnt/test
mount: can't find /mnt/test in /etc/fstab

$ mount /nothing
mount: /nothing: No such file or directory


$ ls -l  /etc/mtab 
-r--r--r-- 1 root root 2693 Sep 10 10:16 /etc/mtab

$ mount /mnt/test
mount: can't find /mnt/test in /etc/fstab
$ mount /nothing 
mount: /nothing: No such file or directory


All works as expected.

Note that mount(8) sanitize paths specified by non-root users on
command line, so the message "No such file or directory" is really
expected and it's far before libmount starts to evaluate things in
mtab/fstab.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
