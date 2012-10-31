Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-bk0-f46.google.com ([209.85.214.46]:51958 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932558Ab2JaMrF (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 31 Oct 2012 08:47:05 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so630857bkc.19
        for <util-linux@vger.kernel.org>; Wed, 31 Oct 2012 05:47:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20121031122453.GB27908@x2>
References: <1351638239.1651.13.camel@kyoto.localdomain> <20121031122453.GB27908@x2>
From: Kay Sievers <kay@vrfy.org>
Date: Wed, 31 Oct 2012 13:46:43 +0100
Message-ID: <CAPXgP1092MT36BonZtqMpxR0dFWPeYwPFH4oCHDEgy3X2r9ozA@mail.gmail.com>
Subject: Re: Discrepancies between real and symlinked mtab
To: Karel Zak <kzak@redhat.com>
Cc: Matt Burgess <matthew@linuxfromscratch.org>, util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Oct 31, 2012 at 1:24 PM, Karel Zak <kzak@redhat.com> wrote:
> On Tue, Oct 30, 2012 at 11:03:59PM +0000, Matt Burgess wrote:

>> 1) mount(8)
>>
>> /dev/root on / type ext3 (rw,relatime,data=ordered)
>
>  I see (Fedora 17, util-linux 2.21.2)

>    /dev/sda4 on / type ext4 (rw,relatime,data=ordered)

We see that only if we use an initramfs. In case the kernel mounts the
fs directly and internally, there is /dev/root showing up.

>> Nope, that's not /dev/sda3.  And what is /dev/root anyway? There's no
>> such node under /dev here.

The kernel creates that node in its own 'rootfs' names filesystem, the
parent of the entire filesystem mount tree; but this is never visible
anywhere in the real system, and never was.

Ideally, the kernel would be fixed to use the root= string, and not
invent a name that does never exist.

> if I good remember there was symlink in some distributions

Some distributions created /dev/root with udev rules which have been
composed at bootup. We dropped all that, because it is logic backwards
and nothing on the system should rely on /dev/root being available.
Modern filesystems like btrfs do not follow the "there is a single
device below that mountpoint logic".

Kay
