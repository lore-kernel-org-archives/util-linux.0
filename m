Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36501 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751162AbbDGK3k (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 7 Apr 2015 06:29:40 -0400
Date: Tue, 7 Apr 2015 12:29:21 +0200
From: Karel Zak <kzak@redhat.com>
To: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Cc: Fridolin Pokorny <fpokorny@redhat.com>,
        util-linux <util-linux@vger.kernel.org>,
        Bernhard Voelker <mail@bernhard-voelker.de>,
        bug-gnulib <bug-gnulib@gnu.org>, Coreutils <coreutils@gnu.org>,
        Dan Walsh <dwalsh@redhat.com>
Subject: Re: large overhead in libmount
Message-ID: <20150407102921.GH3923@ws.net.home>
References: <54A321DC.4020300@bernhard-voelker.de>
 <54BDB6E9.4070500@draigBrady.com>
 <20150402100546.GE2097@ws.net.home>
 <551D29C1.1010107@draigBrady.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <551D29C1.1010107@draigBrady.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Apr 02, 2015 at 12:36:33PM +0100, Pádraig Brady wrote:
> >> $ ldd src/du
> >> linux-vdso.so.1 =>  (0x00007fff76ca8000)
> >> libc.so.6 => /lib64/libc.so.6 (0x00007f2a1f742000)
> >> /lib64/ld-linux-x86-64.so.2 (0x00007f2a1fd61000)
> >>  libmount.so.1 => /lib64/libmount.so.1 (0x00007f2a1faff000)
> >>   libblkid.so.1 => /lib64/libblkid.so.1 (0x00007f2a1f501000)
> >>   libuuid.so.1 => /lib64/libuuid.so.1 (0x00007f2a1f2fc000)
> >>   libselinux.so.1 => /lib64/libselinux.so.1 (0x00007f2a1f0d7000)
> >>   libpcre.so.1 => /lib64/libpcre.so.1 (0x00007f2a1ee69000)
> >>   liblzma.so.5 => /lib64/liblzma.so.5 (0x00007f2a1ec44000)
> >>   libdl.so.2 => /lib64/libdl.so.2 (0x00007f2a1ea40000)
> >>   libpthread.so.0 => /lib64/libpthread.so.0 (0x00007f2a1e823000)
> > 
> > The problem is libselinux, but on selinux based system you have all the
> > libraries already in memory for many another tools...
> 
> Indeed.
> 
> I see libmount links with libselinux to use selinux_trans_to_raw_context()
> for the context= mount options etc.

The ideal solution would be to avoid this selinux context translation
at all. It would be nice to make it possible to send context= to kernel 
as specified on command line. Dan, any comment? (dwalsh added to CC:)

It's also painful that so generic (often used) library like selinux
has so many additional dependencies.

> I suppose one could split libmount
> to avoid that dependency, though it's probably not worth it for this case at least?

Well, I can create a fallback for this stuff and move the translation code to
mount(8) only... then libmount will be without the dependence.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
