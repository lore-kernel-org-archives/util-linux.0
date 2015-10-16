Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59788 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752550AbbJPKKW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 16 Oct 2015 06:10:22 -0400
Date: Fri, 16 Oct 2015 12:10:21 +0200
From: Karel Zak <kzak@redhat.com>
To: Isaac Dunham <ibid.ag@gmail.com>
Cc: Andreas Schwab <schwab@suse.de>, util-linux@vger.kernel.org
Subject: Re: [PATCH] script: don't assume time_t is compatible with long
Message-ID: <20151016101021.GC2990@ws.net.home>
References: <mvm37xcs2mb.fsf@hawking.suse.de>
 <20151016011258.GA3711@newbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151016011258.GA3711@newbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Oct 15, 2015 at 06:12:59PM -0700, Isaac Dunham wrote:
> I'm guessing that the attached patch would be the most corrrect approach;
> any comments?

 Applied,

> +	if (!str || sscanf(str, "%lld", &sec) != 1)

 Try compile with -Wformat, compiler does not like
 %ll for int64_t types :-)
 
 We usually use %jd and %ju for 64-bit numbers, but real pedantic
 solution is to use SCN macros ("%"SCNi64 in this case) from
 inttypes.h.

 Hmm.. is there any system where intmax_t is already 128-bits? I know
 that gcc already supports __int128_t on some archs, but it's not
 treated as extended integer types. So, I guess we're relative safe
 when we assume that intmax_t is 64-bits :-)

 http://stackoverflow.com/questions/29927562/what-abi-if-any-restricts-the-size-of-uintmax-t

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
