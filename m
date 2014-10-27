Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43727 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751180AbaJ0K7l (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 27 Oct 2014 06:59:41 -0400
Date: Mon, 27 Oct 2014 11:59:34 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: JWP <elseifthen@gmx.com>, Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 2/5] hwclock: clean up message periods/full stops
Message-ID: <20141027105934.GG10134@x2.net.home>
References: <5449BE57.9040203@gmx.com>
 <1414150431.840372.182833341.74402120@webmail.messagingengine.com>
 <544A4817.3070406@gmx.com>
 <20141024125939.GD10134@x2.net.home>
 <544A795B.8090301@gmx.com>
 <1414184287.962524.183013401.569326CF@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1414184287.962524.183013401.569326CF@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Oct 24, 2014 at 10:58:07PM +0200, Benno Schulenberg wrote:
> 
> On Fri, Oct 24, 2014, at 18:07, JWP wrote:
> > So what is the util-linux position on message punctuation in general, and
> > line termination specifically?  The documentation seem to imply not using any.
> 
> The current situation is a mess.  And the documentation does not say
> anything about what error messages, status reports, and imperatives

I don't think so, but it would be nice to have
Documentation/howto-messages.txt.

> to the user should look like.  The general style seems to be:
> 
> 1) Error messages (anything that is preceded by the program name
> followed by a colon and a space, in thise case "hwclock: ") start with
> a lowercase letter and do not end in a period, nor use any period.

The preferred way to print error and warning messages is err() and
warn() (or errx() and warnx()). 

> 2) Status reports and imperatives to the user use full sentences:
> they start with a capital letter and end in a period.

yep.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
