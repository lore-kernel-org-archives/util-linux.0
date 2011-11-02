Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38974 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932374Ab1KBPah (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 2 Nov 2011 11:30:37 -0400
Date: Wed, 2 Nov 2011 16:30:10 +0100
From: Karel Zak <kzak@redhat.com>
To: Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] dmesg: fix printing of multibyte characters
Message-ID: <20111102153010.GA3606@nb.net.home>
References: <1320161382-12677-1-git-send-email-petr.uzel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1320161382-12677-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Nov 01, 2011 at 04:29:42PM +0100, Petr Uzel wrote:
>  sys-utils/dmesg.c |   16 ++++++++--------
>  1 files changed, 8 insertions(+), 8 deletions(-)

[...]

> +		i += len - 1;

 Oh... so stupid bug. Thanks! Applied.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
