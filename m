Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36707 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753064AbaJGJ4v (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 7 Oct 2014 05:56:51 -0400
Date: Tue, 7 Oct 2014 11:56:47 +0200
From: Karel Zak <kzak@redhat.com>
To: "Dale R. Worley" <worley@alum.mit.edu>
Cc: util-linux@vger.kernel.org
Subject: Re: Error in losetup man page
Message-ID: <20141007095647.GD8057@x2.net.home>
References: <201410031430.s93EUddT014847@hobgoblin.ariadne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201410031430.s93EUddT014847@hobgoblin.ariadne.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Oct 03, 2014 at 10:30:39AM -0400, Dale R. Worley wrote:
> On Fedora 19, the man page for losetup says:
> 
>        Delete all used loop devices:
> 
>             losetup -D
> 
> That should be "Delete all *unused* loop devices:", I'm sure.

"used" means loop devices that have backing file, I have replaced the
text with "Detach all associated loop devices:"

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
