Return-Path: psusi@ubuntu.com
Message-ID: <50B8E344.9080405@ubuntu.com>
Date: Fri, 30 Nov 2012 11:48:04 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: BUG: fdisk fails silently if EBR is outside of disk
References: <20121130105659.GA21271@x2.net.home>
In-Reply-To: <20121130105659.GA21271@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/30/2012 5:56 AM, Karel Zak wrote:
> Fixed (I hope).
> 
> # ./fdisk /dev/loop0 You must set cylinders. You can do this from
> the extra functions menu. Failed to read extended partition table
> (offset=462748414) Warning: ignoring extra data in partition table
> 5 Warning: ignoring extra data in partition table 5 Warning:
> ignoring extra data in partition table 5 Warning: invalid flag
> 0x1919 of partition table 5 will be corrected by w(rite) Welcome to
> fdisk (util-linux 2.22.269-6b3e3).
> 
> Changes will remain in memory only, until you decide to write
> them. Be careful before using the write command.
> 
> 
> Command (m for help): p
> 
> Disk /dev/loop0: 0 MB, 512 bytes, 1 sectors Units = sectors of 1 *
> 512 = 512 bytes Sector size (logical/physical): 512 bytes / 512
> bytes I/O size (minimum/optimal): 512 bytes / 512 bytes Disk
> identifier: 0x0002a9f0
> 
> Device       Boot      Start         End      Blocks   Id   System 
> /dev/loop0p1             256   462748159   231373952   83    Linux 
> /dev/loop0p2       462748414   464843519     1047553    5 Extended 
> /dev/loop0p5   ?   883823639  1304898863   210537612+  19  Unknown

If it could not read the EBR, where did it come up with the p5 entry?



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQEcBAEBAgAGBQJQuONEAAoJEJrBOlT6nu75soUIAJE3pdR1r+peBOhJHakGmuHz
5hFUMz6AvTkPW+ed1FUAp26qZtO5ngK46Q/d1+cGW4Asj30J+BXtip2pcUj8laPe
kjbh3zoMuBWHX1TbfmJn2Ydc+s/+OpqPmxTsgtUBQ9IR3VgbzbWIK+Vf0zqKVuGw
DEkUD+sHXLF2LfU1sTGA8BDv9VGnaHbEhfdegf2Hi6i29UWxYyXoS7tmOfaRDIes
KJTiYWf4Tflv6FEnKEzLMtn8yOOaURo/aeHM2scTrxvQp9HXZspf9ooHn/HC8SI6
5L6SLF3oxfxxSg1KZwb1pAMflWshU8cbckXwOE9Ye1x8TZv/x4Q8a8Z2E1Tnfuc=
=ZVz1
-----END PGP SIGNATURE-----
