Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:58686 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751989Ab2E2MPg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 29 May 2012 08:15:36 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id D165896DF4
	for <util-linux@vger.kernel.org>; Tue, 29 May 2012 14:15:35 +0200 (CEST)
Message-ID: <4FC4BDE1.7000303@suse.de>
Date: Tue, 29 May 2012 14:15:29 +0200
From: Ludwig Nussel <ludwig.nussel@suse.de>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Re: su(1) wish list
References: <4FBE3059.3030806@suse.de> <20120529090609.GO3757@x2.net.home> <20120529113418.GB374@x2.net.home>
In-Reply-To: <20120529113418.GB374@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> On Tue, May 29, 2012 at 11:06:09AM +0200, Karel Zak wrote:
>> On Thu, May 24, 2012 at 02:58:01PM +0200, Ludwig Nussel wrote:
>>> I've also filed a pull request on github:
>>> https://github.com/karelzak/util-linux/pull/10
>>
>>  Merged, but you forgot man page ;-) I don't think we need whole
>>  history for the man page, so just copy and edit any existing su.1
>>  man page and send it as a patch.

The su man page from coreutils is pretty brief. More docu is in the
info page. The license is the FDL, would that be ok or would a new
man page from scratch be better? Or maybe the one from shadow-utils?

> another issue:
> 
>   - why su.c expects "PATH" and "SUPATH" login default variables, but
>     login.c expects "ENV_PATH" and "ENV_SUPATH"?
> 
>     See also login.def man page from shadow-utils where ENV_* is
>     documented (for login as well as for su).
> 
>     IMHO we need to share the configuration between login and su.

No idea why it is different. Probably legacy stuff. I see no reason
why to use different values than login though.

> and wish list:

ACK

cu
Ludwig

-- 
 (o_   Ludwig Nussel
 //\
 V_/_  http://www.suse.de/
SUSE LINUX Products GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imendörffer, HRB 16746 (AG Nürnberg) 
