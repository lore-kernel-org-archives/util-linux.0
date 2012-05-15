Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55091 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755139Ab2EOJWB (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 15 May 2012 05:22:01 -0400
Date: Tue, 15 May 2012 11:21:37 +0200
From: Karel Zak <kzak@redhat.com>
To: Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 1/3] mkswap: use is_mounted() instead of check_mount()
Message-ID: <20120515092137.GC8268@x2.net.home>
References: <1336909472-12277-1-git-send-email-petr.uzel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1336909472-12277-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, May 13, 2012 at 01:44:30PM +0200, Petr Uzel wrote:
>  disk-utils/Makefile.am |    1 +
>  disk-utils/mkswap.c    |   26 ++------------------------
>  2 files changed, 3 insertions(+), 24 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
