Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:54108 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751189AbbAHJNI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 8 Jan 2015 04:13:08 -0500
Date: Thu, 8 Jan 2015 10:13:02 +0100
From: Karel Zak <kzak@redhat.com>
To: Peter Cordes <peter@cordes.ca>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] fallocate: create mode 0666, that's what umask is for
Message-ID: <20150108091302.GI15715@x2.net.home>
References: <1419915737-27310-1-git-send-email-peter@cordes.ca>
 <20150107090354.GA15715@x2.net.home>
 <20150107224626.GS29504@cordes.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150107224626.GS29504@cordes.ca>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jan 07, 2015 at 06:46:26PM -0400, Peter Cordes wrote:
>  Thanks for taking a look at my patches.  I haven't had any new ideas
> for my fallocate --dig-holes patch.  My local copy does what I want it

 I didn't look at your second patch yet. I'd like to finalize stuff for 
 v2.26-rc1 and it seems that with some invasive and large changes we
 can wait for v2.27.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
