Return-Path: util-linux-owner@vger.kernel.org
Received: from mta03.eastlink.ca ([24.224.136.9]:33917 "EHLO mta03.eastlink.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752343AbbBWLT1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 23 Feb 2015 06:19:27 -0500
Received: from cmgw04.eastlink.ca ([71.7.199.170])
 by mta03.eastlink.ca (Oracle Communications Messaging Exchange Server
 7u4-21.01 64bit (built Feb 16 2011))
 with ESMTP id <0NK80066T0CAXEV0@mta03.eastlink.ca> for
 util-linux@vger.kernel.org; Mon, 23 Feb 2015 07:19:24 -0400 (AST)
Received: from peter by llama.cordes.ca with local (Exim 3.36 #1 (Debian))
	id 1YPr2q-0008Ep-00	for <util-linux@vger.kernel.org>; Mon,
 23 Feb 2015 07:19:24 -0400
Date: Mon, 23 Feb 2015 07:19:24 -0400
To: util-linux@vger.kernel.org
Subject: Re: [PATCH] docs: fstab(5) grammar / English fixes,
 and some other	updates
Message-id: <20150223111924.GP3933@cordes.ca>
References: <1424689834-29236-1-git-send-email-peter@cordes.ca>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
In-reply-to: <1424689834-29236-1-git-send-email-peter@cordes.ca>
From: Peter Cordes <peter@cordes.ca>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I meant to write an intro for that, but accidentally used
git send-email in a way that just fired off the patch.

 I've never editted man pages before, so hopefully I didn't do anything
silly or unconventional with macros.  I looked over man-pages(7) and
man(7), but I just found  .si 1  in mount(8), and copied it without
finding any explanation of exactly what it does.

 So when reviewing, check my man-page syntax as well as the actual
words, please.  :)

 IDK if I was too chatty in some places.
 
 I think in places where I chopped stuff down, the meaning is still
perfectly clear.  Faster to grok = better.

-- 
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@cor , des.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BC
