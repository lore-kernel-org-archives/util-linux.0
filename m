Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42806 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498Ab2AWNEC convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 23 Jan 2012 08:04:02 -0500
Received: by iacb35 with SMTP id b35so3720217iac.19
        for <util-linux@vger.kernel.org>; Mon, 23 Jan 2012 05:04:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120123122115.GA29250@x2.net.home>
References: <20120120140444.GC13157@x2.net.home> <20120120154912.GK8797@codelibre.net>
 <CAPXgP13a9v+f1uNdpe-c+aApLfLpgn15b1-gZxRPd0wMvU=B-Q@mail.gmail.com>
 <20120120162220.GN8797@codelibre.net> <CAPXgP11pvch92n1=mMfDsMLoGZMG8xq0e1juXyUO6mxFR6_GYg@mail.gmail.com>
 <20120123122115.GA29250@x2.net.home>
From: Kay Sievers <kay.sievers@vrfy.org>
Date: Mon, 23 Jan 2012 14:03:41 +0100
Message-ID: <CAPXgP11WMG1Q53scWXqQnktOyUZbY5K09KRfRaT3ct-Y78yULA@mail.gmail.com>
Subject: Re: /etc/fstab.d yes or not
To: Karel Zak <kzak@redhat.com>
Cc: Roger Leigh <rleigh@codelibre.net>, util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jan 23, 2012 at 13:21, Karel Zak <kzak@redhat.com> wrote:
> On Fri, Jan 20, 2012 at 06:59:47PM +0100, Kay Sievers wrote:
>> > Inventing custom file formats for these (as is the current situation)
>> > is both opaque to the admin and less amenable to preservation/upgrading
>> > of the admins customisations and the defaults.
>>
>> I'm not talking about custom file formats, better just add a mount -c,
>> and do mount -c /etc/kernelfs.d/*.conf, or whatever will fit systemv
>> needs.
>
>  This is planned (I talked about it on dracut list few months ago). It
>  means:
>
>    mount --fstab=<path> /mountpoint
>
>  to override the default /etc/fstab path. The <path> could be also a
>  directory. So you can maintain our mountpoints in multiple files and
>  mount(8) will be able to search in the files if --fstab=<path> is
>  explicitly specified. I think this should be enough for initramfs
>  scripts.
>
>  The problem is that the configuration won't be visible if
>  --fstab is not specified -- this is possible to resolve probably
>  by regular /etc/fstab.d only ;-)

It creates many times more problems that anybody has today.

>> This is nothing really to share between systemd and systemv here. This
>> problem just does not exist for systemd.
>
>  Well, Masatake has RHEL customers who want to deploy systems with
>  rpm/yum, %post scripts are poor solution because it's not too
>  reliable and verification with rpm -V doesn't work. Do we have any
>  answer for this use case?

We don't need one. System mounts just do not belong into packages,
they are mandatory and hard-coded, or set by the admin and
host-specific configured, and never to be dropped by RPM. RPM is not
to be used for host-only system config.

Kay
