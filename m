Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:32548 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752146Ab2GZKHL (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 26 Jul 2012 06:07:11 -0400
Date: Thu, 26 Jul 2012 12:07:00 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/27] preparation to release some time soon
Message-ID: <20120726100700.GB12592@x2.net.home>
References: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jul 25, 2012 at 09:15:18PM +0200, Sami Kerola wrote:
> I think in future I will send the pull requests format 'git send-email 
> --compose' cover letter.  Without doubt doing this is noisier than  
> sending only pull request, but hopefully makes review more transparent.
> Lets try for few times, and if this works the method should probably be
> documented in Documentation/howto-contribute.txt as preferred way to
> send pull request.  What do you think, does this make sense, help
> review, etc, comments?

 For me it's more usable to have patches in mailing list, because
 it's more easy to control which patches I'll apply by git-am.

 The git-pull is excellent if you merge something complete without
 extra changes, otherwise you need to pull to non-master branch and
 cherry-pick only wanted patches.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
