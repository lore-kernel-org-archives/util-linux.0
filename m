Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:62310 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751769AbaEGHKh (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 7 May 2014 03:10:37 -0400
Date: Wed, 7 May 2014 09:10:23 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 00/15] cytune modernization
Message-ID: <20140507071023.GT5962@x2.net.home>
References: <1399218596-21321-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1399218596-21321-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, May 04, 2014 at 04:49:41PM +0100, Sami Kerola wrote:
> Couple days ago Benno Schulenberg mentioned email with subject 'cytune:
> misnamed long options' usage() being a bit misleading that I concurred
> with note that the cytune could probably be improved various ways.  This
> patch set proposes the improvements I had in mind.
> 
> Please notice that I do not have hardware to test the cytune command, so
> testing after the changes did not happen.  All I can say I tried to be
> careful not to break program logic, and hopefully that will work.

 Frankly, I'm a little bit nervous from all the invasive cytune
 changes, because we have no way how to test it. It's fine to change
 warning/error messages, usage() or so, but the another changes
 without tests seem risky.

 The question is if we have to maintain HW specific util, particularly
 when the HW seem rarely available (ebay only?). Maybe the best would
 be to drop cytune.c from u-l and suggest to possible users to use
 old u-l versions or maintain cytune.c outside u-l.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
