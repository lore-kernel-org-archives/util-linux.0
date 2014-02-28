Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:45415 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743AbaB1TS0 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 28 Feb 2014 14:18:26 -0500
Message-ID: <5310E100.5020405@ubuntu.com>
Date: Fri, 28 Feb 2014 14:18:24 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Davidlohr Bueso <davidlohr@hp.com>
CC: =?UTF-8?B?TWFjaWVqIE1hxYJlY2tp?= <me@mmalecki.com>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] fdisk: warn if opening a device in write mode failed
References: <1393471600-17777-1-git-send-email-me@mmalecki.com>		<1393554731.2899.15.camel@buesod1.americas.hpqcorp.net>	 <CAKC8-7xwz+SZ_TPYx8EbzRbqqErHkaVJ=rOJRG+gvJnu9zdzyQ@mail.gmail.com>	 <5310B80C.7000205@ubuntu.com> <1393612047.2899.31.camel@buesod1.americas.hpqcorp.net>
In-Reply-To: <1393612047.2899.31.camel@buesod1.americas.hpqcorp.net>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 2/28/2014 1:27 PM, Davidlohr Bueso wrote:
>> You really want to tell the user that they aren't going to be
>> able to write up front.
> 
> Sure why not, just not in a library! You can do this in the fdisk 
> program. And if Karel doesn't agree and wants to apply this patch 
> anyway, then it should *at least* be in DBG context.

Right, which is what I said just after that ;)


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJTEOEAAAoJEI5FoCIzSKrwgosH/2VJe8a639As2jvFhBDnp8Fr
H0xuH1fPt/RTE3+d9GlCHlBsfWQlmBgNEzItJR2hCnHLikf8ghY8SXwCXqgmUYZa
RGdwyU10ulhBC552F5x2I+Qgu7xGRxsOhHOlxpgzrPtsZNkf5vqXwlNjxjGr2i2G
zLcdH4Oq2K/D0JoPEKS5Bn8xnbNL/vnd7B6Hn9tqZ8+RfPm6iajr5bIPGOpLOa2E
S/FBo+8Abjln2DIllSZGwQLsoidyWv3fT2iGxaMmtkAGNn9Dbw/r7Uvq4Yt1OICB
/T7F3y1fYb+E/1JPaNneM0wl2smyl3em40uKBuGIi4rhj0g2QVycmANOmol1P0U=
=rQOh
-----END PGP SIGNATURE-----
