Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35823 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751282AbcBKLKm (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 11 Feb 2016 06:10:42 -0500
Date: Thu, 11 Feb 2016 12:10:40 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/3] pull: add swapon control structure
Message-ID: <20160211111040.zafd5mztfy2ttsil@ws.net.home>
References: <1454420410-654-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454420410-654-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Feb 02, 2016 at 01:40:07PM +0000, Sami Kerola wrote:
> Sami Kerola (3):
>   swapon: add control struct
>   swapon: move function arguments to control structure
>   swapon: do not run execvp() calls when swapon is setuid binary

Merged with changes.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
