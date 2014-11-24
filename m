Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qc0-f174.google.com ([209.85.216.174]:47789 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753998AbaKXOph (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 24 Nov 2014 09:45:37 -0500
Received: by mail-qc0-f174.google.com with SMTP id c9so6834539qcz.5
        for <util-linux@vger.kernel.org>; Mon, 24 Nov 2014 06:45:36 -0800 (PST)
Message-ID: <5473446E.6040704@ubuntu.com>
Date: Mon, 24 Nov 2014 09:45:02 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Drake Wilson <drake@dasyatidae.net>
CC: util-linux@vger.kernel.org
Subject: Re: Bug#770211: LUKS partition types, redux
References: <546D0495.2030803@dasyatidae.net> <201411192224.sAJMOhTi010782@hobgoblin.ariadne.com> <546E1A16.6050102@ubuntu.com> <5472B7E4.4040601@dasyatidae.net> <547341AD.4020702@ubuntu.com> <547342B2.2060509@dasyatidae.net>
In-Reply-To: <547342B2.2060509@dasyatidae.net>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/24/2014 9:37 AM, Drake Wilson wrote:
> Which "normal" "Linux" type code are you talking about?  The one
> that's marked "Linux filesystem"?  That sounds like it's simply
> shifting the potential for trouble somewhere else.  The one for
> "Linux reserved"? If that's the intent of that one, perhaps it
> should be clearer that it's "reserved for user" rather than
> "reserved for some unknown OS use".  If there were a "Linux
> general/other" type code, then I agree that that would be fine, but
> I don't see one in the list.

The one that fdisk identifies as "Linux", i.e. 83.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iQEcBAEBAgAGBQJUc0RuAAoJEI5FoCIzSKrwiMEH/3Njqw51tHDH2Kg3EDKpHfzR
tu5CyfSmuj7e+hnSykvto4zdUly+wCRzIs3ZfhLa/ym1ClJhbOtISagcbv3tc+/C
S80SEU2Hv1uV96yTTo1hd5Hv2kKeWwBTXcPZRW76GddgrSnU6y5kv3yh4pnQNxEV
/wE4TOqXIVa7hg6Yxm45UUP9jRzDm9kgYR+9bva5flqf0Dc+O3P51iKvtLjhuZvA
/LbRIln5fpJeYpxuD/a/BGhGE7jlcTirTobUz/xEuALdDWdGrcIPh2I6DWdCWVh3
aJjr9ZCU7Be1qvMMDOViaWNO6J7ef0AqhjVG/xqteqe3/BaB8srupEXbn62OI2s=
=Un4V
-----END PGP SIGNATURE-----
