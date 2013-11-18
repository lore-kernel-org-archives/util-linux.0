Return-Path: util-linux-owner@vger.kernel.org
Received: from brent.tribalogic.net ([78.86.109.144]:57074 "EHLO
	brent.tribalogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300Ab3KRRsT (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 18 Nov 2013 12:48:19 -0500
Message-ID: <528A5134.8070004@colin.guthr.ie>
Date: Mon, 18 Nov 2013 17:41:08 +0000
From: Colin Guthrie <gmane@colin.guthr.ie>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH] su: Remove the impossible -C option to request the same
 session.
References: <1384785840-31957-1-git-send-email-colin@mageia.org> <20131118164252.GA5572@x2.net.home>
In-Reply-To: <20131118164252.GA5572@x2.net.home>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

'Twas brillig, and Karel Zak at 18/11/13 16:42 did gyre and gimble:
> On Mon, Nov 18, 2013 at 02:44:00PM +0000, Colin Guthrie wrote:
>> It's impossible to pass this argument so it is pointless to keep the
>> code to support it.
> 
>  Really? See struct option longopts[] and --session-command.

Gah, sorry! Could have sworn I'd searched for the 'C' but must have been
fat fingers while on a bumpy train.

Sorry 'bout that.

Col

-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited http://www.tribalogic.net/
Open Source:
  Mageia Contributor http://www.mageia.org/
  PulseAudio Hacker http://www.pulseaudio.org/
  Trac Hacker http://trac.edgewall.org/
