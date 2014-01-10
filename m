Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52836 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691AbaAJM5M (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 10 Jan 2014 07:57:12 -0500
Date: Fri, 10 Jan 2014 10:57:07 -0200
From: Carlos Maiolino <cmaiolino@redhat.com>
To: util-linux@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] Update ext3/4 mount options
Message-ID: <20140110125706.GA14692@orion.maiolino.org>
References: <1389288890-17282-1-git-send-email-cmaiolino@redhat.com>
 <1389299455.29292.68757293.7B539718@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1389299455.29292.68757293.7B539718@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Benno,

thanks for the fixes, despite the journal line, where 'abort the journal' is the
correct meaning, I'm going to apply the other fixes.

On Thu, Jan 09, 2014 at 09:30:55PM +0100, Benno Schulenberg wrote:
> 
> On Thu, Jan 9, 2014, at 18:34, Carlos Maiolino wrote:
> > -have changed, this option allows the user to specify
> > +have changed, these options allows the user to specify
> 
> s/allows/allow/
> 
> > +identified through euther its new major/minor numbers encoded
> > +in devnum, or via a path to the device.
> 
> s/through euther/either through/
> (swapped, otherwise the "via" needs to be dropped)
> 
> > +Abort the journal if an error occurs in a file data buffer in ordered mode.
> 
> "Abort loading the journal..." maybe?
> 
> > +The lazy itable init code will wait n times the number of milliseconds it took
> > +to zero out the previous block group's inode table. This minimizes the impact on
> > +the system performance while filesystem's inode table is being initialized.
> 
> s/the system/system/
> s/while/while the/
> 
> > +useful in memory constrained environments, where a very large directory can
> 
> better: memory-constrained
> 
> > +cause severe performance problems or even provoke the Out Of Memory killer. (For
> > +example, if there is only 512mb memory available, a 176mb directory may
> > +seriously cramp the system's style).
> 
> s/)./.)/
> 
> Benno
> 
> -- 
> http://www.fastmail.fm - Choose from over 50 domains or use your own
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ext4" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Carlos
