Return-Path: util-linux-owner@vger.kernel.org
Received: from smtprelay-h22.telenor.se ([195.54.99.197]:35151 "EHLO
	smtprelay-h22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756086AbbA2Clj (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 28 Jan 2015 21:41:39 -0500
Received: from ipb4.telenor.se (ipb4.telenor.se [195.54.127.167])
	by smtprelay-h22.telenor.se (Postfix) with ESMTP id C44B1C0D2
	for <util-linux@vger.kernel.org>; Wed, 28 Jan 2015 14:31:27 +0100 (CET)
Date: Wed, 28 Jan 2015 14:31:19 +0100
From: Andreas Henriksson <andreas@fatal.se>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org, Aurelien Jarno <aurelien@aurel32.net>
Subject: Re: test fdisk/bsd on exotic archs
Message-ID: <20150128133119.GA11744@fatal.se>
References: <201501281145.21775.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201501281145.21775.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello Ruediger Meier.

Thanks for your interest in fixing remaining test failures.

On Wed, Jan 28, 2015 at 11:45:20AM +0100, Ruediger Meier wrote:
[...]
> Aurelien or Andreas, do you still have such a system for this case?
[...]

I never had any other access then what is provided as Debian porter boxes.
(That is also why I patched the build system to output more information
about the failure and the diff between expected and output so I could
debug it via build logs.)
My interest in exotic architectures is also limited. I was very happy
to get Aureliens help with similar issues in the past. He's the man you
want to talk to rather then me.....

Regards,
Andreas Henriksson
