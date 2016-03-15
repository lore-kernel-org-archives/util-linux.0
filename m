Return-Path: linux@horizon.com
Date: 15 Mar 2016 15:12:05 -0400
Message-ID: <20160315191205.10399.qmail@ns.horizon.com>
From: "George Spelvin" <linux@horizon.com>
To: kzak@redhat.com, sweet_f_a@gmx.de
Subject: Re: e2fsck: /dev/hda2 is mounted.
Cc: linux@horizon.com, util-linux@vger.kernel.org
In-Reply-To: <20160315092604.fhvvwmk5luqdrkhm@ws.net.home>
List-ID: <util-linux.vger.kernel.org>

> The problem in this case is /dev/root, libmount tries to convert it to
> the real device name by root= command line option, but the conversion
> is pretty poor and it does not support all relevant use-cases. 

Yes, that is a bit annoying.  It also breaks e4defrag.  I have a kludgey
script on my systems that parses /etc/fstab and creates a /dev/root
symlink, but of course there's no guarantee that fstab matches
the kernel root= command line.

If you feel like creating a makedevroot(8) utility (which creates a
symlink if it can, or a device node if it can't), I suspect it would
be appreciated.
