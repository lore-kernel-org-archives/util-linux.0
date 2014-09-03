Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:35314 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756170AbaICNaQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 3 Sep 2014 09:30:16 -0400
Message-ID: <1409751014.14709.24.camel@oct.suse.cz>
Subject: Re: umount of unreachable NFS without -f [maybe PATCH]
From: Stanislav Brabec <sbrabec@suse.cz>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Date: Wed, 03 Sep 2014 15:30:14 +0200
In-Reply-To: <20140903074517.GD21325@x2.net.home>
References: <1409684978.14709.15.camel@oct.suse.cz>
	 <20140903074517.GD21325@x2.net.home>
Content-Type: text/plain; charset="ISO-8859-2"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> On Tue, Sep 02, 2014 at 09:09:38PM +0200, Stanislav Brabec wrote:
> > I just analyzed causes of hang while calling umount without -f on an
> > unreachable NFS.
> > 
> > The first hang happens on in lookup_umount_fs():
> > 
> > stat(tgt, &st) == 0 && S_ISDIR(st.st_mode)
> > 
> > I don't exactly know, what its removal causes, but I tried it.
> > 
> > I entered into next hang in mnt_resolve_path() inside has_utab_entry().
> > We cannot prevent this hang in all cases, but preventing it in a
> > standard situation is pretty straightforward: Try to match provided
> > target name before trying to canonicalize.
> > 
> > Now my umount without -f works well at least in the case, when the mount
> > point is recorded in the utab.
> > 
> > If it is not recorded in utab, it still hangs later in
> > lookup_umount_fs() on:
> > 
> > if (statfs(tgt, &vfs) == 0)
> > 
> > Well, we can prevent even this hang, but it would be at cost of parsing
> > mtab. I read your git comments and I see, that the whole purpose of the
> > code is preventing of parsing of the generated mtab/mountinfo.
> > 
> > Would be parsing of fstab a safe way without paying this cost?
> 
> How often do you have NFS mounts without entry within utab? I think it's
> pretty unusual (I guess you have mount.nfs linked with libmount).

I did it somehow. Guessing that it could have something with my
experiments, killing hanging umount with signal 11 etc.

> The change in has_utab_entry() is definitely good idea, but I'm not
> sure about the rest. Maybe it would be enough to call has_utab_entry()
> before
> 
>     stat(tgt, &st) == 0 && S_ISDIR(st.st_mode)
> 
> 
> then it will be good enough for almost all NFS mounts (with utab
> entries).

Yes, I just verified that it helps as well.

But I found just another stat() call further in
mnt_context_find_umount_fs():
if (stat(tgt, &st) == 0 && S_ISDIR(st.st_mode)) {
before cache lookups.

And next there is:
cn_tgt = mnt_resolve_path(tgt, cache);
which will probably hang as well.

I can imagine that we will not uses stat() here, but I cannot imagine,
how to set filter correctly without canonicalization.

I am just curious why one of my umount attempts of unresponsive NFS
succeeded yesterday...

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76

