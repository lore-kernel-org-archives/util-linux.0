Return-Path: util-linux-owner@vger.kernel.org
Received: from mailout07.t-online.de ([194.25.134.83]:50132 "EHLO
	mailout07.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877Ab3EIRN7 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 9 May 2013 13:13:59 -0400
Date: 09 May 2013 18:59:00 +0200
From: Hullen@t-online.de (Helmut Hullen)
To: util-linux@vger.kernel.org
Message-ID: <CWYcVs5uCXB@helmut.hullen.de>
In-Reply-To: <518BC86D.2050702@chinilu.com>
Subject: Re: umount and findmnt commands not working with btrfs labels ...
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: helmut@hullen.de
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hallo, George,

Du meintest am 09.05.13:

>>   Ah, do you mean btrfs raid? For example:
>>
>>     mkfs.btrfs --data raid1 --label FOO /dev/sdd1 /dev/sdd2
>>
>>   then the LABEL and UUID is really duplicate.

[...]

> It would be nice if btrfs would just lock all of these partitions out
> and represent them collectively to the broader system as /dev/mntX or
> whatever.

Perhaps you shouldn't use only "blkid" - sometimes I've seen strange  
answers (or no answer). I haven't yet found the system behind this  
behaviour.

        file -s /dev/sdd1

(p.e.) is more reliable.

But for mounting and unmounting I haven't seen any problem:

        mount LABEL=FOO /path/to/mountpoint

        umount LABEL=FOO

has always worked as expected; for existing devices and mountpoints and  
also for nonexisting devices and mountpoints.

By the way: my system doesn't use "udev"; working/addressing with LABEL  
works fine also without "udev".

And by another way:

        blkid

tells every btrfs disk/partition which is part of the btrfs cluster (in  
my installations: all 3 disks) - they have the same UUID but different  
UUID_SUBs. No real problem.

Viele Gruesse!
Helmut
