Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.126.130]:64911 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621AbcDPVVA (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 16 Apr 2016 17:21:00 -0400
Subject: Re: [PATCH] Fail like the shell when execvp fails
To: Nir Soffer <nirsof@gmail.com>, util-linux@vger.kernel.org
References: <1460827912-19521-1-git-send-email-nsoffer@redhat.com>
Cc: Nir Soffer <nsoffer@redhat.com>
From: Bernhard Voelker <mail@bernhard-voelker.de>
Message-ID: <5712ACB2.7090103@bernhard-voelker.de>
Date: Sat, 16 Apr 2016 23:20:50 +0200
MIME-Version: 1.0
In-Reply-To: <1460827912-19521-1-git-send-email-nsoffer@redhat.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 04/16/2016 07:31 PM, Nir Soffer wrote:
> For example, running the fuser command via taskset when fuser command is
> not installed is failing now like this:
> 
>     $ taskset -c 1 fuser /path/to/file; echo $?
>     taskset: failed to execute fuser: No such file or directory
>     1
> 
> This failure looks like a real failure of the fuser command:
> 
>     $ taskset -c 1 fuser /path/to/file; echo $?
>     Specified filename /path/to/file does not exist.
>     1
> 
> Based on the exit code, a management program may do the wrong thing,
> leading to catastrophic results. Detecting such failure requires fragile
> parsing of standard error.
> 
> With this patch this failure is easy to detect:
> 
>     $ taskset -c 1 fuser /path/to/file; echo $?
>     taskset: failed to execute fuser: No such file or directory
>     127

TBH I don't like this idea; how would you see from the exit code
that 'taskset' itself wasn't the culprit?  I mean execve()ing
taskset worked, but that tool simply wasn't lucky to execve() the
secondary tool, well.  So EXIT_FAILURE is the right thing to do IMO,
and it is like that in almost any other - also non-util-linux tools
(chroot, nice, ...).  Therefore, I don't see much gain from changing
this here - not to mention the probable fallout for tools/script
relying on the previous EXIT_FAILURE.
Can you reference any general discussion about this?

Have a nice day,
Berny
