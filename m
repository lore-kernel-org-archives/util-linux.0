Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.17.13]:60794 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755392AbaGaF5g (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 31 Jul 2014 01:57:36 -0400
Message-ID: <53D9DACD.8050902@bernhard-voelker.de>
Date: Thu, 31 Jul 2014 07:57:33 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] tests: fix rename subdir check that was failing in
 travis
References: <1406756671-26805-1-git-send-email-kerolasa@iki.fi> <1406756671-26805-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1406756671-26805-2-git-send-email-kerolasa@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 07/30/2014 11:44 PM, Sami Kerola wrote:
> +readlink: extra operand `rename_aa/sublink.2'
> +Try `readlink --help' for more information.
> 
> The commit 0f85e0535bd4e6d19fadca182e4d57660b6bb57b introduced the travis
> realpath issue to happen.

s/realpath/readlink/
These are different programs. ;-)

Thanks & have a nice day,
Berny
