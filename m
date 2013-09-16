Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f49.google.com ([74.125.83.49]:46260 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752311Ab3IPKKs (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 16 Sep 2013 06:10:48 -0400
Received: by mail-ee0-f49.google.com with SMTP id d41so1881154eek.22
        for <util-linux@vger.kernel.org>; Mon, 16 Sep 2013 03:10:47 -0700 (PDT)
Message-ID: <5236D921.9040400@gmail.com>
Date: Mon, 16 Sep 2013 12:10:41 +0200
From: Gabriel de Perthuis <g2p.code@gmail.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: Rolf Fokkens <rolf@rolffokkens.nl>, util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] libblkid: Abort after an incorrect checksum
References: <1378491089-1135-1-git-send-email-g2p.code@gmail.com> <1378491089-1135-2-git-send-email-g2p.code@gmail.com> <523487DC.1070704@gmail.com> <20130916082413.GA6752@x2.net.home>
In-Reply-To: <20130916082413.GA6752@x2.net.home>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Le lun. 16 sept. 2013 10:24:13 CEST, Karel Zak a écrit :
> On Sat, Sep 14, 2013 at 05:59:24PM +0200, Gabriel de Perthuis wrote:
>>> Log incorrect checksums and stop the superblock probing loop when
>>> one is encountered.
>>> This is to avoid exposing backend devices that are supposed
>>> to be used through a stacked device (like raid or bcache).
>>
>> Sorry, but some of the changes you made when applying break the patch.
>> The intent is to stop the probing loop when a bad container is encountered;
>> the contents shouldn't be scanned.
>
>  Why? This is unwanted behaviour. If there is incomplete (broken)
>  superblock we continue with probing to check for another superblock.
>  This is very basic libblkid feature.

No result is always safer than an incorrect one.  Why bother
giving containers higher priority if that order can be broken.

>  It's pretty common that there is old obsolete superblock, but user
>  expects a new superblock after mkfs. Unfortunately not all mkfs-like
>  programs wipe devices.

Neither did make-bcache until two weeks ago.

>  Do you think that the content in the bad bcache could be interpreted
>  as regular filesystem? I don't think so.

Yes, that's what I want to avoid.  Some lower-priority superblocks are
at the end of the device.  And make-bcache didn't wipe existing devices,
so any type of superblock can be exposed.

If you're going to verify checksums for more containers (so far there's
just bcache, lvm and two raid types), you'll risk exposing desynced data
for those too.
