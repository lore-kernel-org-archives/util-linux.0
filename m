Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.8]:64493 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933313Ab2JaH74 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 31 Oct 2012 03:59:56 -0400
Message-ID: <5090DA77.9060408@bernhard-voelker.de>
Date: Wed, 31 Oct 2012 08:59:51 +0100
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Matt Burgess <matthew@linuxfromscratch.org>
CC: util-linux@vger.kernel.org
Subject: Re: Discrepancies between real and symlinked mtab
References: <1351638239.1651.13.camel@kyoto.localdomain>
In-Reply-To: <1351638239.1651.13.camel@kyoto.localdomain>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Matt,

On 10/31/2012 12:03 AM, Matt Burgess wrote:
> Consider trying to answer the question "What partition is mounted
> on /" (it happens to be /dev/sda3 in this example), when /etc/mtab is a
> symlink pointing to /proc/mounts:

I'll only answer for df here because it is not part of util-linux,
but rather in the coreutils package.

> 2) df(1)
> 
> Filesystem     1K-blocks    Used Available Use% Mounted on
> rootfs          20642428 1576788  18017064   9% /
> /dev/root       20642428 1576788  18017064   9% /
> 
> Uh-oh - now I appear to have 2 filesystems mounted at '/' (yes, I know
> you can tell by the same stats that it is in fact the same FS).  What is
> this rootfs entry?

That rootfs entry comes from early boot time when '/' is mounted on
itself.

BTW there is already a discussion on the coreutils ML about this:

http://www.mail-archive.com/coreutils@gnu.org/msg03582.html

> As all 3 utils show the same issue, I assume this is something to do
> with libblkid?

No, df doesn't use libblkid. It uses gnulib's function
  read_file_system_list ()
to read the mount list.

Have a nice day,
Berny
