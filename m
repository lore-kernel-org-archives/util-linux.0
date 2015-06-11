Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33672 "EHLO
	mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567AbbFKB4z (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 10 Jun 2015 21:56:55 -0400
Received: by qkca135 with SMTP id a135so7633542qkc.0
        for <util-linux@vger.kernel.org>; Wed, 10 Jun 2015 18:56:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150610135122.GO1992@ws.net.home>
References: <CAGnHSEksSynfOvBMuPAMdFxgdip8=wfUFKhVM5ZeYjiP7x102w@mail.gmail.com>
	<CAGnHSEmnn5z-=x4V6dkh1hK3Gq2_v2Hn9HxqT4rC5n1fGAdkbA@mail.gmail.com>
	<20150610102542.GJ1992@ws.net.home>
	<CAGnHSEmBvpGt1RzqBWmNHpbTFSg-JcQ7yxfb754gM5AGaC+H-Q@mail.gmail.com>
	<20150610135122.GO1992@ws.net.home>
Date: Thu, 11 Jun 2015 09:56:55 +0800
Message-ID: <CAGnHSEnsb25AjVnd=ovVeJhmAXX_8d=sg3txUjyqV7Smm1Cq2g@mail.gmail.com>
Subject: Re: making `blkid -lt NAME=value -o device` equivalent to `findfs`
 for PART{UUID,LABEL}
From: Tom Yan <tom.ty89@gmail.com>
To: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I seldom use blkid myself. Honestly it's pretty unreliable and stupid
to me because for some reason it needs to be run as root. But as
non-root users you can see what was cached (which won't be everything,
so you will see extra things with root and miss those as users). Yet
when you need to update the cache you need to be root again (probably
because of /run permission).

[tom@localhost ~]$ sudo blkid
/dev/sda1: SEC_TYPE="msdos" UUID="F369-DF93" TYPE="vfat"
PARTLABEL="EFI System" PARTUUID="8ba616b7-cbef-4e72-a927-16f0fdcbc850"
/dev/sda2: UUID="c47a3e43-fed6-4f8a-8e52-71bae7a9f893"
UUID_SUB="4f6e7fdb-ff45-46a5-93f5-543faee64fbd" TYPE="btrfs"
PARTLABEL="Linux x86-64 root (/)"
PARTUUID="1137bb93-6615-440d-81f6-0f4008aa713a"
/dev/sdc: PTUUID="9e548c5a-4523-4646-a315-273e6971dbcf" PTTYPE="gpt"

[tom@localhost ~]$ blkid
/dev/sda1: SEC_TYPE="msdos" UUID="F369-DF93" TYPE="vfat"
PARTLABEL="EFI System" PARTUUID="8ba616b7-cbef-4e72-a927-16f0fdcbc850"
/dev/sda2: UUID="c47a3e43-fed6-4f8a-8e52-71bae7a9f893"
UUID_SUB="4f6e7fdb-ff45-46a5-93f5-543faee64fbd" TYPE="btrfs"
PARTLABEL="Linux x86-64 root (/)"
PARTUUID="1137bb93-6615-440d-81f6-0f4008aa713a"

[tom@localhost ~]$ cat /run/blkid/blkid.tab
<device DEVNO="0x0801" TIME="1433986914.92694" SEC_TYPE="msdos"
UUID="F369-DF93" TYPE="vfat" PARTLABEL="EFI System"
PARTUUID="8ba616b7-cbef-4e72-a927-16f0fdcbc850">/dev/sda1</device>
<device DEVNO="0x0802" TIME="1433986914.93432"
UUID="c47a3e43-fed6-4f8a-8e52-71bae7a9f893"
UUID_SUB="4f6e7fdb-ff45-46a5-93f5-543faee64fbd" TYPE="btrfs"
PARTLABEL="Linux x86-64 root (/)"
PARTUUID="1137bb93-6615-440d-81f6-0f4008aa713a">/dev/sda2</device>

And I don't see the purpose of caching things like this as well.
Perhaps it's because scanning was slow in old times?

However, I don't think lsblk is a "drop-in replacement" for blkid.
It's just a different tool which do things which is a bit similar. For
one I don't see how `blkid -lt` can be done with `lsblk` (unless you
use it with awk or something).

Anyway. I just wanna know whether blkid_evaluate_tag() has a mechanism
to pick a device when there's more than one result?

P.S. oops I forgot to send to the mailing list as well.

On 10 June 2015 at 21:51, Karel Zak <kzak@redhat.com> wrote:
> On Wed, Jun 10, 2015 at 07:42:15PM +0800, Tom Yan wrote:
>> I don't really understand why blkid was made to use a different
>> function/api for UUID/LABEL in that form, so it seems reasonable to me
>
>  history? ... many many years and many flames between the original
>  blkid code and udev based blkid_evaluate_tag() :-) The evaluate API
>  has been added to avoid blkid scan (and cache) and to use udev db as
>  primary source for mount(8) etc.
>
>  You can configure blkid_evaluate_tag() to use "EVALUATE=scan" than it
>  will follow the traditional blkid way.
>
>> to remove that on itself. As for the reason I asked to add strcmp for
>> PART{UUID,LABEL}, it is because I feel like it will be nice if
>> `findfs` behaves exactly the same as `blkid -lt (PART){UUID,LABEL} -o
>> device` form so that we can consider it as a shortcut, otherwise it
>> would either seem redundunt or unreliable because they basically does
>> exactly the same thing, but could give different results if more than
>> one device match.
>
>  Yes, I understand ... the stupid thing on the shortcut is that it
>  also depends on output format, so if you remove "-o device" then you get a
>  different result (in your case with duplicate PARTLABEL=). This is
>  reason why I have suggested to remove the shortcut and describe all
>  the things in the man page.
>
>  I don't know, I have to think about it a little :-)
>
>  Frankly, the original way how blkid cache sets priority is more and
>  more obsolete as more and more things in the system uses udev db.
>  Some people hate it, but it's reality. This is reason why I'm
>  recommending lsblk(8) rather than blkid(8).
>
>     Karel
>
> --
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
