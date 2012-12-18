Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56838 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932067Ab2LRPXz (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 18 Dec 2012 10:23:55 -0500
Date: Tue, 18 Dec 2012 16:23:11 +0100
From: Karel Zak <kzak@redhat.com>
To: Werner Fink <werner@suse.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 4/5] sulogin: mount temporary /dev and /proc if not found
Message-ID: <20121218152311.GA13554@x2.net.home>
References: <20121207170118.GG603@rampage>
 <1355142431-8199-1-git-send-email-werner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1355142431-8199-1-git-send-email-werner@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Dec 10, 2012 at 01:27:10PM +0100, Werner Fink wrote:
>  configure.ac   |   10 +++++++++
>  lib/consoles.c |   66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 76 insertions(+)

 Note that I have applied this (fixed) version of the patch.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
