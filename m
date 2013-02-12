Return-Path: mail@bernhard-voelker.de
Message-ID: <511A2DDA.40504@bernhard-voelker.de>
Date: Tue, 12 Feb 2013 12:56:10 +0100
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: kerolasa@gmail.com
CC: Sami Kerola <kerolasa@iki.fi>, Karel Zak <kzak@redhat.com>,
        =?UTF-8?B?TWFudGFzIE1pa3VsxJduYXM=?= <grawity@gmail.com>,
        util-linux@vger.kernel.org
Subject: Re: lslocks =?UTF-8?B?4oCTICJmYWlsZWQgdG8gcGFyc2UgcGlkOiAnV1JJVEU=?=
 =?UTF-8?B?JyI=?=
References: <kf0ehe$q7h$1@ger.gmane.org> <CAG27Bk2dO1ztSAy47=j+nmG+v5YuMCBa0i4eorLWw2sFWRT2Pg@mail.gmail.com> <51197D69.6050901@gmail.com> <20130212111248.GG20408@x2.net.home> <CAG27Bk109veDrkVetXg5cRSA0TogpbhJ0PwFArRyf=pqQg0zfQ@mail.gmail.com>
In-Reply-To: <CAG27Bk109veDrkVetXg5cRSA0TogpbhJ0PwFArRyf=pqQg0zfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On 02/12/2013 12:23 PM, Sami Kerola wrote:
> Almost off topic.

while we're at it - ;-)
is it necessary to open/read/close "/proc/self/mountinfo" so often?

  $ strace -e open ./lslocks 2>&1 | grep mountinfo | wc -l
  67

Have a nice day,
Berny
