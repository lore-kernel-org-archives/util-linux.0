Return-Path: bensberg@justemail.net
Message-Id: <1421874316.196312.217065457.6F95655D@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Bruce Dubbs <bruce.dubbs@gmail.com>
Cc: Karel Zak <kzak@redhat.com>, "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [ANNOUNCE] util-linux v2.26-rc1
Date: Wed, 21 Jan 2015 22:05:16 +0100
In-Reply-To: <54BF57B5.1000505@gmail.com>
References: <20150114194608.GF28019@x2.net.home>
 <1421786901.3565769.216421909.377E2720@webmail.messagingengine.com>
 <54BF57B5.1000505@gmail.com>
List-ID: <util-linux.vger.kernel.org>


On Wed, Jan 21, 2015, at 08:39, Bruce Dubbs wrote:
> Benno Schulenberg wrote:
> > $ gcc --version | head -1
> > gcc (Ubuntu 4.4.3-4ubuntu5.1) 4.4.3
> 
> I don't know how far back you want to go, but that version of gcc was 
> released 21-Jan-2010, fully 5 years ago.

I'm not wanting to go anywhere; it's simply the gcc that's installed
on my system.  And I'm merely providing the solicited feedback.

However, if this util-linux can't be compiled with such an old gcc,
it would be nice if ./configure would report that.  The same for a
minimum required kernel version.

> 2.6.32 was 14-Dec-2009 and I don't see any nano versions beyond 
> linux-2.6.32.27 from 09-Dec-2010

$ uname -rv
2.6.32-71-generic #138-Ubuntu SMP Thu Dec 18 17:38:32 UTC 2014

Ubuntu Lucid is supported until April this year.  Is it so strange to
try and compile a new util-linux on such a system?

Benno

-- 
http://www.fastmail.com - The professional email service
