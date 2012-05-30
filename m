Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:28396 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754532Ab2E3Npt (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 30 May 2012 09:45:49 -0400
Date: Wed, 30 May 2012 15:42:19 +0200
From: Karel Zak <kzak@redhat.com>
To: Ludwig Nussel <ludwig.nussel@suse.de>
Cc: util-linux@vger.kernel.org
Subject: Re: su(1) wish list
Message-ID: <20120530134219.GE374@x2.net.home>
References: <4FBE3059.3030806@suse.de>
 <20120529090609.GO3757@x2.net.home>
 <20120529113418.GB374@x2.net.home>
 <4FC4BDE1.7000303@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4FC4BDE1.7000303@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 29, 2012 at 02:15:29PM +0200, Ludwig Nussel wrote:
> Karel Zak wrote:
> > On Tue, May 29, 2012 at 11:06:09AM +0200, Karel Zak wrote:
> >> On Thu, May 24, 2012 at 02:58:01PM +0200, Ludwig Nussel wrote:
> >>> I've also filed a pull request on github:
> >>> https://github.com/karelzak/util-linux/pull/10
> >>
> >>  Merged, but you forgot man page ;-) I don't think we need whole
> >>  history for the man page, so just copy and edit any existing su.1
> >>  man page and send it as a patch.
> 
> The su man page from coreutils is pretty brief. More docu is in the
> info page. The license is the FDL, would that be ok or would a new
> man page from scratch be better? Or maybe the one from shadow-utils?

 It should be pretty simple to write a new man page from scratch --
 as an example see some new man pages in util-linux (e.g. lsblk, lslocks, ...)

> No idea why it is different. Probably legacy stuff. I see no reason
> why to use different values than login though.

 OK, I'll (or Sami in his cleanup) will change it. Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
