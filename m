Return-Path: util-linux-owner@vger.kernel.org
Received: from out03.mta.xmission.com ([166.70.13.233]:52021 "EHLO
	out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949AbaLQXXz (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 17 Dec 2014 18:23:55 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: <util-linux@vger.kernel.org>
Cc: Karel Zak <kzak@redhat.com>, Lubomir Rintel <lkundrak@v3.sk>
References: <87zjalkhb8.fsf@x220.int.ebiederm.org>
Date: Wed, 17 Dec 2014 17:21:31 -0600
In-Reply-To: <87zjalkhb8.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
	message of "Wed, 17 Dec 2014 17:06:03 -0600")
Message-ID: <87sigdkglg.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [RFC][PATCH] unshare: Fix --map-root-user to work on new kernels
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

ebiederm@xmission.com (Eric W. Biederman) writes:

> I have just merged a security fix into the linux kernel that corrects an
> oversight in the permission checks of /proc/self/gid_map.
>
> The root of the issue is that unix allows anyone to specify permissions
> such like: --rwx---rwx on a file, and setgroups call at login time
> allows seting groups that even setgid exectuables don't drop.  Which
> results in the ability to assign a process fewer privileges just because
> it is in a specified group, and this makes dropping groups an unsafe
> operation.
>
> Therefore unprivileged writing of /proc/self/gid_map has been disabled
> unless /proc/self/setgroups is written first to permanently disable the
> ability to call setgroups in that user namespace.
>
> In part this design was chosen so that applications that are affected
> will break early instead of late, and in part to make it clear to
> everyone what is going on.
>
> I think for the experimental tool that is unshare --make-root-user we
> just want to flip the bit and be done with it (patch below).
>
> However we may want to require an additional option to clear setgroups,
> if there loging type applications running that call setgroups and having
> explicit breakage up front instead of more silent stealthy breakage
> when the application runs is desired.
>
> If we don't want any extra options working tested code is below.

This may also have some affect on the setgroups(0, NULL) case of
nsenter as well.

Eric
