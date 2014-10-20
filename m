Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:28246 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751274AbaJTMLA (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 20 Oct 2014 08:11:00 -0400
Date: Mon, 20 Oct 2014 14:10:48 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/4] eject: move unreachable code to preprocessor #else
 block [smatch scan]
Message-ID: <20141020121048.GC8057@x2.net.home>
References: <1413407968-2289-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1413407968-2289-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Oct 15, 2014 at 10:19:25PM +0100, Sami Kerola wrote:
> eject.c:466 toggle_tray() info: ignoring unreachable code.

 All 4 patches applied. Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
