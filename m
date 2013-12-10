Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51257 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751141Ab3LJKcb (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 10 Dec 2013 05:32:31 -0500
Date: Tue, 10 Dec 2013 11:32:08 +0100
From: Karel Zak <kzak@redhat.com>
To: Nikos Skalkotos <skalkoto@grnet.gr>
Cc: util-linux@vger.kernel.org, synnefo-devel@googlegroups.com
Subject: Re: Support for the new OpenBSD disklabel format
Message-ID: <20131210103208.GA8419@x2.net.home>
References: <529CC1AE.9090006@grnet.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <529CC1AE.9090006@grnet.gr>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Dec 02, 2013 at 07:21:50PM +0200, Nikos Skalkotos wrote:
> Besides the python tool I've written, for a more permanent solution, I'm
> considering patching libfdisk to support the OpenBSD disklabel. I wanted
> to know if you are interested for those patches. I think the best way to
> do it is to split the disklabel parts that have changed into different
> structs and use unions to create a disklabel struct that will work both
> for NetBSD and OpenBSD. What do you think?

I'm just doing some invasive changes to the library -- it would be
probably better to wait to January to avoid some collisions and extra
work. 

We also have some very simple partitions table parser in libblkid
(see libblkid/src/partitions/, mostly dos.c for nested partition tables). It
would be nice to extend this partition table parser too.

Don't forget to send some test image with the new BSD disklabel! :-)

> If this works out, I'd be happy to create python bindings for libfdisk
> (like the ones you have for libmount) as a later step. I know that the
> API is not currently stable, but most parts seem OK.

It's probably too early, the API is not stable at all, maybe later in 
next year. 

Anyway, python binding is wanted -- we already have binding for
libmount, Ondrej promised binding for libblkid, so binding for
libfdisk would be excellent thing!

Now the library is good enough for dialogs driven interfaces (like
fdisk), but it's necessary to improve it for programs like cfdisk and
sfdisk. Now I'm working on new cfdisk.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
