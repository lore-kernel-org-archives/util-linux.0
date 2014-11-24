Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qa0-f50.google.com ([209.85.216.50]:34898 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753808AbaKXOdv (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 24 Nov 2014 09:33:51 -0500
Received: by mail-qa0-f50.google.com with SMTP id w8so6305584qac.23
        for <util-linux@vger.kernel.org>; Mon, 24 Nov 2014 06:33:50 -0800 (PST)
Message-ID: <547341AD.4020702@ubuntu.com>
Date: Mon, 24 Nov 2014 09:33:17 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Drake Wilson <drake@dasyatidae.net>
CC: util-linux@vger.kernel.org
Subject: Re: Bug#770211: LUKS partition types, redux
References: <546D0495.2030803@dasyatidae.net> <201411192224.sAJMOhTi010782@hobgoblin.ariadne.com> <546E1A16.6050102@ubuntu.com> <5472B7E4.4040601@dasyatidae.net>
In-Reply-To: <5472B7E4.4040601@dasyatidae.net>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/23/2014 11:45 PM, Drake Wilson wrote:
> So---entirely aside from the _other_ subthread about types _inside_
> LUKS---do you still intend to provide this as a reason for not
> adding GPT/MBR LUKS types to fdisk, even in light of the
> destructive interaction I mentioned in my first post?  I'm worried
> that my having said anything else while replying to Dale may have
> been a mistake and given the impression that "no types inside LUKS"
> answers my original concern, which it doesn't.
> 
> As I mentioned, GPT and MBR have significant interop
> characteristics with other tools, so I'm not convinced by the
> "Linux only uses blkid" there.  If that's what you're truly going
> with after having seen the practical results, I won't argue
> further, but I'd like to know.

I have to say that adding more type codes for no reason is something
I'm against.  Like you said in your first post, the loss was caused by
a bug in debian-installer coupled with the lvm type code.  If you
simply use the normal "Linux" type code, then everything works out
fine so I don't see any reason to add more complexity and confusion by
introducing yet another type code.  Had the useless lvm type code
never been introduced in a similar manner, you wouldn't have had the
problem you did.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iQEcBAEBAgAGBQJUc0GtAAoJEI5FoCIzSKrwEtkH/iCiZ1Hm4EaBs7btRWD5C0FW
fC363eGKNCK4KsYMPpVv+MjdLy1kwonmmI9OFl+uROdnCaZ2/GzgmynlUtviYl3H
MtXlWEvmJGCT43Qgm97H3OC/3ihJ2epxAP4J5L7gK7fofTq7iqxpk47J1bm2MjUI
XgNMxx31OfQzOtHKZSolJ8wCIC76Zre8tvMjDuGx8AF8JvBnkHpTykWG0B4K3niD
6B5pm/FnSV7t+YoZjkdrJMJsxoZFKU78A1cHeSRuKbXqJVrQXhJbxlcCg21DUGtD
YniJM+W/Cy5KQAh2EfuwMQxkSOXnPTZvSTGdjTserDW5fmdUN2Z7PFlGFOlRZmA=
=Xcjj
-----END PGP SIGNATURE-----
