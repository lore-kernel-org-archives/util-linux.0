Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qk0-f181.google.com ([209.85.220.181]:34595 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755922AbbFVHHq (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 22 Jun 2015 03:07:46 -0400
Received: by qkeo142 with SMTP id o142so79046956qke.1
        for <util-linux@vger.kernel.org>; Mon, 22 Jun 2015 00:07:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <558768CB.8090209@ubuntu.com>
References: <558768CB.8090209@ubuntu.com>
Date: Mon, 22 Jun 2015 15:07:46 +0800
Message-ID: <CAGnHSE=dSthRzLJC0N6hwZEkc3bzV5gmeRXB4y9+yysfi6k2Bg@mail.gmail.com>
Subject: Re: Manual sections vs. /bin or /sbin location
From: Tom Yan <tom.ty89@gmail.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Does this still matters now? For example:
https://www.archlinux.org/news/binaries-move-to-usrbin-requiring-update-intervention/
https://projects.archlinux.org/svntogit/packages.git/tree/trunk/PKGBUILD?h=packages/util-linux

On 22 June 2015 at 09:45, Phillip Susi <psusi@ubuntu.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
>
> I came across a bug report in Debian noting that findmnt is in /bin,
> not /sbin, but its manual page is in section 8.  Should one or the
> other be moved so they line up?
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1
>
> iQEcBAEBCgAGBQJVh2jLAAoJENRVrw2cjl5RpNoH/0LbBCNB2JX3duiRzW7giKl/
> PEwsI9qqnkSa6YLQTt3+mkhZEceDYmk6+cteOEWTi0iywL/OP4OaDwvbZCENQJ2P
> jWUk024XbWry8TCB5sDq5ntF83ikFWVrvbdQFbRJG+gC0zktJ7RM98rLULO7AUHc
> 9CarDMWKZx6BSL7g0SI9PCVVLROVk7rqcfsJj4BpRJi4TC1iONdxz6BExE2eF0/B
> p6sg6y7NB6FO0NnpqUmCil5XodJZ6kZxs2+ZB0ilk2Z2G31aPjlAtNo8X435XFNB
> z2ZSi4H0+AEXTFiMeTtLuusiue68jWrWoGzbF5xSwKROZZ039MAv2OCID9vgvkA=
> =vNLd
> -----END PGP SIGNATURE-----
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
--
To unsubscribe from this list: send the line "unsubscribe util-linux" in
