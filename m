Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:30411 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759017Ab3JONsr (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 15 Oct 2013 09:48:47 -0400
Date: Tue, 15 Oct 2013 15:48:43 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [patches] a few more man-page improvements
Message-ID: <20131015134843.GD31477@x2.net.home>
References: <1381783511.18298.33939989.442C9894@webmail.messagingengine.com>
 <20131015082731.GA31477@x2.net.home>
 <1381830660.19586.34144785.7C200E19@webmail.messagingengine.com>
 <20131015113117.GC31477@x2.net.home>
 <1381840942.1853.34205941.61403749@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1381840942.1853.34205941.61403749@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Oct 15, 2013 at 02:42:22PM +0200, Benno Schulenberg wrote:
> 
> On Tue, Oct 15, 2013, at 13:31, Karel Zak wrote:
> > On Tue, Oct 15, 2013 at 11:51:00AM +0200, Benno Schulenberg wrote:
> > > Now it compiles fine, with only those five warnings in libfdisk/src/ask.c:
> > > «format '%zd' expects argument of type 'signed size_t', but...» and two
> > > unused variables in misc-utils/cal.c (when compiled without ncurses).
> > 
> >  Thanks! Fixed.
> 
> Well... the warnings for ask.c have gone, but now I get these three for gpt.c:
> 
> libfdisk/src/gpt.c: In function 'gpt_verify_disklabel':
> libfdisk/src/gpt.c:1540:7: warning: format '%ld' expects argument of type 'long int', but argument 3 has type 'uint64_t' [-Wformat]
> libfdisk/src/gpt.c:1540:7: warning: format '%ld' expects argument of type 'long int', but argument 5 has type 'uint64_t' [-Wformat]
> libfdisk/src/gpt.c:1540:7: warning: format '%ld' expects argument of type 'long int', but argument 3 has type 'uint64_t' [-Wformat]

 I have fixed this in libfdisk branch (git hub) for the next release
 v2.25, for v2.24 it's tricky as a real fix requires changes to
 translated strings too.

 I'll probably do the change after po/ stuff merge rather than cast
 from uint64_t from long.

> And the ones for cal.c are still there:
> 
> misc-utils/cal.c:139:20: warning: 'term' defined but not used [-Wunused-variable]
> misc-utils/cal.c:141:13: warning: 'Slen' defined but not used [-Wunused-variable]

 Ah, so you don't have libncurses as well as libtermcap :-) Fixed.

 Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
