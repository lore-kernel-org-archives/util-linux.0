Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40958 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965315AbcCPNLK (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 16 Mar 2016 09:11:10 -0400
Date: Wed, 16 Mar 2016 14:11:07 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org, Andreas Henriksson <andreas@fatal.se>
Subject: Re: [PATCH] tests: fix fdisk/bsd for alpha
Message-ID: <20160316131107.4orceajqir34wavj@ws.net.home>
References: <1458088844-23523-1-git-send-email-sweet_f_a@gmx.de>
 <20160316113741.cdm4hrufcoiki5ae@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160316113741.cdm4hrufcoiki5ae@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Mar 16, 2016 at 12:37:41PM +0100, Karel Zak wrote:
> On Wed, Mar 16, 2016 at 01:40:44AM +0100, Ruediger Meier wrote:
> > BTW it was a bad idea to use md5sum. In case of failure it
> > would be much easier to debug hexdump diffs. Now it's nearly
> > impossible to collect all these exotic hexdumps.
> 
>  I'll try to prepare a new test with hexdump, PPC[64] LE/BE should 
>  not be a problem. The rest we can gather later.

 Done, the last missing is Aplha (with special fields in the label...). 
 
 The original md5 based test is still in the tree to make a way how to
 verify Alpha output. Maybe it's overkill and we can remove the test.
 Not sure.

 Test it, try it, send patches ;)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
