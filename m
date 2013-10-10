Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39653 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752193Ab3JJLK4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 10 Oct 2013 07:10:56 -0400
Date: Thu, 10 Oct 2013 13:10:45 +0200
From: Karel Zak <kzak@redhat.com>
To: Craig <util-linux_contact@magister.com.au>
Cc: util-linux@vger.kernel.org
Subject: Re: ***Urgent***!  Fdisk: GPT support utterly breaks hybrid MBR;
 *must* have disable option! :(
Message-ID: <20131010111045.GA29199@x2.net.home>
References: <alpine.LFD.2.03.1310092211290.7406@aslan.magister.com.au>
 <20131009141628.GB940@x2.net.home>
 <alpine.LFD.2.02.1310101129260.4624@trabz.zntvfgre.pbz.nh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LFD.2.02.1310101129260.4624@trabz.zntvfgre.pbz.nh>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Oct 10, 2013 at 11:39:36AM +1100, Craig wrote:
> Yes; _exactly_ what is needed, plus IMO a switch from within fdisk's menu
> system (Expert?) that would allow switching between GPT and MBR (or anything
> else that might be present).

 Yes, but now (for v2.24) it's too late. I'd like to have a more
 robust way to switch between GPT and MBR modification. (I already
 have some patches, but it still requires some work.)

 Note that in v2.24 the GPT code in fdisk does not allow to write hybrid
 GPT, the support is read-only.

   Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
