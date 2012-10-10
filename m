Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:50984 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753014Ab2JJJ0O (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Wed, 10 Oct 2012 05:26:14 -0400
Date: Wed, 10 Oct 2012 11:26:12 +0200
From: Karel Zak <kzak@redhat.com>
To: Mike Frysinger <vapier@gentoo.org>
Cc: util-linux-ng@vger.kernel.org
Subject: Re: [PATCH] md5: fix strict aliasing warnings
Message-ID: <20121010092612.GF28457@x2.net.home>
References: <1349842958-6533-1-git-send-email-vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349842958-6533-1-git-send-email-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Oct 10, 2012 at 12:22:38AM -0400, Mike Frysinger wrote:
>  lib/md5.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

 Applied, thanks! My TODO list shorter now :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
