Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53324 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750937AbaICHtT (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 3 Sep 2014 03:49:19 -0400
Date: Wed, 3 Sep 2014 09:49:15 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: umount of unreachable NFS without -f [maybe PATCH]
Message-ID: <20140903074915.GE21325@x2.net.home>
References: <1409684978.14709.15.camel@oct.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1409684978.14709.15.camel@oct.suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Sep 02, 2014 at 09:09:38PM +0200, Stanislav Brabec wrote:
> I just analyzed causes of hang while calling umount without -f on an
> unreachable NFS.
> 
> The first hang happens on in lookup_umount_fs():
> 
> stat(tgt, &st) == 0 && S_ISDIR(st.st_mode)
> 
> I don't exactly know, what its removal causes, but I tried it.

The stat() is there to detect situations when someone calls

  umount /dev/sda1

then you don't want to call statfs() to get fs type, because the
device is not a mountpoint. Note that statfs() works with arbitrary
file, so we have to be careful...

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
