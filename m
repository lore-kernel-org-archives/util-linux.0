Return-Path: util-linux-owner@vger.kernel.org
Received: from out02.mta.xmission.com ([166.70.13.232]:55960 "EHLO
	out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495Ab3AUArr convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 20 Jan 2013 19:47:47 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Cc: util-linux@vger.kernel.org
References: <20130120233621.GI17370@in.waw.pl>
Date: Sun, 20 Jan 2013 16:47:32 -0800
In-Reply-To: <20130120233621.GI17370@in.waw.pl> ("Zbigniew
	\=\?utf-8\?Q\?J\=C4\=99drzejewski-Szmek\=22's\?\= message of "Mon, 21 Jan 2013
 00:36:22 +0100")
Message-ID: <87k3r7l5uj.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: Re: is one allowed to reenter a user namespace?
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Zbigniew Jędrzejewski-Szmek <zbyszek@in.waw.pl> writes:

> Hi,
> when trying to enter a namespace, the behaviour wrt. to entering an
> existing namespace that the process is _already_ a part of is
> different for user names and all other namespaces. For user namespaces
> one gets EINVAL, while for other namespaces it succeeds. In other
> words, for user namespaces only, entering the namspace is not idempotent.
>
> # unshare --mount sleep 10000 &
>
> # nsenter --target=$(pgrep sleep) --mount /bin/true
> # nsenter --target=$(pgrep sleep) --ipc /bin/true
> # nsenter --target=$(pgrep sleep) --net /bin/true
> # nsenter --target=$(pgrep sleep) --uts /bin/true
> # nsenter --target=$(pgrep sleep) --user /bin/true
> nsenter: setns of 'ns/user' failed: Invalid argument
> (and the EINVAL is from setns())
>
> Is this difference intended?

Yes.

The definition of setns on a user namespace is that the process gains
all capabilities in that namespace.  As such if you could reenter your
current user namespace you would gain all capabilities which would
defeat the purpose of the capability bits.

Eric
