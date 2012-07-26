Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:26131 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752262Ab2GZPVm (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 26 Jul 2012 11:21:42 -0400
Date: Thu, 26 Jul 2012 17:21:39 +0200
From: Karel Zak <kzak@redhat.com>
To: Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>, dave@gnu.org
Subject: Re: [PATCH 5/5] tests: update fdisk test (default output format
 changed)
Message-ID: <20120726152139.GD2386@x2.net.home>
References: <1343311468-20206-1-git-send-email-petr.uzel@suse.cz>
 <1343311468-20206-5-git-send-email-petr.uzel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343311468-20206-5-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jul 26, 2012 at 04:04:28PM +0200, Petr Uzel wrote:
>  tests/expected/fdisk/align-512-4K           |    3 +--
>  tests/expected/fdisk/align-512-4K-63        |    3 +--
>  tests/expected/fdisk/align-512-4K-md        |    6 ++----
>  tests/expected/fdisk/align-512-512          |    3 +--
>  tests/expected/fdisk/align-512-512-topology |    3 +--
>  tests/expected/fdisk/oddinput               |    2 +-
>  6 files changed, 7 insertions(+), 13 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
