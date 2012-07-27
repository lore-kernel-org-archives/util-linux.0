Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f170.google.com ([209.85.212.170]:48218 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150Ab2G0I0Z (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 27 Jul 2012 04:26:25 -0400
Received: by wibhq12 with SMTP id hq12so442813wib.1
        for <util-linux@vger.kernel.org>; Fri, 27 Jul 2012 01:26:24 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20120727081033.GA14019@x2.net.home>
References: <20120727081033.GA14019@x2.net.home>
Date: Fri, 27 Jul 2012 10:26:24 +0200
Message-ID: <CAG27Bk1mk08N=0Zbo-Bbd_v93C6cfEcO1chYyiDAtRf1sQOEpw@mail.gmail.com>
Subject: Re: v2.22-rc2 wish list
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jul 27, 2012 at 10:10 AM, Karel Zak <kzak@redhat.com> wrote:
>  It would be nice to have:
>
>   - fixed typos in docs, man pages, Release Notes, strings, ...
>     (misspell-check)

I wonder if that could be automated somehow...

>   - regression tests for fdisk (see for example tests/ts/fdisk/sunlabel),
>     it would be really nice to have tests for all labels with all
>     basic operations (add, move, remove partitions, ...)
>
>   - try to re-build tarball in your distro

git clean -xdf
./autogen.sh && ./configure && make distcheck
scp util-linux-2.22.rc1*tar.xz unusual-build-system:

Build on 'unusual-build-system' the util-linux tar ball with

./configure --enable-most-builds

and remember to './tests/run.sh'.

>   - test uuidd with systemd

I think it might be good idea to try to get 'make check' to run
'./tests/run.sh'.

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
