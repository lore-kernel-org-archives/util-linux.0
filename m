Return-Path: util-linux-owner@vger.kernel.org
Received: from sender1.zohomail.com ([74.201.84.158]:34610 "EHLO
	sender1.zohomail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbbCMUhf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 13 Mar 2015 16:37:35 -0400
Message-ID: <550346FA.3060006@zoho.com>
Date: Fri, 13 Mar 2015 21:22:18 +0100
From: =?windows-1252?Q?=C1ngel_Gonz=E1lez?= <ingenit@zoho.com>
MIME-Version: 1.0
To: Ruediger Meier <sweet_f_a@gmx.de>
CC: =?windows-1252?Q?P=E1draig_Brady?= <P@draigbrady.com>,
        util-linux@vger.kernel.org
Subject: Re: tailf, really needed?
References: <201503131000.29307.sweet_f_a@gmx.de> <5502CBFF.6090405@draigBrady.com> <201503131402.30431.sweet_f_a@gmx.de>
In-Reply-To: <201503131402.30431.sweet_f_a@gmx.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 13/03/15 14:02, Ruediger Meier wrote:
> BTW I think there could be a minor improvement for coreutils tail for
> the cases "file is empty" or "-n 0". Maybe we could skip opening the
> file one time at the beginning. So that "tail -n0 -f logfile" would
> really never access the file unless it grows.
>
> cu,
> Rudi

I suspect that might break filesystems lying about the file size, such 
as proc or some compressed fs. There may also be issues with some 
network fs.

A tail <file> with <file> of len 0, would usually be empty. However, it 
would be a problem not to provide an output for tail /proc/$$/status



PS: tail -f already acts a bit funny in that case, as it tails the end 
of the file, then thinks it has been truncated and shows it in full.

