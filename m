Return-Path: util-linux-owner@vger.kernel.org
Received: from mta04.eastlink.ca ([24.224.136.10]:54703 "EHLO
	mta04.eastlink.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949AbbAZFG7 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 26 Jan 2015 00:06:59 -0500
Received: from cmgw05.eastlink.ca ([71.7.199.171])
 by mta04.eastlink.ca (Oracle Communications Messaging Exchange Server
 7u4-21.01 64bit (built Feb 16 2011))
 with ESMTP id <0NIR00LZ2PSQS1P0@mta04.eastlink.ca> for
 util-linux@vger.kernel.org; Mon, 26 Jan 2015 01:06:57 -0400 (AST)
Date: Mon, 26 Jan 2015 01:06:55 -0400
To: "Dale R. Worley" <worley@alum.mit.edu>
Cc: Lucio Crusca <lucio@sulweb.org>, util-linux@vger.kernel.org
Subject: Re: [BUG] losetup: support for physical devices
Message-id: <20150126050655.GG29504@cordes.ca>
References: <m96ard$qu8$1@ger.gmane.org> <87mw56jkgq.fsf@hobgoblin.ariadne.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
In-reply-to: <87mw56jkgq.fsf@hobgoblin.ariadne.com>
From: Peter Cordes <peter@cordes.ca>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jan 25, 2015 at 10:21:09PM -0500, Dale R. Worley wrote:
> Lucio Crusca <lucio@sulweb.org> writes:
> > During a disaster recovery I found that losetup either 
> >
> > 1. does not support creating loop devices that target physical devices. In 
> > this case I think there exists a compelling reason to support them 
> > (http://serverfault.com/questions/659484) and this bug report is a wishlist 
> > bug 
> >
> > or 
> >
> > 2. it does support physical devices, but it is an undocumented feature (at 
> > least in the manpage) and the warning it issues is misleading beacuse it 
> > makes you think it doesn't support them ("losetup: /dev/sdc2: warning: file 
> > smaller than 512 bytes, the loop device maybe be useless or invisible for 
> > system tools"). In this case this could be a documentation bug.
> >
> > I haven't tested which of the two possibilities is the real situation, but 
> > I'm pretty sure you already know.
> 
> I don't recall what I've done that convinced me, but I'm *sure* that you
> can do
> 
>     losetup -o [offset] {-f[--show]|loopdev} /dev/sdXXX

 Yup, it works for me.  I posted an answer on
http://serverfault.com/questions/659484, gist of it is that 

sudo losetup -o 32256 -f /dev/sdb3
 sets up a loopback dev.  Test with:
sudo tail -c 32257 /dev/sdb3 | sudo cmp - /dev/loop5 

 If you leave out -f or a specific arg like /dev/loop0, then the
command fails because  losetup /dev/sdb3  means you're asking losetup
to print info on a loopback device called /dev/sdb3.

loop: can't get info on device /dev/sdb3: Inappropriate ioctl for device


 IDK how you got it to print
 
losetup: /dev/sdc2: warning: file smaller than 512 bytes, the loop
device maybe be useless or invisible for system tools



-- 
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@cor , des.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BC
