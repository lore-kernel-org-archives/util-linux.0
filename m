Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:28070 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751471AbaHMJ1D (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 13 Aug 2014 05:27:03 -0400
Date: Wed, 13 Aug 2014 11:26:55 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: Mike Frysinger <vapier@gentoo.org>, util-linux@vger.kernel.org
Subject: Re: util-linux and distro bootstrap, dependencies and build cycles
Message-ID: <20140813092655.GN17719@x2.net.home>
References: <1407768431.5984.23.camel@oct.suse.cz>
 <1549603.ZWLTNRFnAF@vapier>
 <1407874531.5984.79.camel@oct.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1407874531.5984.79.camel@oct.suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 12, 2014 at 10:15:31PM +0200, Stanislav Brabec wrote:
> Mike Frysinger wrote:
> > On Mon 11 Aug 2014 16:47:11 Stanislav Brabec wrote:
> > > Solution 1:
> > > 
> > > Modify make system by adding:
> > > --enable-build-stage-1: Distro bootstrap stage 1: Build only code
> > >     without systemd and python dependencies.
> > > --enable-build-stage-2: Distro bootstrap stage 2: Build code with
> > >     systemd dependencies (even if they are optional). Use installed
> > >     instances of libmount, libblkid, libsmartcols and libuuidd, do not
> > >     build them in-tree.
> > > --enable-build-stage-3: Distro bootstrap stage 3: Build python-libmount
> > >     only. Use installed instance of libmount, do not build them in-tree.
> > 
> > how is this any different from just passing --without-{udev,python} ?
> 
> --without-systemd still builds the same set of binaries, just without
> support of systemd. It does not allow to exclude lslogins, logger and
> uuidd and build them later.

 then you need --disable-lslogins --disable-logger ..etc.

 If any --disable-* is missing (it's currently not defined for all
 utils) then we can improve configure.ac and the the new option.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
