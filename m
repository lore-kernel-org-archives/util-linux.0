Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:50235 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932128AbaA1U5h (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 28 Jan 2014 15:57:37 -0500
Message-ID: <52E819BF.4090503@ubuntu.com>
Date: Tue, 28 Jan 2014 15:57:35 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Christoph Anton Mitterer <calestyo@scientia.net>,
        util-linux@vger.kernel.org
Subject: Re: fdisk: add GPT partition types for plain dm-crypt and LUKS
References: <1390934933.15213.17.camel@heisenberg.scientia.net>
In-Reply-To: <1390934933.15213.17.camel@heisenberg.scientia.net>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On 01/28/2014 01:48 PM, Christoph Anton Mitterer wrote:
> Hi.
> 
> Recently a discussion[0] was initiated at the dm-crypt mailing
> list about whether or not to have a GPT type for it.
> 
> In the end, upstream basically agreed[1][2] to the following 
> definitions: plain dm-crypt   7FFEC5C9-2D00-49B7-8941-3EA10A5586B7 
> LUKS partition   CA7D7CCB-63ED-4C53-861C-1742536059CC

Why?  Linux doesn't use partition IDs.  Also isn't plain dm-crypt
depreciated?


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCgAGBQJS6Bm/AAoJEI5FoCIzSKrw5pIH/RNRrw1saTRL0emY+QBzjYAb
AY8Me6djgDkzQchnm5OdLQGvfDSjBy+Mrci2zEyjqGN80ceM2ugwZKvlEZnppkjc
UjeWKsLBs8AK2NT3sWDzA4Qo0iuvwYJprbjRp46BAhwiI4VHn8Pgj1ZMutgJLo/n
mjUFt1zB+P9Bs8YyhUWael6Bf0dM2M/PKrHgJDHSll3rVpHwWnZIPQ0Q19eoCxD9
ZocxIPkyPXFZPX8hzz00BBseQfYGIOC544Zi5FZzlXiiouqfAfC6nJhsp1GKZKiS
1gcQycOphugBPHqHtDR5scj0Jj+BkjTcEgjdgs3aDsQFt85ky7KOn8j1l+1u4VQ=
=DZc2
-----END PGP SIGNATURE-----
