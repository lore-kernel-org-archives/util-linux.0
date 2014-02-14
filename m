Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37691 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752334AbaBNNbE (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 14 Feb 2014 08:31:04 -0500
Date: Fri, 14 Feb 2014 14:30:59 +0100
From: Karel Zak <kzak@redhat.com>
To: Rodrigo Campos <rodrigo@sdfg.com.ar>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v3] fallocate: Add "--dig-holes" option
Message-ID: <20140214133059.GC28125@x2.net.home>
References: <1390747439-14086-1-git-send-email-rodrigo@sdfg.com.ar>
 <1390748810-14517-1-git-send-email-rodrigo@sdfg.com.ar>
 <20140214104756.GA28125@x2.net.home>
 <20140214130752.GD7927@sdfg.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140214130752.GD7927@sdfg.com.ar>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Feb 14, 2014 at 01:07:53PM +0000, Rodrigo Campos wrote:
> On Fri, Feb 14, 2014 at 11:47:56AM +0100, Karel Zak wrote:
> > > +	for (off_t offset = 0; offset + hole_size <= end; offset += buf_len) {
> >          ^^^^^^^^^^^
> > 
> >  Yes it's expected by C standards, but it sucks. Don't use it, it's
> >  reader's nightmare.
> 
> Ohh, I didn't know. Can I ask why ?
> 
> And what type should I use ? loff_t ? Why is this better ?
> 
> (just curious, I want to understand :))

 Ah, my mistake.. I have no talked about "off_t", but about variables
 declarations. It's always better to have declarations at the begin of
 the code block or function. 

    for (int i = 0; ... )

 is C++ism that for unknown crazy reason has been accepted by C
 compilers/standards (C99). 

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
