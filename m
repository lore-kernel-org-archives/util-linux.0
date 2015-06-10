Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qg0-f54.google.com ([209.85.192.54]:35135 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964792AbbFJHX5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 10 Jun 2015 03:23:57 -0400
Received: by qgg3 with SMTP id 3so13292650qgg.2
        for <util-linux@vger.kernel.org>; Wed, 10 Jun 2015 00:23:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAGnHSEksSynfOvBMuPAMdFxgdip8=wfUFKhVM5ZeYjiP7x102w@mail.gmail.com>
References: <CAGnHSEksSynfOvBMuPAMdFxgdip8=wfUFKhVM5ZeYjiP7x102w@mail.gmail.com>
Date: Wed, 10 Jun 2015 15:23:56 +0800
Message-ID: <CAGnHSEmnn5z-=x4V6dkh1hK3Gq2_v2Hn9HxqT4rC5n1fGAdkbA@mail.gmail.com>
Subject: Re: making `blkid -lt NAME=value -o device` equivalent to `findfs`
 for PART{UUID,LABEL}
From: Tom Yan <tom.ty89@gmail.com>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

By the way, according to the blkid(8):

       -l     Look up only one device that matches the search
parameter specified with the -t option.  If there are multiple devices
that match the specified search parameter,  then  the  device  with
the
              highest  priority  is  returned,  and/or the first
device found at a given priority...

However, as you can see in my last email, blkid_evaluate_tag() doesn't
seem to return the first device. Only `blkid -lt PARTLABEL="EFI
System" -o device`, which doesn't use the function, output the
"/dev/sda1".

On 10 June 2015 at 14:38, Tom Yan <tom.ty89@gmail.com> wrote:
> In commit c48508c2, findfs was given ability to work with PARTUUID and
> PARTLABEL. It works on all four types with blkid_evaluate_tag().
>
> When blkid is run in form of `blkid -lt NAME=value -o device` for UUID
> and LABEL, it works the same way as findfs:
>
>     /* convert LABEL/UUID lookup to evaluate request */
>     if (lookup && output_format == OUTPUT_DEVICE_ONLY && search_type &&
>         (!strcmp(search_type, "LABEL") || !strcmp(search_type, "UUID"))) {
>         eval++;
>         lookup = 0;
>     }
>
> but not always for PARTUUID and PARTLABEL.
>
> Would it be a good idea to add them in the test as well, so that
> `findfs` can be considered an equivalence/shortcut as blkid in that
> form?
>
> [tom@localhost ~]$ blkid -t PARTLABEL="EFI System" -o device
> /dev/sda1
> /dev/sdb1
> [tom@localhost ~]$ blkid -t LABEL=TEST -o device
> /dev/sda1
> /dev/sdb1
> [tom@localhost ~]$ blkid -lt PARTLABEL="EFI System" -o device
> /dev/sda1
> [tom@localhost ~]$ findfs PARTLABEL="EFI System"
> /dev/sdb1
> [tom@localhost ~]$ blkid -lt LABEL=TEST -o device
> /dev/sdb1
> [tom@localhost ~]$ findfs LABEL=TEST
> /dev/sdb1
