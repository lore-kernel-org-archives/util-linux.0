Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36314 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751381AbcCNQ3u (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Mar 2016 12:29:50 -0400
Date: Mon, 14 Mar 2016 17:29:47 +0100
From: Karel Zak <kzak@redhat.com>
To: George Spelvin <linux@horizon.com>
Cc: util-linux@vger.kernel.org
Subject: Re: e2fsck: /dev/hda2 is mounted.
Message-ID: <20160314162947.22odxuup5lij7mz6@ws.net.home>
References: <20160313101414.19038.qmail@ns.horizon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160313101414.19038.qmail@ns.horizon.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Mar 13, 2016 at 06:14:14AM -0400, George Spelvin wrote:
> 32305: libmount:      TAB: [0x983a160]: /proc/self/mountinfo: start parsing [entries=0, filter=not]
> 32305: libmount:      TAB: [0x983a160]: add entry: /dev/root /
> 32305: libmount:    CACHE: canonicalize path /proc/self/mountinfo
> 32305: libmount:      TAB: TID for /proc/self/mountinfo is 32305
> 32305: libmount:      TAB: [0x983a160]: root FS: 302
> 32305: libmount:    CACHE: [0x983a048]: canonicalize path 302
> 32305: libmount:    CACHE: [0x983a048]: add entry [ 3] (path): 302: 302
> 32305: libmount:      TAB: [0x983a160]: canonical root FS: 302
> 32305: libmount:      TAB: [0x983a160]: add entry: sysfs /sys
> 32305: libmount:      TAB: [0x983a160]: add entry: tmpfs /run
> 32305: libmount:      TAB: [0x983a160]: add entry: tmpfs /run/lock
> 32305: libmount:      TAB: [0x983a160]: add entry: proc /proc
> 32305: libmount:      TAB: [0x983a160]: add entry: devtmpfs /dev
> 32305: libmount:      TAB: [0x983a160]: add entry: tmpfs /run/shm
> 32305: libmount:      TAB: [0x983a160]: add entry: devpts /dev/pts
> 32305: libmount:      TAB: [0x983a160]: add entry: tmpfs /tmp
> 32305: libmount:      TAB: [0x983a160]: add entry: /dev/hda3 /home
> 32305: libmount:       FS: [0x983ddc8]: free [refcount=0]
> 32305: libmount:      TAB: [0x983a160]: /proc/self/mountinfo: stop parsing (10 entries)
> 32305: libmount:      TAB: [0x983a160]: parsing done [filename=/proc/self/mountinfo, rc=0]
> 32305: libmount:      TAB: [0x983a160]: mtab parse: #2 read utab
> 32305: libmount:      TAB: [0x983a160]: lookup SOURCE: '/dev/hda2'
> 32305: libmount:      TAB: [0x983a160]: lookup SRCPATH: '/dev/hda2'
> 32305: libmount:      TAB: [0x983a160]: lookup canonical SRCPATH: '/dev/hda2'
> /dev/hda2 is not mounted

 Can you send me your /proc/self/mountinfo? (or at least root fs entry
 from the file)

 Thanks,
    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
