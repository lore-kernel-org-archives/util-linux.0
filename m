Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:13665 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752926AbaDDOJy (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 4 Apr 2014 10:09:54 -0400
Date: Fri, 4 Apr 2014 16:09:49 +0200
From: Karel Zak <kzak@redhat.com>
To: Paul Barker <paul@paulbarker.me.uk>
Cc: util-linux@vger.kernel.org
Subject: Re: Compile failure due to use of qsort_r
Message-ID: <20140404140949.GB22126@x2.net.home>
References: <CANyK_8d6L7vL6Mfq4VNdScjoVLb1K1+8hYsDnuQBZLOh5LC3BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CANyK_8d6L7vL6Mfq4VNdScjoVLb1K1+8hYsDnuQBZLOh5LC3BA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Apr 01, 2014 at 01:03:10PM +0100, Paul Barker wrote:
> Personally I think a good solution would be to add a configure check
> on whether qsort_r is provided and to either error out at that stage
> or provide a workaround.

Fixed.

The code in libfdisk is not so important, I've made it optional by #ifdef
HAVE_QSORT_R.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
