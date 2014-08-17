Return-Path: util-linux-owner@vger.kernel.org
Received: from ishtar.tlinx.org ([173.164.175.65]:54036 "EHLO
	Ishtar.hs.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391AbaHQUyu (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 17 Aug 2014 16:54:50 -0400
Message-ID: <53F11687.5060805@tlinx.org>
Date: Sun, 17 Aug 2014 13:54:31 -0700
From: Linda Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
CC: Steven Stewart-Gallus <sstewartgallus00@mylangara.bc.ca>
Subject: Re: Utilities don't take into account capabilities
References: <fbcec6cf5352.53efd3e4@langara.bc.ca>
In-Reply-To: <fbcec6cf5352.53efd3e4@langara.bc.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Steven Stewart-Gallus wrote:
> The utilities such as mount don't take into account capabilities and always fail
> for non root users which is wrong.
>
> This is really, really, really annoying when working in a sandboxed non root
> shell with pseudo capabilities.
----
I was just going to ask what capabilities need to be set for mount to work.

Seriously... What capabilities does mount need in order to function?


If this is in the 'util-linux', shouldn't these be utilities for 
linux?   I.e.
the default linux kernel supports capabilities these days...no?



