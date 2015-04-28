Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59327 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933028AbbD1Kqr (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 28 Apr 2015 06:46:47 -0400
Date: Tue, 28 Apr 2015 12:46:43 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/3] hwclock: remove unneeded stuff from the man-page
 header
Message-ID: <20150428104643.GU27969@ws.net.home>
References: <1426624493-2464-1-git-send-email-bensberg@justemail.net>
 <1426624493-2464-2-git-send-email-bensberg@justemail.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426624493-2464-2-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Mar 17, 2015 at 09:34:52PM +0100, Benno Schulenberg wrote:
> -.\" -------------------------------
> -.\" Included for troff portability.
> -.\" Continuation line for .TP header.
> -.de TQ
> -.  br
> -.  ns
> -.  TP \\$1\" no doublequotes around argument!
> -..

I have little bit clean upped the man header and removed the TQ
fallback. We already use TQ on another places for years and nobody
complains, so I guess it's unnecessary (or we have to fix all the man
page rather than hwclock.8 only).

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
