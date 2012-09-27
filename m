Return-Path: martin.petersen@oracle.com
To: =?utf-8?B?THVrw6HFoQ==?= Czerner <lczerner@redhat.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] blkdiscard: add new command
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1347486555-24330-1-git-send-email-lczerner@redhat.com>
	<alpine.LFD.2.00.1209261546390.31136@dhcp-187-45.bos.redhat.com>
	<20120927094256.GA18644@x2.net.home>
	<alpine.LFD.2.00.1209271113040.31136@dhcp-187-45.bos.redhat.com>
	<yq14nmja2kd.fsf@sermon.lab.mkp.net>
	<alpine.LFD.2.00.1209271242550.31136@dhcp-187-45.bos.redhat.com>
Date: Thu, 27 Sep 2012 13:33:30 -0400
In-Reply-To: <alpine.LFD.2.00.1209271242550.31136@dhcp-187-45.bos.redhat.com>
	(=?utf-8?B?Ikx1a8OhxaE=?= Czerner"'s message of "Thu, 27 Sep 2012 13:03:30
 -0400 (EDT)")
Message-ID: <yq1r4pn8j6d.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <util-linux.vger.kernel.org>

>>>>> "Luk=C3=A1=C5=A1" =3D=3D Luk=C3=A1=C5=A1 Czerner <lczerner@redhat.com=
> writes:

Luk=C3=A1=C5=A1> Hmm, I do not know. blktool seems to be very similar to bl=
ockdev
Luk=C3=A1=C5=A1> in the sense that it is for querying and changing block de=
vice
Luk=C3=A1=C5=A1> setting which is not what we do with, discard, write same =
or
Luk=C3=A1=C5=A1> zeroout where we actually change the data on the device
Luk=C3=A1=C5=A1> itself. In my mind it just somehow does not fit there.

I was merely picking up on the fact that blockdev's argument handling
didn't seem particularly friendly to the discard/zero/ws case. Whereas
blktool looked more flexible.


Luk=C3=A1=C5=A1> But you're right that it is not just about discard or secu=
re
Luk=C3=A1=C5=A1> discard, we have other quite similar functionalities and i=
t might
Luk=C3=A1=C5=A1> be worth having one separate tool for all those, thanks for
Luk=C3=A1=C5=A1> pointing this out.

I'm perfectly ok with a separate blkswissarmyknife command. I'm also ok
with separate blkdiscard/blkwritesame/blkzeroout commands as long as
they look and feel the same.

--=20
Martin K. Petersen	Oracle Linux Engineering
