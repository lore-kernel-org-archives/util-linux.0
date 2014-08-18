Return-Path: util-linux-owner@vger.kernel.org
Received: from ishtar.tlinx.org ([173.164.175.65]:34217 "EHLO
	Ishtar.hs.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705AbaHRTT2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 18 Aug 2014 15:19:28 -0400
Message-ID: <53F251B0.9010209@tlinx.org>
Date: Mon, 18 Aug 2014 12:19:12 -0700
From: Linda Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: "Dale R. Worley" <worley@alum.mit.edu>
CC: util-linux@vger.kernel.org
Subject: Re: Utilities don't take into account capabilities
References: <fbcec6cf5352.53efd3e4@langara.bc.ca> <53F11687.5060805@tlinx.org> <fb20984219ad.53f14f7a@langara.bc.ca> <53F15592.9020403@tlinx.org> <201408181447.s7IElKIT020343@hobgoblin.ariadne.com>
In-Reply-To: <201408181447.s7IElKIT020343@hobgoblin.ariadne.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Dale R. Worley wrote:
>
> I believe there's a complication...  I'm no expert, but I vaguely
> recall from some previous thread that there are situations where
> 'mount' isn't purely a front-end for the kernel mount() call.
> Instead, 'mount' wants to set up some things and then call mount().
>
> The example that comes to mind is setting up a file on a loopback
> device, then mounting the loopback device.  But I think there were
> other situations like this.
----
    In such cases, to execute the operation, check the max caps needed
to perform the operation. 
>
> The problem being, that 'mount' wants to verify that the mount() call
> will succeed *first* before attempting the set-up operations.  And
> some of the setup operations require root capabilities.
>
> There's also the complication of the "users" and "user=" options,
> which are to permit a user to do something he doesn't actually have
> the capabilities for.
----
      Separate issue.  I.e. should permission come from the entry in 
'fstab', or
should it come from what logins are set w/what caps.  I think (?) from 
historical
perspectives, the user is enabled to perform a specific operation if 
they are specifically
mentioned.  Else, go/w caps user has to complete successful operation.

    Would that cover it?


