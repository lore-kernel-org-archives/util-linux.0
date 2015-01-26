Return-Path: util-linux-owner@vger.kernel.org
Received: from resqmta-po-03v.sys.comcast.net ([96.114.154.162]:36803 "EHLO
	resqmta-po-03v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751092AbbAZD3Y (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 25 Jan 2015 22:29:24 -0500
From: worley@alum.mit.edu (Dale R. Worley)
To: Lucio Crusca <lucio@sulweb.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [BUG] losetup: support for physical devices
In-Reply-To: <m96ard$qu8$1@ger.gmane.org> (lucio@sulweb.org)
Date: Sun, 25 Jan 2015 22:21:09 -0500
Message-ID: <87mw56jkgq.fsf@hobgoblin.ariadne.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Lucio Crusca <lucio@sulweb.org> writes:
> During a disaster recovery I found that losetup either 
>
> 1. does not support creating loop devices that target physical devices. In 
> this case I think there exists a compelling reason to support them 
> (http://serverfault.com/questions/659484) and this bug report is a wishlist 
> bug 
>
> or 
>
> 2. it does support physical devices, but it is an undocumented feature (at 
> least in the manpage) and the warning it issues is misleading beacuse it 
> makes you think it doesn't support them ("losetup: /dev/sdc2: warning: file 
> smaller than 512 bytes, the loop device maybe be useless or invisible for 
> system tools"). In this case this could be a documentation bug.
>
> I haven't tested which of the two possibilities is the real situation, but 
> I'm pretty sure you already know.

I don't recall what I've done that convinced me, but I'm *sure* that you
can do

    losetup -o [offset] {-f[--show]|loopdev} /dev/sdXXX

This is implicit throughout Linux, because any block device is also a
"file", and can be read/written as such.  (You just can't change its
size.)

What command are you executing?  What error are you seeing?

Dale
