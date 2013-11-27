Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:44764 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932166Ab3K0UTl (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 27 Nov 2013 15:19:41 -0500
Message-ID: <529653DC.2020600@ubuntu.com>
Date: Wed, 27 Nov 2013 15:19:40 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: Marc MERLIN <marc@merlins.org>, util-linux@vger.kernel.org
Subject: Re: Severe fdisk problem leading to data loss?
References: <20131118102051.GA31813@merlins.org> <20131124135226.GH11389@merlins.org> <20131125103124.GQ5572@x2.net.home> <529605B7.3020903@ubuntu.com> <20131127145840.GB32483@x2.net.home> <52963910.60800@ubuntu.com> <20131127200724.GT5572@x2.net.home>
In-Reply-To: <20131127200724.GT5572@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/27/2013 3:07 PM, Karel Zak wrote:
> Seriously, maybe it's fine to ignore the partition with the zero
> type by kernel, but I don't think it's good way for fdisk-like
> applications.
> 
> IMHO it's better to force users to delete the partition than rely
> on the flag. See this thread, user lost data because somehow set
> the type to zero and fdisk reused the space.

Only because fdisk let them set it to zero in the first place ;)

> From my point of view all partitions with non-zero size should be 
> visible by fdisk (or parted) independently on flags or types.

I don't like the idea of showing a different view of the partition
table than DOS/Windows; that way lies suffering.  I can maybe see
complaining that the entry is invalid and letting you change the type
to correct the problem ( assuming the start and length don't put it
outside the disk or overlapping other partitions ), but it should be
very clear that this is a broken entry.

> I'll probably add a warning to fdisk to inform users about the zero
>  type problem.

It already does warn you when you set the type to 0.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJSllPcAAoJEI5FoCIzSKrw+6YH/AlZ34QNORe1YxXKAT3g02Ro
YMCVnS8iQdyw15Sj7zJDnl8ZVKkq87jlB/9HuHTrseMSdepK4pt38Gu9nkNXeFiU
7uyk5RLL9C6E90BE1GuV2FT0e02jLUS0BJpylMPFDSdmtNe7/3xVMOlxqkRGycFQ
CF0C2wGV878/pFje4XQbn48WGysVL+BN6PbjdWZZaOqAlldx154la+oYl9h+JkpO
KAfPZdtjIe/q9zXY4hQJzh7VIWgL/vf27/XYnzAXaxBxAiugdUMLinUQJ0j5TwB5
Ju8rN9P9RgQ9SAA6PNTfi5nWYPk1d6brTklQFCHdrGyJ54Pwdm7DKWOGaWxdtqQ=
=rHzX
-----END PGP SIGNATURE-----
