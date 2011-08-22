Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:56169 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750920Ab1HVLTp (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 22 Aug 2011 07:19:45 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 2E9158E857
	for <util-linux@vger.kernel.org>; Mon, 22 Aug 2011 13:19:45 +0200 (CEST)
Message-ID: <4E523B50.8080204@suse.de>
Date: Mon, 22 Aug 2011 13:19:44 +0200
From: Ludwig Nussel <ludwig.nussel@suse.de>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Cc: Thorsten Kukuk <kukuk@suse.de>
Subject: Re: PAM-only login(1)
References: <20110812115758.GC1843@nb.net.home>
In-Reply-To: <20110812115758.GC1843@nb.net.home>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
>   I'd like to clean up login(1) code for v2.21. The current code is
>   mess with many #ifdef and support for some unused (and badly tested) 
>   features (e.g. non-PAM support for /etc/securetty and /etc/usertty).
> 
>   What about to finally create nice and readable PAM-only login(1) for
>   Linux?

+1

On openSUSE we already use a pam-only login program¹. It was forked
from util-linux > ten years ago AFAICT. It also includes features
from shadow-utils, like reading settings from /etc/login.defs.

cu
Ludwig

[1] https://build.opensuse.org/package/files?package=login&project=Base%3ASystem

-- 
 (o_   Ludwig Nussel
 //\
 V_/_  http://www.suse.de/
SUSE LINUX Products GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imendörffer, HRB 16746 (AG Nürnberg) 
