Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcbbj.dreamhost.com ([208.97.132.119]:36184 "EHLO
	homiemail-a7.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753893Ab1HQOWr (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 17 Aug 2011 10:22:47 -0400
Subject: Re: losetup --all --verbose results in usage
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: util-linux@vger.kernel.org
In-Reply-To: <4E4BCC65.2060100@bernhard-voelker.de>
References: <4E4BCC65.2060100@bernhard-voelker.de>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 17 Aug 2011 10:22:21 -0400
Message-ID: <1313590941.2653.1.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, 2011-08-17 at 16:12 +0200, Bernhard Voelker wrote:
> I was surprised that running
> 	mount/losetup --all --verbose
> results in usage().
> 
> As -a is the option to list all used loop devices,
> one might think that -v adds some more info to the output.
> 

The verbose option is quite broken, yes.

> Neither --help nor the man pages nor the info page tells
> that -a doesn't accept other options:
> 
> mount/lomount.c (line 1133):
> 
>          } else if (all) {
>                  if (argc > 2)
>                          usage(stderr);
> 
> Should we work on this?

I'm actually rewriting this tool to make use of our new loop library.
I'll address this issue here as well, thanks for the heads up.

- Davidlohr

