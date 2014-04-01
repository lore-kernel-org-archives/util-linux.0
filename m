Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:1940 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751740AbaDANpW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 1 Apr 2014 09:45:22 -0400
Date: Tue, 1 Apr 2014 15:45:17 +0200
From: Karel Zak <kzak@redhat.com>
To: Paul Barker <paul@paulbarker.me.uk>
Cc: util-linux@vger.kernel.org
Subject: Re: Compile failure due to use of qsort_r
Message-ID: <20140401134517.GP23464@x2.net.home>
References: <CANyK_8d6L7vL6Mfq4VNdScjoVLb1K1+8hYsDnuQBZLOh5LC3BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CANyK_8d6L7vL6Mfq4VNdScjoVLb1K1+8hYsDnuQBZLOh5LC3BA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Apr 01, 2014 at 01:03:10PM +0100, Paul Barker wrote:
> Hi all,
> 
> I'm using util-linux as part of the OpenEmbedded build system and
> we've ran into two places where the use of qsort_r in util-linux is
> causing a compile failure:
> 
> - CentOS 5.10 is using an old version of glibc which doesn't provide qsort_r

 Well, I don't like this kind of arguments -- it's almost always
 problematic to update only small subset of distro...

> - We're experimenting with musl-libc and this also doesn't provide qsort_r

 This is better, I'll add #ifdef to the code. Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
