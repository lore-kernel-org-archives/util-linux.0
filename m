Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:50297 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751151AbbKQGzI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 17 Nov 2015 01:55:08 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1ZyaAU-0000XP-Jb
	for util-linux@vger.kernel.org; Tue, 17 Nov 2015 07:55:06 +0100
Received: from ip4d14b390.dynamic.kabel-deutschland.de ([77.20.179.144])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Tue, 17 Nov 2015 07:55:06 +0100
Received: from for-gmane by ip4d14b390.dynamic.kabel-deutschland.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Tue, 17 Nov 2015 07:55:06 +0100
To: util-linux@vger.kernel.org
From: "U.Mutlu" <for-gmane@mutluit.com>
Subject: Re: unshare -m should not be a privileged option
Date: Tue, 17 Nov 2015 07:54:57 +0100
Message-ID: <n2ej02$10r$1@ger.gmane.org>
References: <n2besp$j56$1@ger.gmane.org> <20151116041931.GC5949@vapier.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
In-Reply-To: <20151116041931.GC5949@vapier.lan>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Mike Frysinger wrote on 11/16/2015 05:19 AM:
> On 16 Nov 2015 03:26, U.Mutlu wrote:
>> I'm proposing that "unshare -m" should not be a privileged option,
>
> what you're asking for is not coming from util-linux.  unshare is merely an
> interface to the unshare() syscall.  if you dislike the security semantics
> there, you can post to the namespace mailing list:
> https://lists.linuxfoundation.org/mailman/listinfo/containers
>
>> Therefore the -m option (and maybe even most of the other options) of unshare
>> should be made to work for users, without needing root permission.
>
> they do already -- with user namespaces.  if you give people the ability to
> mount anything in the existing mount namespace, you open up attacks:
> - create an ext2 fs as the user with some setuid programs
> - create a new mount namespace
> - mount that image
> - instant root

I think there is a 'misunderstanding': it happens earlier, ie. when doing
"unshare -m bash" then you already become root in the new shell.
It has nothing to do with ext2 or the mount.

As I already said: solution to this problem is:
chmod u+s unshare
and starting the unshare cmd unpriviledged (ie. as user) and directly (ie. not 
via sudo).

But the bind-mount danger (vuln) still remains.


