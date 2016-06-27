Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lf0-f42.google.com ([209.85.215.42]:33807 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbcF0Npt (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 27 Jun 2016 09:45:49 -0400
Received: by mail-lf0-f42.google.com with SMTP id h129so156889958lfh.1
        for <util-linux@vger.kernel.org>; Mon, 27 Jun 2016 06:45:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160624091914.ekiska2x77n2euqu@ws.net.home>
References: <CACTTzNa3aTiCrHBQrvwVvFwLQpTdGTDLGt+G3wycpMXEzXbXcw@mail.gmail.com>
 <20160624091914.ekiska2x77n2euqu@ws.net.home>
From: Yigal Korman <yigal@plexistor.com>
Date: Mon, 27 Jun 2016 16:45:28 +0300
Message-ID: <CACTTzNamH7-Zy4HaoKomwfBQC5zGe4O8GvuEn2KUMDPinaTL+A@mail.gmail.com>
Subject: Re: blkid partition infomartion
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jun 24, 2016 at 12:19 PM, Karel Zak <kzak@redhat.com> wrote:
> On Tue, Jun 21, 2016 at 04:59:39PM +0300, Yigal Korman wrote:
>> I have a question regarding this patch in util-linux:
>> "blkid: don't ignore info about partitions on non-formated devices"
>> (commit f8098e2b2c0a8a98ccb603f53dfba0cc05683a39)
>>
>> I wanted to know what was the trigger for this change? what's the reasoning
>> behind it?
>
> I guess inconsistency with man page:
>
>   Note that low-level probing also returns information about partition
>   table type (PTTYPE tag) and partitions (PART_ENTRY_* tags).

Huh, interesting, I didn't notice that.

>
> .. and I'm not able to found if someone complained on mailing list.
>
>> Background:
>> I have an Linux automation script that formats a given partition and mounts
>> it.
>> In order to verify that the partition is empty (ie no other data exists
>> there) I've been using 'blkid -p <partition>;  [[ $? != 2 ]] && fail".
>> Which stopped working correctly when I moved to Ubuntu 16.04.
>> I've tracked the issue to the patch mentioned above.
>>
>> To me this patch seems to counter blkid behavior - returning the partition
>> information when the given device is the partition doesn't describe what
>> the device contains.
>
> Yes, the patch seems pretty controversial. I'll think about revert.
>
>> The same way that if /dev/sda is part of LVM, then 'blkid -p /dev/sda' will
>> return the LVM information, but doing 'blkid -p /dev/mapper/vg-lv' will
>> return what's inside the logical volume and not the logical volume
>> information (and nothing if the empty).
>>
>> Do you have a suggestion for a different method for testing if a device is
>> empty?
>
>  lsblk -n -o FSTYPE /dev/sda1

This doesn't return a different exit code when nothing is found, but
checking the output would work.
I went with a similar solution of checking the output of blkid:
blkid -p /dev/sda1 | grep -qw TYPE && echo "device is not empty"

Thanks!

>
> --
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
