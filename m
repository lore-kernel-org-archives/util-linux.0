Return-Path: util-linux-owner@vger.kernel.org
Received: from mta03.eastlink.ca ([24.224.136.9]:55398 "EHLO mta03.eastlink.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751225AbbASV1T (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 19 Jan 2015 16:27:19 -0500
Received: from cmgw04.eastlink.ca ([71.7.199.170])
 by mta03.eastlink.ca (Oracle Communications Messaging Exchange Server
 7u4-21.01 64bit (built Feb 16 2011))
 with ESMTP id <0NIF00JRRC3AKJ30@mta03.eastlink.ca> for
 util-linux@vger.kernel.org; Mon, 19 Jan 2015 17:27:18 -0400 (AST)
Date: Mon, 19 Jan 2015 17:27:18 -0400
To: Benno Schulenberg <bensberg@justemail.net>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH V3] docs: fix grammar and punctuation and typos in 2.26
	release notes
Message-id: <20150119212718.GZ29504@cordes.ca>
References: <1421348945-2329-1-git-send-email-bensberg@justemail.net>
 <1421701703-2129-1-git-send-email-bensberg@justemail.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
In-reply-to: <1421701703-2129-1-git-send-email-bensberg@justemail.net>
From: Peter Cordes <peter@cordes.ca>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jan 19, 2015 at 10:08:23PM +0100, Benno Schulenberg wrote:
> Also trim some trailing whitespace.
> 
> Reviewed-by: Peter Cordes <peter@cordes.ca>
> Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
> ---
>  Documentation/releases/v2.26-ReleaseNotes |   74 ++++++++++++++--------------
>  1 files changed, 37 insertions(+), 37 deletions(-)
> 
> diff --git a/Documentation/releases/v2.26-ReleaseNotes b/Documentation/releases/v2.26-ReleaseNotes
> index b7712f7..655aebe 100644
> --- a/Documentation/releases/v2.26-ReleaseNotes
> +++ b/Documentation/releases/v2.26-ReleaseNotes
> @@ -1,29 +1,29 @@
>  Util-linux 2.26 Release Notes
>  =============================
>  
> - This version provides completely new sfdisk(8) command, the new version is
> - based on libfdisk. If your use-cases depend on sfdisk(8) then it is strongly
> + This version provides a completely new sfdisk(8) command; the new version is
> + based on libfdisk. If your use cases depend on sfdisk(8), then it is strongly
>   recommended to be careful and re-test your scripts. The new version supports
> - MBR and GPT disk labels (SGI and SUN are also supported but no well tested).
> - The new version does no more support some obscure MBR specific command line
> - options and legacy CHS addressing.
> + MBR and GPT disk labels (SGI and SUN are also supported but not well tested).
> + The new version no longer supports some obscure MBR-specific command-line
> + options nor legacy CHS addressing.

 I think it's still not quite proper English, and might be worse.  I
think you might technically need an "either" to introduce the list, to
make "no longer supports" apply to "MBR opts or CHS addressing".  Like
a map operator.  But I'm not sure, and I don't want to take the time to
track it down.

 It doesn't really matter.  Leave it, or go back to "and", and people
will understand the "foreigner speak" if they notice a problem at all. :P

 Or change it to:

+ The new version drops support for some obscure MBR-specific command-line
+ options and legacy CHS addressing.

 I think that's fine without an "either" or a "both", but I can't
explain why.  Oh, the problems of knowing English without having been
formally taught all the grammar rules.  If I'd gone to school decades
earlier than I did, I'm sure I would have been taught all this stuff
formally. :P

-- 
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@cor , des.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BC
