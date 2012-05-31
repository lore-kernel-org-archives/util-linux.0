Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:35224 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757987Ab2EaIGV (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Thu, 31 May 2012 04:06:21 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id D60909B119
	for <util-linux-ng@vger.kernel.org>; Thu, 31 May 2012 10:06:20 +0200 (CEST)
Message-ID: <4FC72679.7050307@suse.de>
Date: Thu, 31 May 2012 10:06:17 +0200
From: Ludwig Nussel <ludwig.nussel@suse.de>
MIME-Version: 1.0
To: util-linux-ng@vger.kernel.org
Subject: Re: [pull] su.1 manual page
References: <CAG27Bk3YrUc4cwpUou5o005S165LOc4C8bPHp-EnkwAz2WsFng@mail.gmail.com>
In-Reply-To: <CAG27Bk3YrUc4cwpUou5o005S165LOc4C8bPHp-EnkwAz2WsFng@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Sami Kerola wrote:
> Please find from my git a su(1) manual page candidate.  The text is
> almost one to one copy with GNU Coreutils 'su invocation' info page,
> so it is questionable if I "wrote" the man page.  To feel a little

Hmm, I was about to write a man page from scratch. Should I continue or
do we use the coreutils man page?

cu
Ludwig

PS: the section about the wheel group can be removed :)

-- 
 (o_   Ludwig Nussel
 //\
 V_/_  http://www.suse.de/
SUSE LINUX Products GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imendörffer, HRB 16746 (AG Nürnberg) 
