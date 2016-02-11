Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34183 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751779AbcBKLKR (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 11 Feb 2016 06:10:17 -0500
Date: Thu, 11 Feb 2016 12:10:13 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 3/3] swapon: do not run execvp() calls when swapon is
 setuid binary
Message-ID: <20160211111013.ah6atjvgwgwyeh77@ws.net.home>
References: <1454420410-654-1-git-send-email-kerolasa@iki.fi>
 <1454420410-654-4-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454420410-654-4-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Feb 02, 2016 at 01:40:10PM +0000, Sami Kerola wrote:
> swapon(8) is not expected to be setuid binary, but if it is try to avoid
> obvious security vulnerability of executing user preferred mkswap file as
> someone else, such as root.

I have replaced this with code to drop permissions, so it executes
mkswap, but as non-root and all depends on mkswap and file/device
perms.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
