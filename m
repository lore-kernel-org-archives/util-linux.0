Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:11522 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755955Ab3JNNIZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Oct 2013 09:08:25 -0400
Date: Mon, 14 Oct 2013 15:08:21 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [patches] equalizing a few error messages and polishing some man
 pages
Message-ID: <20131014130821.GF28914@x2.net.home>
References: <1381696131.25361.33507989.56047B16@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381696131.25361.33507989.56047B16@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Oct 13, 2013 at 10:28:51PM +0200, Benno Schulenberg wrote:
> The fifth patch slightly improves the spelling and grammar of the
> 2.24 ReleaseNotes, and mentions only those PO files which were
> actually updated during this cycle.  Karel, judging from the rc2
> announcement, you have a more recent version of this file.  If
> you wish me to resolve any conflicts, please push your version.

 The problem is that the details in the ReleaseNotes are generated
 from git log, so I have applied only begin of the patch (release
 highlights).

 It seems that I have applied non-updated .po stuff for some languages
 during work on the release. It's no problem, but it's visible in the
 log.

 (And note that I also use po files from stable (e.g. 2.23.2) releases
  for the next release -rc1.)


 Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
