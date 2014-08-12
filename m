Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:46268 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754021AbaHLUPd (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 12 Aug 2014 16:15:33 -0400
Message-ID: <1407874531.5984.79.camel@oct.suse.cz>
Subject: Re: util-linux and distro bootstrap, dependencies and build cycles
From: Stanislav Brabec <sbrabec@suse.cz>
To: Mike Frysinger <vapier@gentoo.org>
Cc: util-linux@vger.kernel.org
Date: Tue, 12 Aug 2014 22:15:31 +0200
In-Reply-To: <1549603.ZWLTNRFnAF@vapier>
References: <1407768431.5984.23.camel@oct.suse.cz>
	 <1549603.ZWLTNRFnAF@vapier>
Content-Type: text/plain; charset="ISO-8859-2"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Mike Frysinger wrote:
> On Mon 11 Aug 2014 16:47:11 Stanislav Brabec wrote:
> > Solution 1:
> > 
> > Modify make system by adding:
> > --enable-build-stage-1: Distro bootstrap stage 1: Build only code
> >     without systemd and python dependencies.
> > --enable-build-stage-2: Distro bootstrap stage 2: Build code with
> >     systemd dependencies (even if they are optional). Use installed
> >     instances of libmount, libblkid, libsmartcols and libuuidd, do not
> >     build them in-tree.
> > --enable-build-stage-3: Distro bootstrap stage 3: Build python-libmount
> >     only. Use installed instance of libmount, do not build them in-tree.
> 
> how is this any different from just passing --without-{udev,python} ?

--without-systemd still builds the same set of binaries, just without
support of systemd. It does not allow to exclude lslogins, logger and
uuidd and build them later.

--with-python builds complete util-linux and libraries plus python
bindings, not bindings only.

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

