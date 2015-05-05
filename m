Return-Path: util-linux-owner@vger.kernel.org
Received: from mail2.vodafone.ie ([213.233.128.44]:15645 "EHLO
	mail2.vodafone.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532AbbEEKr2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 5 May 2015 06:47:28 -0400
Message-ID: <55489D6D.9010303@draigBrady.com>
Date: Tue, 05 May 2015 11:37:33 +0100
From: =?windows-1252?Q?P=E1draig_Brady?= <P@draigBrady.com>
MIME-Version: 1.0
To: Mike Frysinger <vapier@gentoo.org>, util-linux@vger.kernel.org
Subject: Re: [PATCH] build-sys: fix parallel builds w/setarch links
References: <1430711464-4943-1-git-send-email-vapier@gentoo.org>
In-Reply-To: <1430711464-4943-1-git-send-email-vapier@gentoo.org>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 04/05/15 04:51, Mike Frysinger wrote:
> From: Mike Frysinger <vapier@chromium.org>
> 
> The symlink generation tries to write to the sys-utils/ subdir but does
> not make sure that dir exists.  This can sometimes lead to parallel build
> failures when building out-of-tree

>  $(SETARCH_MAN_LINKS):
> +	$(AM_V_at) test -d $(dir $@) || mkdir -p $(dir $@)
>  	$(AM_V_GEN)echo ".so man8/setarch.8" > $@
>  
>  install-exec-hook-setarch:

The `test -d ... ||` bit is racy and redundant I think

cheers,
Pádraig

