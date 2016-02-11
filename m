Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59324 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750750AbcBKKPH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 11 Feb 2016 05:15:07 -0500
Date: Thu, 11 Feb 2016 11:15:05 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/3] swapon: move function arguments to control structure
Message-ID: <20160211101505.xjmyys5c53ryo6nb@ws.net.home>
References: <1454420410-654-1-git-send-email-kerolasa@iki.fi>
 <1454420410-654-3-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454420410-654-3-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Feb 02, 2016 at 01:40:09PM +0000, Sami Kerola wrote:
> This makes reading what the code does easier. 

I'm not sure in all cases, for example ->dev_canonical and ->canonic make
things more messy. I'll revert part of the patch.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
