Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:28682 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754780Ab2CZISY (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 26 Mar 2012 04:18:24 -0400
Date: Mon, 26 Mar 2012 10:18:21 +0200
From: Karel Zak <kzak@redhat.com>
To: Martin Panter <vadmium+floss@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Removing trailing slash breaks SSHFS
Message-ID: <20120326081821.GI2040@x2.net.home>
References: <CA+eR4cHKY8uVHbARbsJpUQ_gHgMm7qpU_0Dt-E0pmZ16PND8nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CA+eR4cHKY8uVHbARbsJpUQ_gHgMm7qpU_0Dt-E0pmZ16PND8nA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Mar 24, 2012 at 09:09:30AM +0000, Martin Panter wrote:
> Hi
> 
> I am using the util-linux version 2.21 on Arch Linux:
> 
> https://www.archlinux.org/packages/core/x86_64/util-linux
> 
> They have patched the 2.21-6 package to include the following commit
> “lib/canonicalize: always remove tailing slash”:
> 
> https://git.kernel.org/?p=utils/util-linux/util-linux.git;a=commitdiff;h=28074a0
> 
> The result of this is that my SSHFS entry in my “fstab” file no longer
> works properly. To demonstrate, this “mount” command
> 
> sudo mount -t fuse 'sshfs#marty@thee:/' /media/thee

 use 'mount -t fuse.sshfs / /media/thee' the 'sshfs#' notation is
 deprecated.

> strips the trailing slash and calls
> 
> /sbin/mount.fuse sshfs#marty@thee: /media/thee -o rw

I've reverted the patch -- the function canonicalize_path() is too
generic for such behavior.

Thanks for your bug report.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
