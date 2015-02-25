Return-Path: util-linux-owner@vger.kernel.org
Received: from mta04.eastlink.ca ([24.224.136.10]:45469 "EHLO
	mta04.eastlink.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226AbbBYCtf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 24 Feb 2015 21:49:35 -0500
Received: from cmgw05.eastlink.ca ([71.7.199.171])
 by mta04.eastlink.ca (Oracle Communications Messaging Exchange Server
 7u4-21.01 64bit (built Feb 16 2011))
 with ESMTP id <0NKA00LM989FQV30@mta04.eastlink.ca> for
 util-linux@vger.kernel.org; Tue, 24 Feb 2015 22:49:33 -0400 (AST)
Date: Tue, 24 Feb 2015 22:49:33 -0400
To: Bill Pemberton <wfp5p@worldbroken.com>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 0/8] fix spelling/typos in man pages
Message-id: <20150225024933.GT3933@cordes.ca>
References: <1424798123-11044-1-git-send-email-wfp5p@worldbroken.com>
 <1424812410.4082705.231939245.08843DF4@webmail.messagingengine.com>
 <54ECFEC0.3050702@worldbroken.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
In-reply-to: <54ECFEC0.3050702@worldbroken.com>
From: Peter Cordes <peter@cordes.ca>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Feb 24, 2015 at 05:44:16PM -0500, Bill Pemberton wrote:
> Ok, I'm used to 1 patch 1 fix.  While they're all spelling/typos they're  
> not the same word/typo.

 That makes sense for code, esp. to make regressions bisectable.  It
just bloats the revision history for docs.  Single-word fixes, even
scattered across multiple files, would be easier to look at as one
commit in the git log.

-- 
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@cor , des.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BC
