Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52629 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752229Ab2LWWDq (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 23 Dec 2012 17:03:46 -0500
Date: Sun, 23 Dec 2012 23:03:35 +0100
From: Karel Zak <kzak@redhat.com>
To: Dave Reisner <dreisner@archlinux.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Require explicit call to emergency_do_mounts
Message-ID: <20121223220335.GC25576@x2.redhat.com>
References: <1356277410-29666-1-git-send-email-dreisner@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1356277410-29666-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Dec 23, 2012 at 10:43:30AM -0500, Dave Reisner wrote:
> Keeping these functions in lib/ with constructor and destructor
> attributes causes the code to be run in invocation of a large number of
> programs in the util-linux tree. Remove the attributes and call it
> explicitly from sulogin, the only place where it (currently) makes sense
> to be called from.

 Ah, I've been faster then my fetchmail -- so I have pushed a
 little different patch.

> I'd further vote that the flag which enables this behavior be turned off
> by default.

 Good point, I think for mainstream distros it's unnecessary. 

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
