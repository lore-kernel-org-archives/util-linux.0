Return-Path: util-linux-owner@vger.kernel.org
Received: from mail5.vodafone.ie ([213.233.128.176]:20505 "EHLO
	mail5.vodafone.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbaAXBA6 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 23 Jan 2014 20:00:58 -0500
Message-ID: <52E1BB47.80609@draigBrady.com>
Date: Fri, 24 Jan 2014 01:00:55 +0000
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
MIME-Version: 1.0
To: Rodrigo Campos <rodrigo@sdfg.com.ar>
CC: util-linux@vger.kernel.org
Subject: Re: drill: Make a file sparse without using extra disk space
References: <20140123212813.GE20054@sdfg.com.ar>
In-Reply-To: <20140123212813.GE20054@sdfg.com.ar>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 01/23/2014 09:28 PM, Rodrigo Campos wrote:
> Hi!
> 
> I've written a small simple tool to make a file sparse without using extra disk
> space, it just digs holes on the file when possible. To dig the hole uses the
> Linux-specific fallocate(2) syscall with FALLOC_FL_PUNCH_HOLE. So, also, it only
> works on some file-systems.
> 
> Do you think that util-linux would be a good place for such a simple, linux-only
> program ? The case I see it can be useful is to use on VM images file backed (or
> I wrote it with this in mind, at least :)).
> 
> The code is quite simple, it's written in plain C (C99 actually) and doesn't
> have any external dependencies. You can see the gitweb here:
> 
> 	http://sdfg.com.ar/git/?p=drill.git
> 
> or just clone it from:
> 
> 	git://sdfg.com.ar/drill.git
> 
> 
> Given that there is a fallocate tool that uses the other mode of fallocate(2)
> already, all the detection for fallocate is already there. So it should, I
> guess, be easy to integrate to the code-base, adding also the #ifndef
> fallocate.c has and that compatibility stuff.
> 
> Also, as you can see in the commits, I just started it some days ago. So if
> you think it should have some other feature, or something else, please let me
> know :)
> 
> I'm not sure how this work, but I can write a patch against util-linux if you
> think it can be added. If you know there is something I should particulary take
> into account for that, I will really appreciate if you let me know :)
> 
> 
> 
> 
> Thanks a lot,
> Rodrigo
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

This functionality is useful.
Would it be possible to just add to fallocate with --punch-hole=sparse or something?
Also dd has the conv=sparse option, so maybe this functionality can be added there.
We're currently discussing that on the GNU coreutils mailing list.

thanks,
Pádraig.

