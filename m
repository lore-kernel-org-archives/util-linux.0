Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41664 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756052Ab3C1JiE (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 28 Mar 2013 05:38:04 -0400
Date: Thu, 28 Mar 2013 10:37:54 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 00/10] [pull] bash-completion
Message-ID: <20130328093754.GA24678@x2.net.home>
References: <1364422072-23552-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1364422072-23552-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Mar 27, 2013 at 10:07:42PM +0000, Sami Kerola wrote:
> > Some FIXME's are slightly more difficult to fix.  For example I do not
> > know how to get list of possible TERM values distribution agnostic way. 

 Well, I think we can start with some nice hardcoded list..

> > And with 'wdctl' I have no how to determine flags.  Same goes for SELinux

    wdctl --flags-only -o FLAG 
    
 returns currently supported flags (by the device), the complete list of 
 the flags is:

	CARDRESET
	EXTERN1
	EXTERN2
	FANFAULT
	KEEPALIVEPING
	MAGICCLOSE
	OVERHEAT
	POWEROVER
	POWERUNDER
	PRETIMEOUT
	SETTIMEOUT
	ALARMONLY

I think it's fine to use this hardcoded list.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
