Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qc0-f182.google.com ([209.85.216.182]:33154 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518AbbFPFmy (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 16 Jun 2015 01:42:54 -0400
Received: by qcbfz6 with SMTP id fz6so1612330qcb.0
        for <util-linux@vger.kernel.org>; Mon, 15 Jun 2015 22:42:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150615112827.GS1992@ws.net.home>
References: <CA+X5Wn71btX_teX7AF-RJjo_2te5_VEZABAQSa6uWuYCtna1+g@mail.gmail.com>
	<20150615112827.GS1992@ws.net.home>
Date: Tue, 16 Jun 2015 13:42:54 +0800
Message-ID: <CAGnHSEntiMk3f1PPLj8RUJU+T0EeVP0-KqsVLwVWpPVPkzgDhQ@mail.gmail.com>
Subject: Re: Mount doesn't show subvol option for btrfs
From: Tom Yan <tom.ty89@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: james harvey <jamespharvey20@gmail.com>, util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

[tom@localhost ~]$ mount | grep sda2
/dev/sda2 on / type btrfs (rw,relatime,ssd,space_cache)

[tom@localhost ~]$ cat /proc/self/mountinfo | grep sda2
19 0 0:17 /arch / rw,relatime shared:1 - btrfs /dev/sda2 rw,ssd,space_cache

[tom@localhost ~]$ findmnt /dev/sda2
TARGET SOURCE           FSTYPE OPTIONS
/      /dev/sda2[/arch] btrfs  rw,relatime,ssd,space_cache

It won't be shown as a mount option.

On 15 June 2015 at 19:28, Karel Zak <kzak@redhat.com> wrote:
> On Sun, Jun 14, 2015 at 04:50:09PM -0400, james harvey wrote:
>> Not sure if this could be a linux-unionfs (btrfs) bug instead...
>>
>> On arch, /etc/fstab includes:
>>
>> /dev/sda1   /.snapshots   btrfs
>> rw,noatime,compress=lzo,ssd,discard,space_cache,subvol=.snapshots   0
>>  0
>>
>> But mount includes:
>>
>> /dev/sda1 on /.snapshots type btrfs
>> (rw,noatime,compress=lzo,ssd,discard,space_cache)
>>
>> The subvol option isn't reported in mount.
>
>
>  mount(8) uses /proc/self/mountinfo as source, do you see the subvol=
>  mount option there?
>
>  (well, I guess you have system without mtab and recent util-linux.)
>
>     Karel
>
> --
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
