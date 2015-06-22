Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qk0-f176.google.com ([209.85.220.176]:36670 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753925AbbFVHJ3 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 22 Jun 2015 03:09:29 -0400
Received: by qkfe185 with SMTP id e185so96140057qkf.3
        for <util-linux@vger.kernel.org>; Mon, 22 Jun 2015 00:09:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55876C53.7030505@ubuntu.com>
References: <55876C53.7030505@ubuntu.com>
Date: Mon, 22 Jun 2015 15:09:28 +0800
Message-ID: <CAGnHSE=V-c=e2tV-WrB7xsaZTM=rpX3=KDVPKQ=H9iO2=u7Mog@mail.gmail.com>
Subject: Re: mount existing tmpfs mounts a new tmpfs
From: Tom Yan <tom.ty89@gmail.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

[tom@localhost ~]$ cat /etc/fstab
#
# /etc/fstab: static file system information
#
# <file system>    <dir>    <type>    <options>    <dump>    <pass>
[tom@localhost ~]$ sudo mount /run
mount: can't find /run in /etc/fstab

Again, Arch Linux ; )

On 22 June 2015 at 10:00, Phillip Susi <psusi@ubuntu.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
>
> Forwarding this from debian bug #772419: Run mount /run, and it mounts
> a new tmpfs over top of the existing one in /run ( even if /run isn't
> listed in /etc/fstab ), hiding the existing files.  It should say that
> it is already mounted.
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1
>
> iQEcBAEBCgAGBQJVh2xSAAoJENRVrw2cjl5RnisH/1wvRqqlgckjp1sRdo/zGfHX
> Wpw5vIYxefXvKrQsyI64DMLV6MNNnFdGNIj8QxnBJwMpzFq0+p08u0AWmThNg35Q
> H1as8PA8+RkM7e7vzPXFId7QMjL+Lx09TE4Tg0y6HERF834FnL3QDwYna5AcJbVg
> wvADB7CTEAK3SHv1F1HHVOcKb6DFw0ur/JIM93+P6rohu7jhUOWq+SVcDNZgA/JQ
> dzEzBgFv1+yJPHYP4J8lKTddq+TOGzhamlusfz/6feSKzyvFKSxaPWDrLTNk5hu3
> dj3bHoiWlGB7meo3NCDqKLH6nLeOUhlXgaGh0vm72fwM7Ip4DkO0Ovy4dloxokA=
> =Umj1
> -----END PGP SIGNATURE-----
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
--
To unsubscribe from this list: send the line "unsubscribe util-linux" in
