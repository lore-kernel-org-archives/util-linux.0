Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qc0-f182.google.com ([209.85.216.182]:53853 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278AbaLCOtv (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 3 Dec 2014 09:49:51 -0500
Received: by mail-qc0-f182.google.com with SMTP id r5so11369954qcx.27
        for <util-linux@vger.kernel.org>; Wed, 03 Dec 2014 06:49:51 -0800 (PST)
Message-ID: <547F22F7.30008@ubuntu.com>
Date: Wed, 03 Dec 2014 09:49:27 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: Francis Moreau <francis.moro@gmail.com>,
        "Dale R. Worley" <worley@alum.mit.edu>, util-linux@vger.kernel.org,
        gabeblack@chromium.org, gwendal@chromium.org
Subject: Re: losetup on a image file containing (GPT) partition doesn't create
 partition devices
References: <542E7000.3040309@gmail.com> <201410031429.s93ET4wu014728@hobgoblin.ariadne.com> <201410031958.s93JwTuY026155@hobgoblin.ariadne.com> <542F065C.2080505@gmail.com> <54304C03.6020309@gmail.com> <201410061547.s96Fl0sN021617@hobgoblin.ariadne.com> <5432BBB0.30701@gmail.com> <20141027201625.GA25833@vapier> <547E1337.1080702@ubuntu.com> <20141203083617.GD1994@x2.net.home>
In-Reply-To: <20141203083617.GD1994@x2.net.home>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/3/2014 3:36 AM, Karel Zak wrote:
> Yes, I don't like the idea with the ioctl workaround in losetup.
> It's fine to use such workarounds in stable branches or in distro
> specific patches, but I really don't want to use workarounds for
> bugs in regular releases (master branch).

Then again, maybe the whole idea of the kernel handling the partition
table should be abandoned ( and the feature removed from the kernel )
and losetup should just call partx and be done with it.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iQEcBAEBAgAGBQJUfyL3AAoJENRVrw2cjl5RGIUH+wWT/HOUblnqldu4M8zgNZ9c
T08BjQKPET1ylRfuVDDdEET5yaP8NI94dNisgyvWWDHbi1PA3I45dodQA3XaywWf
Ue6wEUMV8tujjC7zgUup+yxIca2accrmRP4tqlVOswRMS4nFJqyRHJsDW0azJDR4
3VoaGP1WRf9vtNs4m71a/yljjirAHRBcQ8NVdgDnLe2Ja6Quy2REvVsTCO951O6i
oH5AYBnvEE0iiycxUxj1EGkNRl3QC58/NIJi633MXRrL5VTOd2k37OzEZb7/P/g/
rKBbqnwMMuDVgarF7Ob8KkJb62BKca6W4Sbd806TvygCoB4K8EGW1zVpK1LUAAI=
=qTsq
-----END PGP SIGNATURE-----
