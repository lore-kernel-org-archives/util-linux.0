Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49938 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751498Ab2AWNBJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 23 Jan 2012 08:01:09 -0500
Date: Mon, 23 Jan 2012 22:01:04 +0900 (JST)
Message-Id: <20120123.220104.765712748855204042.yamato@redhat.com>
To: kzak@redhat.com
Cc: kay.sievers@vrfy.org, rleigh@codelibre.net, util-linux@vger.kernel.org
Subject: Re: /etc/fstab.d yes or not
From: Masatake YAMATO <yamato@redhat.com>
In-Reply-To: <20120123122115.GA29250@x2.net.home>
References: <20120120162220.GN8797@codelibre.net>
	<CAPXgP11pvch92n1=mMfDsMLoGZMG8xq0e1juXyUO6mxFR6_GYg@mail.gmail.com>
	<20120123122115.GA29250@x2.net.home>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, 23 Jan 2012 13:21:15 +0100, Karel Zak <kzak@redhat.com> wrote
> On Fri, Jan 20, 2012 at 06:59:47PM +0100, Kay Sievers wrote:
>> > Inventing custom file formats for these (as is the current situation)
>> > is both opaque to the admin and less amenable to preservation/upgrading
>> > of the admins customisations and the defaults.
>> 
>> I'm not talking about custom file formats, better just add a mount -c,
>> and do mount -c /etc/kernelfs.d/*.conf, or whatever will fit systemv
>> needs.
> 
>  This is planned (I talked about it on dracut list few months ago). It
>  means:
> 
>     mount --fstab=<path> /mountpoint
> 
>  to override the default /etc/fstab path. The <path> could be also a
>  directory. So you can maintain our mountpoints in multiple files and
>  mount(8) will be able to search in the files if --fstab=<path> is
>  explicitly specified. I think this should be enough for initramfs
>  scripts.
> 
>  The problem is that the configuration won't be visible if
>  --fstab is not specified -- this is possible to resolve probably
>  by regular /etc/fstab.d only ;-)
> 
>> This is nothing really to share between systemd and systemv here. This
>> problem just does not exist for systemd.
> 
>  Well, Masatake has RHEL customers who want to deploy systems with
>  rpm/yum, %post scripts are poor solution because it's not too
>  reliable and verification with rpm -V doesn't work. Do we have any
>  answer for this use case?
> 
>     Karel

The question is not for me but I had thought about it in this weekend.
(Now I understand well the importance of the compatibility.)

How do you think following approach:
1. Initially (before booting), the system has /etc/fstab.d/*.fstab files only.
2. When the system booting, systemd merges the *.fstab file into /etc/fstab.
3. Then systemd loads /etc/fstab.
4. Other programs can loads /etc/fstab either directly or via glibc interface.

Though a rpm package must run something `merge-fstab' command to update
fstab after putting a file under /etc/fstab.d, rpm -V rpm -ql and rpm -qf
works fine. Here I assume `merge-fstab' is provided by util-linux.

This approach may need the modification of disro installer.
/etc/fstab is always overwritten by systemd when booting.
So the installer must generate not /etc/fstab but
/etc/fstab.d/00.fstab or something. A tool which adds an entry
to /etc/fstab doesn't work, too.

Masatake YAMATO


> -- 
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
