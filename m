Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33114 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751416Ab2KEQnt (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 5 Nov 2012 11:43:49 -0500
Date: Mon, 5 Nov 2012 17:43:39 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 02/13] ipcs: add /proc and /sys path definitions
Message-ID: <20121105164339.GB3799@x2.net.home>
References: <1350246145-10600-1-git-send-email-kerolasa@iki.fi>
 <1350246145-10600-3-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1350246145-10600-3-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Oct 14, 2012 at 09:22:14PM +0100, Sami Kerola wrote:
> +#define _PATH_PROC_IPC_MSG	"/proc/sys/kernel/sem"
                          ^^^                    ^^^^
            :-)

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
