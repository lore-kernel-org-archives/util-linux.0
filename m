Return-Path: martin.petersen@oracle.com
To: =?utf-8?B?THVrw6HFoQ==?= Czerner <lczerner@redhat.com>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH] blkdiscard: add new command
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1347486555-24330-1-git-send-email-lczerner@redhat.com>
	<alpine.LFD.2.00.1209261546390.31136@dhcp-187-45.bos.redhat.com>
	<20120927094256.GA18644@x2.net.home>
	<alpine.LFD.2.00.1209271113040.31136@dhcp-187-45.bos.redhat.com>
Date: Thu, 27 Sep 2012 11:49:22 -0400
In-Reply-To: <alpine.LFD.2.00.1209271113040.31136@dhcp-187-45.bos.redhat.com>
	(=?utf-8?B?Ikx1a8OhxaE=?= Czerner"'s message of "Thu, 27 Sep 2012 11:21:18
 -0400 (EDT)")
Message-ID: <yq14nmja2kd.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <util-linux.vger.kernel.org>

>>>>> "Luk=C3=A1=C5=A1" =3D=3D Luk=C3=A1=C5=A1 Czerner <lczerner@redhat.com=
> writes:

Luk=C3=A1=C5=A1> TBH this is fugly :). Also what actually is the advantage =
of
Luk=C3=A1=C5=A1> doing this ? So we saved 50 lines of code for this uglines=
s and
Luk=C3=A1=C5=A1> instead of two separate binaries we have this one hybrid a=
nd
Luk=C3=A1=C5=A1> symlink. I am not sure it's worth it. Can't we just have t=
wo
Luk=C3=A1=C5=A1> separate binaries ? What is the problem with that ?

It's not just discard. We should also consider the zeroout and write
same use cases. They have nothing to do with fstrim.

Time to incorporate and extend Garzik's blktool, perhaps?

--=20
Martin K. Petersen	Oracle Linux Engineering
