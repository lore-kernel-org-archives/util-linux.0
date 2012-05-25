Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:36781 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757065Ab2EYJzo (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 25 May 2012 05:55:44 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 8FF5E9AC4B
	for <util-linux@vger.kernel.org>; Fri, 25 May 2012 11:55:43 +0200 (CEST)
Message-ID: <4FBF571B.9080905@suse.de>
Date: Fri, 25 May 2012 11:55:39 +0200
From: Ludwig Nussel <ludwig.nussel@suse.de>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Re: [PULL] su
References: <4FBE3059.3030806@suse.de> <20120525074111.GB1177@x2.net.home>
In-Reply-To: <20120525074111.GB1177@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> On Thu, May 24, 2012 at 02:58:01PM +0200, Ludwig Nussel wrote:
>> coreutils isn't really interested in maintaining su anymore.
>> Distributions have to add custom patches to fix bugs and add
>> features. The worst offender is probably the pam patch. Fortunately
>> we managed to sync the patch between openSUSE and Fedora meanwhile.
>> Over time the risk that the patches divert again increases though.
>> Since util-linux now contains a common login program it looks like a
>> good new home for su too.
> [...]
>  It would be nice to cleanup the code (remove non-PAM stuff) before
>  merge. Can you do this in your su branch? Please.

Done.

cu
Ludwig

-- 
 (o_   Ludwig Nussel
 //\
 V_/_  http://www.suse.de/
SUSE LINUX Products GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imendörffer, HRB 16746 (AG Nürnberg) 
