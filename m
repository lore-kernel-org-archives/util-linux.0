Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56847 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752337AbaE0OMK (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 27 May 2014 10:12:10 -0400
Date: Tue, 27 May 2014 16:12:03 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org,
        =?iso-8859-1?Q?P=E1draig?= Brady <P@draigbrady.com>
Subject: Re: [PATCH] cal: all output must use my_putstring
Message-ID: <20140527141203.GG2968@x2.net.home>
References: <201405271250.41256.sweet_f_a@gmx.de>
 <1401196025-7090-1-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1401196025-7090-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 27, 2014 at 03:07:05PM +0200, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
> 
> Replace all puts, fputs and printf calls by my_putstring() because
> we don't want to mix different output channels (buffers).

 Oh, this is well know problem I fixed one year ago, see
 e66ba1bfaf070682e26c1a53e64af1088fea56bc. 
 
 It seems the problem was re-introduced during Sami's cal(1) refactoring.
 Thanks! I'm going to push it.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
