Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([217.72.192.73]:54395 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751320AbcKQHWx (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 17 Nov 2016 02:22:53 -0500
Subject: Re: [PATCH 4/5] build-sys: remove old git fallback from
 git-version-gen
To: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org
References: <1479348602-31744-1-git-send-email-sweet_f_a@gmx.de>
 <1479348602-31744-4-git-send-email-sweet_f_a@gmx.de>
From: Bernhard Voelker <mail@bernhard-voelker.de>
Message-ID: <43681c47-6153-3100-7582-c41e7ea89d7e@bernhard-voelker.de>
Date: Thu, 17 Nov 2016 08:22:49 +0100
MIME-Version: 1.0
In-Reply-To: <1479348602-31744-4-git-send-email-sweet_f_a@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 11/17/2016 03:10 AM, Ruediger Meier wrote:
> Just make the script more readable. Nobody is using 10 years old
> git.
> 
> Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
> ---
>  tools/git-version-gen | 21 ---------------------
>  1 file changed, 21 deletions(-)

Is there any particular reason not to sync from latest
upstream (again)?

http://g.sv.gnu.org/cgit/gnulib.git/tree/build-aux/git-version-gen

Have a nice day,
Berny

