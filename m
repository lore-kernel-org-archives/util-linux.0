Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:12984 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752940Ab3K0VJT (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 27 Nov 2013 16:09:19 -0500
Date: Wed, 27 Nov 2013 22:09:09 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: Marc MERLIN <marc@merlins.org>, util-linux@vger.kernel.org
Subject: Re: Severe fdisk problem leading to data loss?
Message-ID: <20131127210909.GU5572@x2.net.home>
References: <20131118102051.GA31813@merlins.org>
 <20131124135226.GH11389@merlins.org>
 <20131125103124.GQ5572@x2.net.home>
 <529605B7.3020903@ubuntu.com>
 <20131127145840.GB32483@x2.net.home>
 <52963910.60800@ubuntu.com>
 <20131127200724.GT5572@x2.net.home>
 <529653DC.2020600@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <529653DC.2020600@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Nov 27, 2013 at 03:19:40PM -0500, Phillip Susi wrote:

> > I'll probably add a warning to fdisk to inform users about the zero
> >  type problem.
> 
> It already does warn you when you set the type to 0.

 Unfortunately not in v2.24, fixed now.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
