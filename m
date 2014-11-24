Return-Path: phillsusi@gmail.com
Sender: Phillip Susi <phillsusi@gmail.com>
Message-ID: <547343EA.6090606@ubuntu.com>
Date: Mon, 24 Nov 2014 09:42:50 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>, Drake Wilson <drake@dasyatidae.net>
CC: util-linux@vger.kernel.org, 770211@bugs.debian.org
Subject: Re: LUKS partition types, redux
References: <546D0495.2030803@dasyatidae.net> <20141124113733.GC926@x2.net.home>
In-Reply-To: <20141124113733.GC926@x2.net.home>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/24/2014 6:37 AM, Karel Zak wrote:
> The current trend is to use partition type to define for what
> purpose we want to use the partition (for example "this is /home") 
> independently on partition format.

I wouldn't call this bone headed idea of redhat's a trend.  Using
partition table type codes to decide to auto mount in particular parts
of the filesystem is such a brain damaged idea, those who thought it
up need beaten with a clue-by-four and its use needs to be *strongly*
discouraged.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iQEcBAEBAgAGBQJUc0PqAAoJEI5FoCIzSKrwF3AIAKsduxIzyXOqSlCf0emWc/m3
r/QmAMqyFG5ua1msWmAQaeTTnSFYqwyf4xubIQay8PTd0ruT7Hq/rusu4DCS1aQ1
fecZQhTQi/HHBbZ3mM8w472IB2PM5qDNEDDwZkgbOCpBoEByeZUZFqq+stFSakoD
CHc4sVqHj5FPA3HRq+XuCfqhawc3TcGaO40J0qr0c+7vMm1cAHLIAjifRR8WNrnf
UNk+kDfZJwixaL45t/YcHx001FNJO9Aitj42KV5k4cHke2wAmcmSVj4T9k0NgoCE
TfeDbJrhuQPtJ/V1/oE7q3aH9agppucuEcIjW5Y4ICnqgCeydwlfVfx+FMlVLTk=
=xHEg
-----END PGP SIGNATURE-----
