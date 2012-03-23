Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:11354 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753266Ab2CWRTo (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 23 Mar 2012 13:19:44 -0400
Date: Fri, 23 Mar 2012 18:19:36 +0100
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: Simon de Vlieger <simon@ikanobori.jp>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [PATCH] hexdump: adjust -s and -n option in the man page [was:
 hexsyntax.c using strtol on the offset parameter]
Message-ID: <20120323171936.GH2040@x2.net.home>
References: <4F6B13F9.4020108@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4F6B13F9.4020108@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Mar 22, 2012 at 12:58:49PM +0100, Bernhard Voelker wrote:
> Karel Zak wrote:
> 
> > Fixed. The code (as well as -n) was stupid. Now it supports all
> > possible suffixes (K,M,G,T,P,E,Y,Z) and the number is parsed as
> > uintmax_t.
> 
> btw: it should read "...P,E,Z,Y", as Y>Z.
> 
> The man page is outdated now:
> 
>        -n length
>               Interpret only length bytes of input.
>        ...
>        -s offset
>               Skip  offset bytes from the beginning of the input.  By default,
>               offset is interpreted as a decimal number.  With a leading 0x or
>               0X,  offset  is  interpreted as a hexadecimal number, otherwise,
>               with a leading 0, offset is  interpreted  as  an  octal  number.
>               Appending  the  character  b,  k, or m to offset causes it to be
>               interpreted as a multiple of  512,  1024,  or  1048576,  respec-
>               tively.
> 
> The variant with 0x or 0X doesn't seem to work anyway:
> 
> $ echo 123456789abcdefghijk > /tmp/x
> $ text-utils/hexdump -s 0x1 -n 1 -c /tmp/x
> 0000001   2
> 0000002

 offset addressed by 0x works for me:

./text-utils/hexdump -s 0x1fe -n 2 /dev/sda
00001fe aa55                                   
0000200


> From f546c9d7bdd52b2e57761c2c97a701e662d89bc1 Mon Sep 17 00:00:00 2001
> From: Bernhard Voelker <mail@bernhard-voelker.de>
> Date: Thu, 22 Mar 2012 12:53:06 +0100
> Subject: [PATCH] hexdump: adjust -s and -n option in the man page

 Good point, I have copied the text we already have in the losetup man
 page.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
