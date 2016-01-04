Return-Path: util-linux-owner@vger.kernel.org
Received: from mail2.vodafone.ie ([213.233.128.44]:50990 "EHLO
	mail2.vodafone.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190AbcADB37 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 3 Jan 2016 20:29:59 -0500
Subject: Re: bug#20111: nice.1, renice.1 and nice.info : claims non-root user
 cannot decrease niceness
To: =?UTF-8?Q?St=c3=a9phane_Aulery?= <saulery@free.fr>, 20111@debbugs.gnu.org
References: <20150315183224.GA2415@free.fr>
Cc: util-linux <util-linux@vger.kernel.org>
From: =?UTF-8?Q?P=c3=a1draig_Brady?= <P@draigBrady.com>
Message-ID: <5689C8B0.40805@draigBrady.com>
Date: Mon, 4 Jan 2016 01:19:44 +0000
MIME-Version: 1.0
In-Reply-To: <20150315183224.GA2415@free.fr>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

tag 20111 notabug
close 20111
stop

coreutils nice docs don't mention the root user.
renice is implemented by util-linux so CCing there.

thanks,
Pádraig.

On 15/03/15 18:32, Stéphane Aulery wrote:
> Hello,
> 
> I had you followed a bug reported by a Ubuntu user [1] about "nice value" change:
> 
>    According to "man nice" and "info coreutils nice", it is
>    not possible for a non-root user to decrease the niceness
>    of a process (even if they were the ones that increased the
>    niceness). However this not the case in Ubuntu 9.04, as
>    evidenced by the fact that the attached script "stopfirefox"
>    can reduce the niceness back to 0 when firefox is unminimized.
>    The manpage and infopage should be modified in light of this,
>    and should also say where this was configured.
> 
>    According to
>    http://en.wikipedia.org/wiki/Nice_%28Unix%29#cite_note-0 This
>    can be configured in /etc/security/limits.conf, however this
>    does not seem to have any uncommented lines, so presumably
>    Ubuntu configured this somewhere else.
> 
>    ProblemType: Bug
>    Architecture: amd64
> 
>    DistroRelease: Ubuntu 9.04
>    NonfreeKernelModules: fglrx
>    PackageArchitecture: all
>    ProcEnviron:
>    SHELL=/bin/bash
>    PATH=(custom, user)
>    LANG=en_AU.UTF-8
>    Uname: Linux 2.6.28-14-generic x86_64
> 
> I think that add a reference to talk about /etc/security/limits.conf is
> a good idea.
> 
> [1] https://bugs.launchpad.net/ubuntu/+source/coreutils/+bug/468518
> 
> Regards,
> 

