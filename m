Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qc0-f176.google.com ([209.85.216.176]:35451 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055AbaKXPKa (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 24 Nov 2014 10:10:30 -0500
Received: by mail-qc0-f176.google.com with SMTP id i17so6866844qcy.7
        for <util-linux@vger.kernel.org>; Mon, 24 Nov 2014 07:10:30 -0800 (PST)
Message-ID: <54734A43.3000907@ubuntu.com>
Date: Mon, 24 Nov 2014 10:09:55 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Drake Wilson <drake@dasyatidae.net>
CC: util-linux@vger.kernel.org
Subject: Re: Bug#770211: LUKS partition types, redux
References: <546D0495.2030803@dasyatidae.net> <201411192224.sAJMOhTi010782@hobgoblin.ariadne.com> <546E1A16.6050102@ubuntu.com> <5472B7E4.4040601@dasyatidae.net> <547341AD.4020702@ubuntu.com> <547342B2.2060509@dasyatidae.net> <54734522.7010807@dasyatidae.net> <547347A1.7080402@ubuntu.com> <54734903.5080503@dasyatidae.net>
In-Reply-To: <54734903.5080503@dasyatidae.net>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/24/2014 10:04 AM, Drake Wilson wrote:
> In parted, really?  While I was chasing down the partman-lvm data
> flow involved, it seemed to me that it was libparted that was
> setting flags based on interpreting the LVM GPT type, which were
> later getting interpreted; it wasn't obvious to me where to break
> the logic chain.  Is that part of libparted a Debianism, or did you
> mean parted-the-tool as opposed to libparted-the-library, or... ?

Ahh, I forgot about that.  I never use it and there's no reason to,
but it was added, probably to maintain parity with MBR, which already
had an lvm type code as well.  Now that I check the code it does also
have raid and swap for similar reasons and they are equally useless.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iQEcBAEBAgAGBQJUc0pDAAoJEI5FoCIzSKrw+08H+QG9SO+aD0Zc2fmzZj+RpQr7
95TtewhPkd56MmhxNPkn2IFKd7wwnm/fqutwW8UwTTrJPiPOF3csq4ugyC35t9hZ
tY9xgjw0YwSKa3yAKVzGkdKpO09vtinQWmOMtGdk8uiBpM1vehIM84Vpi3HQuLuL
IUCsFl/y2fhFIq1Ol8bcnaEtz4YVBpQBRIPPxivEXrehIOvBcZFZsc6i/hZsquw5
oP2qUs65t7sTgTKVC/vmINZz5MQx/wSMwVC2/6KivvN0SbRebrJ7wOxesJFR5t6c
25Rf2Q/wSomBqhgbKBgSenPbXGORFMsogLXFtfkk8JHY/tfMr1lunmu1oOOefis=
=ztuu
-----END PGP SIGNATURE-----
