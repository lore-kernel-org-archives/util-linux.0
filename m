Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f171.google.com ([209.85.192.171]:34454 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbbDBR2A (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 2 Apr 2015 13:28:00 -0400
Received: by pdbni2 with SMTP id ni2so95659934pdb.1
        for <util-linux@vger.kernel.org>; Thu, 02 Apr 2015 10:27:59 -0700 (PDT)
Date: Thu, 2 Apr 2015 10:28:01 -0700
From: Isaac Dunham <ibid.ag@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org
Subject: Re: question about hardcoded binary paths (swapon / mkswap)
Message-ID: <20150402172800.GA1798@newbook>
References: <201504011342.56546.sweet_f_a@gmx.de>
 <201504011817.48428.sweet_f_a@gmx.de>
 <20150401201051.GP25224@vapier>
 <201504012306.52737.sweet_f_a@gmx.de>
 <20150401213800.GB2097@ws.net.home>
 <20150402011230.GA22171@vapier>
 <20150402082000.GC2097@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150402082000.GC2097@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Apr 02, 2015 at 10:20:00AM +0200, Karel Zak wrote:
> On Wed, Apr 01, 2015 at 09:12:30PM -0400, Mike Frysinger wrote:
> > neither tool is set*id, 
> > and mkfs/fsck generally live in /sbin.  i guess if you're non-root and have 
> > /sbin/mkfs hardcoded in a script, then dropping FS_SEARCH_PATH might break 
> > existing code.
> 
> for systemd based distors the path should be also modified, we have
> all in /usr and /sbin and /bin are symlinks only.

(1) mkfs/fsck can be used on files that can be loopback mounted; I've 
used mkfs.*fs directly, but it may be desireable to support using 
mkfs -t as a user for creating filesystems on regular files.

(2) the /usr merge may be prevalent on RPM-based distros, but Debian does
not use it; I would assume that if they decided to support it, there would
be 2 releases before you could require it.
Additionally, the /sbin and /bin symlinks are there precisely because the
LSB requires certain commands to be in /bin and /sbin so that binaries
and scripts can rely on the paths. Ignoring this will cause needless
incompatability.

Thanks,
Isaac Dunham
