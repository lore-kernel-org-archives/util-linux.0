Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46262 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751924AbdBILJp (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 9 Feb 2017 06:09:45 -0500
Date: Thu, 9 Feb 2017 12:09:42 +0100
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
Subject: Re: [ping] Karel: Re: pull: hwclock 27 changes
Message-ID: <20170209110942.woeapxeeahnd3mnd@ws.net.home>
References: <alpine.LNX.2.20.1701072212010.9096@imuri>
 <a9d7f37b-3607-70d4-843a-7d934bd305d5@gmx.com>
 <alpine.LNX.2.20.1701112055190.2589@imuri>
 <ede34a46-7290-c68b-1dd8-e4fc356e5caf@gmx.com>
 <alpine.LNX.2.20.1701140930380.2049@imuri>
 <f723104e-d23b-f8fd-e9ee-b9fc82c86fd3@gmx.com>
 <c88dc7ee-3e18-19ec-612e-3788551517bb@gmx.com>
 <alpine.LNX.2.20.1701252136160.492@imuri>
 <5feac9a5-e3e3-5148-60a0-fb3197a1caa8@gmx.com>
 <9798a869-fb09-77e7-a13a-bca002617672@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9798a869-fb09-77e7-a13a-bca002617672@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Feb 02, 2017 at 10:04:13AM -0500, J William Piggott wrote:
> Outside of our ongoing discussion below regarding a 'technically
> unnecessary' cast, I think Sami's work is ready for you to consider it
> for committing. I would be interested in your thoughts on the cast.

I have no strong opinion about it, for the reader it could be really
nice to follow code author ideas, but personally I think it's better
to not use it too often :-)

BTW, often bug in libblkid/fdisk is math without casts, something
like:

    uint64_t x;
    uint32_t a, b;

    x = a + b

here it's better to be explicit and use (uint64) a + b. The same
problem if you write macros to hide some operations (we had this
problem in include/bitops.h).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
