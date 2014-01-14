Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qa0-f50.google.com ([209.85.216.50]:61414 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746AbaANOxo (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 14 Jan 2014 09:53:44 -0500
Received: by mail-qa0-f50.google.com with SMTP id cm18so6478366qab.9
        for <util-linux@vger.kernel.org>; Tue, 14 Jan 2014 06:53:44 -0800 (PST)
Date: Tue, 14 Jan 2014 09:53:42 -0500 (EST)
From: Scott Moser <smoser@ubuntu.com>
To: Phillip Susi <psusi@ubuntu.com>
cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH] fix partx --update ranges and out of order tables
In-Reply-To: <52D54D09.10506@ubuntu.com>
Message-ID: <alpine.DEB.2.02.1401140952480.5329@brickies>
References: <alpine.DEB.2.02.1401131526340.5329@brickies> <20140114085439.GF12700@x2.net.home> <52D54D09.10506@ubuntu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, 14 Jan 2014, Phillip Susi wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> > +blkid_partition get_partition_by_partno(blkid_partlist ls, int n)
>
> I was wondering why libblkid didn't already have a function like this,
> should this be moved there instead of just being in partx.c?

I figured I'd leave that up to upstream.
I had an implementation of that, but didn't know of the policy for adding
stuff to libblkid.  This was less invasive.  I'm fine with libblkid also.

Scott
