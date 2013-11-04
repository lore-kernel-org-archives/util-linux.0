Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60397 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752018Ab3KDN7g (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 4 Nov 2013 08:59:36 -0500
Date: Mon, 4 Nov 2013 14:59:32 +0100
From: Karel Zak <kzak@redhat.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: util-linux@vger.kernel.org, jason.cipriani@gmail.com
Subject: Re: [PATCH] blkdiscard: BLKSSZGET fills in an int, not a uint64
Message-ID: <20131104135932.GB21311@x2.net.home>
References: <20131102234451.GA10255@thunk.org>
 <1383435966-29337-1-git-send-email-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383435966-29337-1-git-send-email-tytso@mit.edu>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Nov 02, 2013 at 07:46:06PM -0400, Theodore Ts'o wrote:
>  sys-utils/blkdiscard.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

 Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
