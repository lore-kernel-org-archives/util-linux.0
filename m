Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53169 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751643Ab2KMPxY (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 13 Nov 2012 10:53:24 -0500
Date: Tue, 13 Nov 2012 16:53:18 +0100
From: Karel Zak <kzak@redhat.com>
To: Dave Reisner <dreisner@archlinux.org>
Cc: util-linux@vger.kernel.org, Lukas Jirkovsky <l.jirkovsky@gmail.com>
Subject: Re: [PATCH] umount: add -R, --recursive option
Message-ID: <20121113155318.GA2467@x2.net.home>
References: <1352311348-2947-1-git-send-email-dreisner@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1352311348-2947-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Nov 07, 2012 at 01:02:28PM -0500, Dave Reisner wrote:
>  sys-utils/umount.8 |  4 +++
>  sys-utils/umount.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 81 insertions(+), 4 deletions(-)

 Applied (with some small changes), thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
