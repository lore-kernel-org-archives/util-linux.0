Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45417 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752950AbaKSNTf (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 19 Nov 2014 08:19:35 -0500
Date: Wed, 19 Nov 2014 14:19:27 +0100
From: Karel Zak <kzak@redhat.com>
To: Andreas Henriksson <andreas@fatal.se>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] lib/colors: fix double free on error path
Message-ID: <20141119131927.GR6704@x2.net.home>
References: <1416395016-17902-1-git-send-email-andreas@fatal.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1416395016-17902-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Nov 19, 2014 at 12:03:35PM +0100, Andreas Henriksson wrote:
>  lib/colors.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

 Applied, thanks!

    Karel
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
